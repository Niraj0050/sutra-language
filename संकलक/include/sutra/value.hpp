#ifndef SUTRA_VALUE_HPP
#define SUTRA_VALUE_HPP

#include <string>
#include <variant>
#include <memory>
#include <cstdint>

#include <vector>
#include <unordered_map>

namespace sutra {

enum class ValueType { INT, FLOAT, STRING, BOOL, NULL_VAL, RETURN_SIGNAL, BREAK_SIGNAL, CONTINUE_SIGNAL, LIST, OBJECT };

struct SutraValue {
    ValueType type{ValueType::NULL_VAL};
    int64_t int_val{0};
    double float_val{0.0};
    std::string string_val;
    bool bool_val{false};
    std::shared_ptr<SutraValue> return_payload; // For return statement evaluation
    std::vector<SutraValue> list_val;           // For lists/arrays
    std::string class_name;
    std::shared_ptr<std::unordered_map<std::string, SutraValue>> fields; // For OOP objects

    static SutraValue make_int(int64_t v) {
        SutraValue val; val.type = ValueType::INT; val.int_val = v; return val;
    }
    static SutraValue make_float(double v) {
        SutraValue val; val.type = ValueType::FLOAT; val.float_val = v; return val;
    }
    static SutraValue make_string(std::string v) {
        SutraValue val; val.type = ValueType::STRING; val.string_val = std::move(v); return val;
    }
    static SutraValue make_bool(bool v) {
        SutraValue val; val.type = ValueType::BOOL; val.bool_val = v; return val;
    }
    static SutraValue make_null() {
        SutraValue val; val.type = ValueType::NULL_VAL; return val;
    }
    static SutraValue make_list(std::vector<SutraValue> elements) {
        SutraValue val; val.type = ValueType::LIST; val.list_val = std::move(elements); return val;
    }
    static SutraValue make_object(std::string cls_name, std::shared_ptr<std::unordered_map<std::string, SutraValue>> flds) {
        SutraValue val; val.type = ValueType::OBJECT; val.class_name = std::move(cls_name); val.fields = std::move(flds); return val;
    }
    static SutraValue make_return(SutraValue ret) {
        SutraValue val; val.type = ValueType::RETURN_SIGNAL;
        val.return_payload = std::make_shared<SutraValue>(std::move(ret));
        return val;
    }
    static SutraValue make_break() {
        SutraValue val; val.type = ValueType::BREAK_SIGNAL; return val;
    }
    static SutraValue make_continue() {
        SutraValue val; val.type = ValueType::CONTINUE_SIGNAL; return val;
    }

    std::string to_string() const;
    bool is_truthy() const;
};

} // namespace sutra

#endif // SUTRA_VALUE_HPP
