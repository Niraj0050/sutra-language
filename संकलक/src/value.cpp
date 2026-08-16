#include "sutra/value.hpp"
#include "sutra/memory.hpp"

namespace sutra {

SutraValue SutraValue::make_string(std::string v) {
    SutraValue val;
    val.type = ValueType::STRING;
    val.string_val = std::move(v);
    val.heap_address = MemoryModelRegistry::get_instance().get_heap_manager().allocate(
        DataType::PAATH,
        val.string_val.size(),
        "String content: '" + val.string_val + "'"
    );
    return val;
}

SutraValue SutraValue::make_list(std::vector<SutraValue> elements) {
    SutraValue val;
    val.type = ValueType::LIST;
    val.list_shared = std::make_shared<std::vector<SutraValue>>(std::move(elements));
    val.heap_address = MemoryModelRegistry::get_instance().get_heap_manager().allocate(
        DataType::UNKNOWN,
        val.list_shared->size() * sizeof(SutraValue),
        "List/Array elements"
    );
    return val;
}

SutraValue SutraValue::shallow_copy() const {
    SutraValue copy;
    copy.type = type;
    copy.int_val = int_val;
    copy.float_val = float_val;
    copy.string_val = string_val;
    copy.bool_val = bool_val;
    copy.heap_address = heap_address;
    copy.return_payload = return_payload;
    copy.class_name = class_name;
    copy.fields = fields;
    copy.dict_val = dict_val;
    // Share the same underlying list data (reference semantics)
    if (list_shared) {
        copy.list_shared = list_shared;
    } else if (type == ValueType::LIST) {
        // Promote list_val to shared, then share it
        copy.list_shared = std::make_shared<std::vector<SutraValue>>(list_val);
    }
    return copy;
}

std::vector<SutraValue>& SutraValue::get_list() {
    if (list_shared) return *list_shared;
    return list_val;
}

const std::vector<SutraValue>& SutraValue::get_list() const {
    if (list_shared) return *list_shared;
    return list_val;
}

SutraValue SutraValue::make_object(std::string cls_name, std::shared_ptr<std::unordered_map<std::string, SutraValue>> flds) {
    SutraValue val;
    val.type = ValueType::OBJECT;
    val.class_name = std::move(cls_name);
    val.fields = std::move(flds);
    val.heap_address = MemoryModelRegistry::get_instance().get_heap_manager().allocate(
        DataType::UNKNOWN,
        val.fields ? val.fields->size() * sizeof(SutraValue) : 0,
        "Object instance of: " + val.class_name
    );
    return val;
}

SutraValue SutraValue::make_dict(std::shared_ptr<std::unordered_map<std::string, SutraValue>> dict) {
    SutraValue val;
    val.type = ValueType::DICTIONARY;
    val.dict_val = std::move(dict);
    val.heap_address = MemoryModelRegistry::get_instance().get_heap_manager().allocate(
        DataType::SHABDAKOSH,
        val.dict_val ? val.dict_val->size() * sizeof(SutraValue) : 0,
        "Dictionary instance"
    );
    return val;
}

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
            const auto& list = get_list();
            std::string res = "[";
            for (size_t i = 0; i < list.size(); ++i) {
                if (i > 0) res += ", ";
                res += list[i].to_string();
            }
            res += "]";
            return res;
        }
        case ValueType::OBJECT: {
            return "<" + class_name + " वस्तु>";
        }
        case ValueType::DICTIONARY: {
            if (!dict_val) return "{}";
            std::string res = "{";
            bool first = true;
            for (const auto& pair : *dict_val) {
                if (!first) res += ", ";
                res += "\"" + pair.first + "\": " + pair.second.to_string();
                first = false;
            }
            res += "}";
            return res;
        }
        case ValueType::RETURN_SIGNAL:
            if (return_payload) return return_payload->to_string();
            return "शून्यम्";
        case ValueType::CHAR:
            return string_val;
    }
    return "शून्यम्";
}

bool SutraValue::is_truthy() const {
    switch (type) {
        case ValueType::INT: return int_val != 0;
        case ValueType::FLOAT: return float_val != 0.0;
        case ValueType::STRING: return !string_val.empty();
        case ValueType::BOOL: return bool_val;
        case ValueType::LIST: return !get_list().empty();
        case ValueType::OBJECT: return fields != nullptr;
        case ValueType::DICTIONARY: return dict_val != nullptr && !dict_val->empty();
        case ValueType::NULL_VAL: return false;
        case ValueType::CHAR: return !string_val.empty();
        default: return false;
    }
}

} // namespace sutra
