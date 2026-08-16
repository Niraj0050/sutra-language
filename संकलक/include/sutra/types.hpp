#ifndef SUTRA_TYPES_HPP
#define SUTRA_TYPES_HPP

#include <string>

namespace sutra {

enum class DataType {
    POORNAK,        // पूर्णांक (32-bit signed int, 4 bytes)
    BADA_POORNAK,   // बड़ा_पूर्णांक (64-bit signed int, 8 bytes)
    DASHAMLAV,      // दशमलव (64-bit float, 8 bytes)
    TARK,           // तर्क (bool, 1 byte)
    AKSHAR,         // अक्षर (Unicode character, 4 bytes)
    PAATH,          // पाठ (string, 8 bytes)
    SHABDAKOSH,     // शब्दकोश (dictionary, 8 bytes)
    RIKT,           // रिक्त (void / null, 0 bytes)
    UNKNOWN         // dynamic / untyped
};

struct TypeInfo {
    DataType type;
    std::string name; // Hindi name
    size_t size;      // in bytes
    size_t alignment; // in bytes

    bool is_numeric() const {
        return type == DataType::POORNAK || type == DataType::BADA_POORNAK || type == DataType::DASHAMLAV;
    }
    bool is_integer() const {
        return type == DataType::POORNAK || type == DataType::BADA_POORNAK;
    }
    bool is_floating_point() const {
        return type == DataType::DASHAMLAV;
    }
    bool is_boolean() const {
        return type == DataType::TARK;
    }
    bool is_character() const {
        return type == DataType::AKSHAR;
    }
    bool is_string() const {
        return type == DataType::PAATH;
    }
    bool is_void() const {
        return type == DataType::RIKT;
    }
};

const TypeInfo& get_type_info(DataType type);
DataType parse_type_name(const std::string& name);
std::string data_type_to_string(DataType type);
bool is_assignable(DataType target, DataType source);
size_t align_offset(size_t offset, size_t alignment);

} // namespace sutra

#endif // SUTRA_TYPES_HPP
