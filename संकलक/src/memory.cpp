#include "sutra/memory.hpp"
#include <algorithm>

namespace sutra {

std::string memory_region_to_string(MemoryRegion region) {
    switch (region) {
        case MemoryRegion::STACK: return "STACK";
        case MemoryRegion::HEAP: return "HEAP";
        case MemoryRegion::STATIC: return "STATIC";
        case MemoryRegion::NONE: return "NONE";
    }
    return "NONE";
}

StackFrame::StackFrame(std::string function_name)
    : m_function_name(std::move(function_name)) {}

void StackFrame::add_variable(const std::string& name, DataType type, size_t scope_depth) {
    if (m_variable_indices.find(name) != m_variable_indices.end()) {
        return;
    }

    const TypeInfo& info = get_type_info(type);
    size_t size = info.size;
    size_t alignment = info.alignment;

    bool is_ref = (type == DataType::PAATH || type == DataType::RIKT || type == DataType::UNKNOWN);
    MemoryRegion region = MemoryRegion::STACK; // Store slot is on STACK

    size_t aligned_offset = align_offset(m_frame_size, alignment);
    
    VariableLayout layout{
        name,
        type,
        size,
        alignment,
        aligned_offset,
        region,
        scope_depth,
        is_ref
    };

    m_variable_indices[name] = m_variables.size();
    m_variables.push_back(layout);

    m_frame_size = aligned_offset + size;
}

const VariableLayout* StackFrame::get_variable(const std::string& name) const {
    auto it = m_variable_indices.find(name);
    if (it != m_variable_indices.end()) {
        return &m_variables[it->second];
    }
    return nullptr;
}

HeapManager::HeapManager() {
    clear();
}

uint64_t HeapManager::allocate(DataType type, size_t size, std::string metadata) {
    uint64_t addr = m_next_address;
    m_allocations.push_back(HeapObject{addr, type, size, true, std::move(metadata)});
    m_next_address += align_offset(size, 8);
    return addr;
}

void HeapManager::release(uint64_t address) {
    for (auto& obj : m_allocations) {
        if (obj.address == address) {
            obj.is_active = false;
            break;
        }
    }
}

const HeapObject* HeapManager::get_object(uint64_t address) const {
    for (const auto& obj : m_allocations) {
        if (obj.address == address) {
            return &obj;
        }
    }
    return nullptr;
}

void HeapManager::clear() {
    m_allocations.clear();
    m_next_address = 0x1000;
}

void HeapManager::mark(uint64_t address) {
    for (auto& obj : m_allocations) {
        if (obj.address == address) {
            obj.marked = true;
            break;
        }
    }
}

void HeapManager::reset_marks() {
    for (auto& obj : m_allocations) {
        obj.marked = false;
    }
}

size_t HeapManager::sweep() {
    size_t collected = 0;
    for (auto& obj : m_allocations) {
        if (obj.is_active && !obj.marked) {
            obj.is_active = false;
            collected++;
        }
    }
    return collected;
}

void MemoryModelRegistry::push_frame(std::string function_name) {
    m_frames.push_back(std::make_unique<StackFrame>(std::move(function_name)));
}

void MemoryModelRegistry::pop_frame() {
    if (!m_frames.empty()) {
        m_frames.pop_back();
    }
}

StackFrame* MemoryModelRegistry::get_current_frame() {
    if (m_frames.empty()) return nullptr;
    return m_frames.back().get();
}

StackFrame* MemoryModelRegistry::get_frame(const std::string& name) {
    for (const auto& f : m_frames) {
        if (f->get_function_name() == name) {
            return f.get();
        }
    }
    return nullptr;
}

void MemoryModelRegistry::reset() {
    m_frames.clear();
    m_heap_manager.clear();
}

} // namespace sutra
