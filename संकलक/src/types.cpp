#include "sutra/types.hpp"
#include <unordered_map>

namespace sutra {

const TypeInfo& get_type_info(DataType type) {
    static const TypeInfo infos[] = {
        {DataType::POORNAK, "पूर्णांक", 4, 4},
        {DataType::BADA_POORNAK, "बड़ा_पूर्णांक", 8, 8},
        {DataType::DASHAMLAV, "दशमलव", 8, 8},
        {DataType::TARK, "तर्क", 1, 1},
        {DataType::AKSHAR, "अक्षर", 4, 4},
        {DataType::PAATH, "पाठ", 8, 8},
        {DataType::RIKT, "रिक्त", 0, 1},
        {DataType::UNKNOWN, "अज्ञात", 0, 1}
    };
    return infos[static_cast<int>(type)];
}

DataType parse_type_name(const std::string& name) {
    static const std::unordered_map<std::string, DataType> type_map = {
        {"पूर्णांक", DataType::POORNAK},
        {"बड़ा_पूर्णांक", DataType::BADA_POORNAK},
        {"दशमलव", DataType::DASHAMLAV},
        {"तर्क", DataType::TARK},
        {"अक्षर", DataType::AKSHAR},
        {"पाठ", DataType::PAATH},
        {"रिक्त", DataType::RIKT},
        {"संख्या", DataType::POORNAK}, // Compatibility mapping
        {"बूल", DataType::TARK},      // Compatibility mapping
        {"मान", DataType::UNKNOWN}
    };
    auto it = type_map.find(name);
    if (it != type_map.end()) {
        return it->second;
    }
    return DataType::UNKNOWN;
}

std::string data_type_to_string(DataType type) {
    return get_type_info(type).name;
}

bool is_assignable(DataType target, DataType source) {
    if (target == DataType::UNKNOWN || source == DataType::UNKNOWN) return true;
    if (target == source) return true;
    if (source == DataType::RIKT) return true; // शून्यम् (null) is assignable to any variable
    if (target == DataType::BADA_POORNAK && source == DataType::POORNAK) return true;
    if (target == DataType::DASHAMLAV && (source == DataType::POORNAK || source == DataType::BADA_POORNAK)) return true;
    return false;
}

size_t align_offset(size_t offset, size_t alignment) {
    if (alignment == 0) return offset;
    size_t remainder = offset % alignment;
    if (remainder == 0) return offset;
    return offset + (alignment - remainder);
}

} // namespace sutra
