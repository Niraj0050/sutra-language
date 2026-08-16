#ifndef SUTRA_GC_HPP
#define SUTRA_GC_HPP

#include "sutra/memory.hpp"
#include "sutra/value.hpp"
#include "sutra/environment.hpp"
#include <vector>
#include <memory>

namespace sutra {

struct GCStats {
    size_t cycles{0};
    size_t total_allocations{0};
    size_t active_objects{0};
    size_t collected_objects{0};
    size_t bytes_allocated{0};
    size_t bytes_reclaimed{0};
};

class GarbageCollector {
public:
    static GarbageCollector& get_instance() {
        static GarbageCollector instance;
        return instance;
    }

    void register_environment(Environment* env);
    void unregister_environment(Environment* env);

    void collect();
    void check_and_collect();

    void enable_logging(bool enable) { m_logging_enabled = enable; }
    const GCStats& get_stats() const { return m_stats; }
    void print_stats() const;
    void reset();

    void push_exception(const SutraValue& val) { m_active_exceptions.push_back(val); }
    void pop_exception() { if (!m_active_exceptions.empty()) m_active_exceptions.pop_back(); }

private:
    GarbageCollector() = default;

    std::vector<Environment*> m_active_environments;
    std::vector<SutraValue> m_active_exceptions;
    GCStats m_stats;
    bool m_logging_enabled{false};
    size_t m_alloc_count_since_last_gc{0};
    const size_t GC_THRESHOLD{10};
};

} // namespace sutra

#endif // SUTRA_GC_HPP
