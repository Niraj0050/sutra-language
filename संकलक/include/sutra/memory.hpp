#ifndef SUTRA_MEMORY_HPP
#define SUTRA_MEMORY_HPP

#include "sutra/types.hpp"
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>
#include <cstdint>

namespace sutra {

enum class MemoryRegion {
    STACK,
    HEAP,
    STATIC,
    NONE
};

std::string memory_region_to_string(MemoryRegion region);

struct VariableLayout {
    std::string name;
    DataType type;
    size_t size;
    size_t alignment;
    size_t offset;
    MemoryRegion region;
    size_t scope_depth;
    bool is_reference;
};

class StackFrame {
public:
    explicit StackFrame(std::string function_name);

    void add_variable(const std::string& name, DataType type, size_t scope_depth);
    const VariableLayout* get_variable(const std::string& name) const;
    
    size_t get_frame_size() const { return m_frame_size; }
    const std::string& get_function_name() const { return m_function_name; }
    const std::vector<VariableLayout>& get_variables() const { return m_variables; }

private:
    std::string m_function_name;
    std::vector<VariableLayout> m_variables;
    std::unordered_map<std::string, size_t> m_variable_indices;
    size_t m_frame_size{0};
};

struct HeapObject {
    uint64_t address;
    DataType type;
    size_t size;
    bool is_active;
    std::string metadata;
    bool marked{false};
};

class HeapManager {
public:
    HeapManager();
    
    uint64_t allocate(DataType type, size_t size, std::string metadata = "");
    void release(uint64_t address);
    
    const HeapObject* get_object(uint64_t address) const;
    const std::vector<HeapObject>& get_allocations() const { return m_allocations; }
    void clear();

    void mark(uint64_t address);
    void reset_marks();
    size_t sweep();

private:
    std::vector<HeapObject> m_allocations;
    uint64_t m_next_address{0x1000};
};

class MemoryModelRegistry {
public:
    static MemoryModelRegistry& get_instance() {
        static MemoryModelRegistry instance;
        return instance;
    }
    
    void push_frame(std::string function_name);
    void pop_frame();
    StackFrame* get_current_frame();
    StackFrame* get_frame(const std::string& name);
    
    HeapManager& get_heap_manager() { return m_heap_manager; }
    
    void reset();

private:
    MemoryModelRegistry() = default;
    std::vector<std::unique_ptr<StackFrame>> m_frames;
    HeapManager m_heap_manager;
};

} // namespace sutra

#endif // SUTRA_MEMORY_HPP
