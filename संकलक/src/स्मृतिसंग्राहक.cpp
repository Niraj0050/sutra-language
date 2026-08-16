#include "sutra/स्मृतिसंग्राहक.hpp"
#include "sutra/runtime/runtime.hpp"
#include <algorithm>
#include <iostream>
#include <unordered_set>

namespace sutra {

// Helper to recursively collect all reachable heap references from a SutraValue
static void collect_references(const SutraValue& val, std::vector<uint64_t>& refs, std::unordered_set<uint64_t>& visited) {
    if (val.heap_address != 0) {
        if (visited.find(val.heap_address) != visited.end()) {
            return;
        }
        visited.insert(val.heap_address);
        refs.push_back(val.heap_address);
    }
    if (val.type == ValueType::LIST) {
        for (const auto& elem : val.list_val) {
            collect_references(elem, refs, visited);
        }
    }
    if (val.type == ValueType::OBJECT && val.fields) {
        for (const auto& pair : *val.fields) {
            collect_references(pair.second, refs, visited);
        }
    }
    if (val.type == ValueType::DICTIONARY && val.dict_val) {
        for (const auto& pair : *val.dict_val) {
            collect_references(pair.second, refs, visited);
        }
    }
    if (val.type == ValueType::RETURN_SIGNAL && val.return_payload) {
        collect_references(*val.return_payload, refs, visited);
    }
}

void GarbageCollector::register_environment(Environment* env) {
    if (std::find(m_active_environments.begin(), m_active_environments.end(), env) == m_active_environments.end()) {
        m_active_environments.push_back(env);
    }
}

void GarbageCollector::unregister_environment(Environment* env) {
    m_active_environments.erase(
        std::remove(m_active_environments.begin(), m_active_environments.end(), env),
        m_active_environments.end()
    );
}

void GarbageCollector::collect() {
    auto& heap = MemoryModelRegistry::get_instance().get_heap_manager();
    heap.reset_marks();

    // 1. Root Set
    std::vector<uint64_t> roots;
    std::unordered_set<uint64_t> visited;
    for (Environment* env : m_active_environments) {
        if (env) {
            for (const auto& pair : env->get_values()) {
                collect_references(pair.second, roots, visited);
            }
        }
    }

    // Active Exceptions (in-flight during C++ unwinding)
    for (const auto& exc : m_active_exceptions) {
        collect_references(exc, roots, visited);
    }

    // 2. Mark Reachable Objects
    std::unordered_set<uint64_t> marked_set;
    for (uint64_t addr : roots) {
        marked_set.insert(addr);
        heap.mark(addr);
    }

    // 3. Sweep Unreachable Objects
    size_t collected = heap.sweep();

    // 4. Update Statistics
    m_stats.cycles++;
    m_stats.total_allocations = heap.get_allocations().size();

    size_t active = 0;
    size_t reclaimed_bytes = 0;
    size_t active_bytes = 0;
    for (const auto& obj : heap.get_allocations()) {
        if (obj.is_active) {
            active++;
            active_bytes += obj.size;
        } else {
            reclaimed_bytes += obj.size;
        }
    }

    m_stats.active_objects = active;
    m_stats.collected_objects = m_stats.total_allocations - active;
    m_stats.bytes_allocated = active_bytes + reclaimed_bytes;
    m_stats.bytes_reclaimed = reclaimed_bytes;

    if (m_logging_enabled) {
        print_stats();
    }
}

void GarbageCollector::check_and_collect() {
    m_alloc_count_since_last_gc++;
    if (m_alloc_count_since_last_gc >= GC_THRESHOLD) {
        collect();
        m_alloc_count_since_last_gc = 0;
    }
}

void GarbageCollector::print_stats() const {
    std::string stats_str = 
        "चक्र: " + std::to_string(m_stats.cycles) + "\n" +
        "सक्रिय: " + std::to_string(m_stats.active_objects) + "\n" +
        "संग्रहित: " + std::to_string(m_stats.collected_objects);
    runtime::Runtime::get_instance().write_line(stats_str);
}

void GarbageCollector::reset() {
    m_active_environments.clear();
    m_stats = GCStats{};
    m_alloc_count_since_last_gc = 0;
}

} // namespace sutra
