#include "sutra/value.hpp"

namespace sutra {

std::string SutraValue::to_string() const {
    switch (type) {
        case ValueType::INT:
            return std::to_string(int_val);
        case ValueType::FLOAT: {
            std::string s = std::to_string(float_val);
            // Trim trailing zeros after decimal point
            s.erase(s.find_last_not_of('0') + 1, std::string::npos);
            if (s.back() == '.') s.pop_back();
            return s;
        }
        case ValueType::STRING:
            return string_val;
        case ValueType::BOOL:
            return bool_val ? "सत्य" : "असत्य";
        case ValueType::NULL_VAL:
            return "शून्यम्";
        case ValueType::LIST: {
            std::string res = "[";
            for (size_t i = 0; i < list_val.size(); ++i) {
                if (i > 0) res += ", ";
                res += list_val[i].to_string();
            }
            res += "]";
            return res;
        }
        case ValueType::OBJECT: {
            return "<" + class_name + " वस्तु>";
        }
        case ValueType::RETURN_SIGNAL:
            if (return_payload) return return_payload->to_string();
            return "शून्यम्";
    }
    return "शून्यम्";
}

bool SutraValue::is_truthy() const {
    switch (type) {
        case ValueType::INT: return int_val != 0;
        case ValueType::FLOAT: return float_val != 0.0;
        case ValueType::STRING: return !string_val.empty();
        case ValueType::BOOL: return bool_val;
        case ValueType::LIST: return !list_val.empty();
        case ValueType::OBJECT: return fields != nullptr;
        case ValueType::NULL_VAL: return false;
        default: return false;
    }
}

} // namespace sutra
