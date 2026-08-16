#include "sutra/lexer.hpp"
#include "sutra/parser.hpp"
#include "sutra/semantic.hpp"
#include "sutra/interpreter.hpp"
#include "sutra/error.hpp"
#include "sutra/memory.hpp"
#include "sutra/स्मृतिसंग्राहक.hpp"
#include "sutra/runtime/runtime.hpp"
#include "sutra/runtime/io.hpp"
#include "sutra/runtime/environment.hpp"
#include "sutra/runtime/filesystem.hpp"

#include <iostream>
#include <sstream>
#include <cassert>

#ifdef _WIN32
#include <windows.h>
#endif

void test_lexer() {
    std::cout << "[परीक्षणम् 1] Lexer Test... ";
    std::string src = "कार्य मुख्य() { लिखतु(\"नमस्ते जगत्!\"); }";
    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();

    assert(tokens.size() >= 10);
    assert(tokens[0].type == sutra::TokenType::K_KARYA);
    assert(tokens[1].type == sutra::TokenType::K_MUKHYA);
    assert(tokens[2].type == sutra::TokenType::LPAREN);
    assert(tokens[3].type == sutra::TokenType::RPAREN);
    assert(tokens[4].type == sutra::TokenType::LBRACE);
    assert(tokens[5].type == sutra::TokenType::K_LIKHATU);
    assert(tokens[6].type == sutra::TokenType::LPAREN);
    assert(tokens[7].type == sutra::TokenType::STRING_LITERAL);
    assert(tokens[7].lexeme == "नमस्ते जगत्!");
    std::cout << "सफलम् (PASSED)\n";
}

void test_interpreter_namaste() {
    std::cout << "[परीक्षणम् 2] Execution Test (नमस्ते.सूत्र)... ";
    std::string src = "कार्य मुख्य() { लिखतु(\"नमस्ते जगत्!\"); }";

    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();
    sutra::Parser parser(tokens);
    auto program = parser.parse_program();

    sutra::SemanticAnalyzer analyzer;
    analyzer.analyze(*program);

    std::ostringstream out;
    sutra::Interpreter interpreter;
    interpreter.execute_program(*program, out);

    assert(out.str() == "नमस्ते जगत्!\n");
    std::cout << "सफलम् (PASSED)\n";
}

void test_interpreter_arithmetic() {
    std::cout << "[परीक्षणम् 3] Arithmetic Test (10 + 20)... ";
    std::string src = "कार्य मुख्य() { संख्या अ = 10; संख्या ब = 20; लिखतु(अ + ब); }";

    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();
    sutra::Parser parser(tokens);
    auto program = parser.parse_program();

    sutra::SemanticAnalyzer analyzer;
    analyzer.analyze(*program);

    std::ostringstream out;
    sutra::Interpreter interpreter;
    interpreter.execute_program(*program, out);

    assert(out.str() == "30\n");
    std::cout << "सफलम् (PASSED)\n";
}

void test_interpreter_conditional() {
    std::cout << "[परीक्षणम् 4] Conditional Test (यदि/अन्यथा)... ";
    std::string src = "कार्य मुख्य() { संख्या वयः = 22; यदि (वयः >= 18) { लिखतु(\"वयस्कः\"); } अन्यथा { लिखतु(\"अवयस्कः\"); } }";

    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();
    sutra::Parser parser(tokens);
    auto program = parser.parse_program();

    sutra::SemanticAnalyzer analyzer;
    analyzer.analyze(*program);

    std::ostringstream out;
    sutra::Interpreter interpreter;
    interpreter.execute_program(*program, out);

    assert(out.str() == "वयस्कः\n");
    std::cout << "सफलम् (PASSED)\n";
}

void test_interpreter_functions() {
    std::cout << "[परीक्षणम् 5] Function Test (कार्य जोड़ना)... ";
    std::string src = "कार्य जोड़ना(संख्या अ, संख्या ब) { परत् अ + ब; } कार्य मुख्य() { लिखतु(जोड़ना(15, 25)); }";

    sutra::Lexer lexer(src);
    auto tokens = lexer.tokenize();
    sutra::Parser parser(tokens);
    auto program = parser.parse_program();

    sutra::SemanticAnalyzer analyzer;
    analyzer.analyze(*program);

    std::ostringstream out;
    sutra::Interpreter interpreter;
    interpreter.execute_program(*program, out);

    assert(out.str() == "40\n");
    std::cout << "सफलम् (PASSED)\n";
}

void test_semantic_undefined_variable() {
    std::cout << "[परीक्षणम् 6] Semantic Error Test (अपरिभाषितः चरः)... ";
    std::string src = "कार्य मुख्य() { लिखतु(परिणामः); }";

    try {
        sutra::Lexer lexer(src);
        auto tokens = lexer.tokenize();
        sutra::Parser parser(tokens);
        auto program = parser.parse_program();

        sutra::SemanticAnalyzer analyzer;
        analyzer.analyze(*program);
        assert(false && "Should have thrown SemanticError");
    } catch (const sutra::SemanticError& err) {
        // Expected error
    }
    std::cout << "सफलम् (PASSED)\n";
}

void test_memory_model() {
    std::cout << "[परीक्षणम् 7] Memory Model Layout & Alignment Test... ";

    sutra::MemoryModelRegistry::get_instance().reset();

    // 1. Stack layout and alignments
    sutra::MemoryModelRegistry::get_instance().push_frame("test_fn");
    auto* frame = sutra::MemoryModelRegistry::get_instance().get_current_frame();
    assert(frame != nullptr);

    frame->add_variable("x_bool", sutra::DataType::TARK, 1);       // size 1, alignment 1, offset 0
    frame->add_variable("y_int", sutra::DataType::POORNAK, 1);     // size 4, alignment 4, offset 4 (padding of 3 bytes)
    frame->add_variable("z_big", sutra::DataType::BADA_POORNAK, 1); // size 8, alignment 8, offset 8
    frame->add_variable("w_char", sutra::DataType::AKSHAR, 1);    // size 4, alignment 4, offset 16
    frame->add_variable("v_str", sutra::DataType::PAATH, 1);      // size 8, alignment 8, offset 24 (padding of 4 bytes)

    const auto* x = frame->get_variable("x_bool");
    assert(x != nullptr);
    assert(x->offset == 0);
    assert(x->size == 1);

    const auto* y = frame->get_variable("y_int");
    assert(y != nullptr);
    assert(y->offset == 4); // Aligned to 4-byte boundary
    assert(y->size == 4);

    const auto* z = frame->get_variable("z_big");
    assert(z != nullptr);
    assert(z->offset == 8); // Aligned to 8-byte boundary
    assert(z->size == 8);

    const auto* w = frame->get_variable("w_char");
    assert(w != nullptr);
    assert(w->offset == 16);
    assert(w->size == 4);

    const auto* v = frame->get_variable("v_str");
    assert(v != nullptr);
    assert(v->offset == 24); // Aligned to 8-byte boundary after w (offset 20)
    assert(v->size == 8);

    assert(frame->get_frame_size() == 32); // 24 + 8 = 32

    sutra::MemoryModelRegistry::get_instance().pop_frame();

    // 2. Heap manager tracking
    auto& heap = sutra::MemoryModelRegistry::get_instance().get_heap_manager();
    heap.clear();

    uint64_t addr1 = heap.allocate(sutra::DataType::PAATH, 12, "नमस्ते जगत्"); // address 0x1000, size 12
    uint64_t addr2 = heap.allocate(sutra::DataType::PAATH, 5, "hello");       // address 0x1010 (aligned size 12 aligned to 8 is 16)

    assert(addr1 == 0x1000);
    assert(addr2 == 0x1010);

    const auto* obj1 = heap.get_object(addr1);
    assert(obj1 != nullptr);
    assert(obj1->size == 12);
    assert(obj1->is_active);

    heap.release(addr1);
    assert(!obj1->is_active);

    std::cout << "सफलम् (PASSED)\n";
}

void test_runtime_layer() {
    std::cout << "[परीक्षणम् 8] Runtime & OS Abstraction Layer Test... ";

    // 1. Console I/O Redirection
    std::stringstream out;
    std::stringstream in;
    in << "hello_token\n";

    sutra::runtime::Runtime::get_instance().set_output_stream(&out);
    sutra::runtime::Runtime::get_instance().set_input_stream(&in);

    sutra::runtime::io_write("Hello ");
    sutra::runtime::io_write_line("World!");
    std::string token = sutra::runtime::io_read();

    // Reset streams back to default stdout/stdin
    sutra::runtime::Runtime::get_instance().set_output_stream(&std::cout);
    sutra::runtime::Runtime::get_instance().set_input_stream(&std::cin);

    assert(out.str() == "Hello World!\n");
    assert(token == "hello_token");

    // 2. Filesystem abstraction
    std::string temp_file = "temp_test_sutra.txt";
    std::string expected_content = "Sutra Runtime Verification Content";

    sutra::runtime::fs_write(temp_file, expected_content);
    assert(sutra::runtime::fs_exists(temp_file));

    std::string read_content = sutra::runtime::fs_read(temp_file);
    assert(read_content == expected_content);

    std::remove(temp_file.c_str());
    assert(!sutra::runtime::fs_exists(temp_file));

    // 3. Environment Abstraction
    std::string path = sutra::runtime::env_get_variable("PATH");
    assert(!path.empty());

    std::string cwd = sutra::runtime::env_current_directory();
    assert(!cwd.empty());

    std::string plat = sutra::runtime::env_platform_name();
    assert(plat == "Windows" || plat == "Linux");

    std::cout << "सफलम् (PASSED)\n";
}

void test_garbage_collection() {
    std::cout << "[परीक्षणम् 9] Garbage Collection (स्वचालित स्मृति-संग्रह) Test... ";

    sutra::MemoryModelRegistry::get_instance().reset();
    sutra::GarbageCollector::get_instance().reset();

    auto& heap = sutra::MemoryModelRegistry::get_instance().get_heap_manager();

    // 1. Allocate strings, lists, objects
    sutra::SutraValue str_val = sutra::SutraValue::make_string("GC Test String");
    sutra::SutraValue list_val = sutra::SutraValue::make_list({str_val});

    uint64_t str_addr = str_val.heap_address;
    uint64_t list_addr = list_val.heap_address;

    assert(str_addr != 0);
    assert(list_addr != 0);
    assert(heap.get_object(str_addr)->is_active);
    assert(heap.get_object(list_addr)->is_active);

    // 2. Perform GC without active environments holding references -> should be collected
    sutra::GarbageCollector::get_instance().collect();
    assert(!heap.get_object(str_addr)->is_active);
    assert(!heap.get_object(list_addr)->is_active);

    // Reset for next test
    sutra::MemoryModelRegistry::get_instance().reset();
    sutra::GarbageCollector::get_instance().reset();

    // 3. Keep reachable by placing list containing string inside an active environment
    auto env = std::make_shared<sutra::Environment>();
    sutra::SutraValue str_val2 = sutra::SutraValue::make_string("GC Test String 2");
    sutra::SutraValue list_val2 = sutra::SutraValue::make_list({str_val2});

    uint64_t str_addr2 = str_val2.heap_address;
    uint64_t list_addr2 = list_val2.heap_address;

    env->define("my_list", list_val2);

    sutra::GarbageCollector::get_instance().collect();
    // They are reachable from the registered environment, so they should remain active!
    assert(heap.get_object(str_addr2)->is_active);
    assert(heap.get_object(list_addr2)->is_active);

    // 4. Overwrite/reassign in environment -> should become collectible!
    env->define("my_list", sutra::SutraValue::make_int(100)); // Overwritten with integer

    sutra::GarbageCollector::get_instance().collect();
    // Now they are no longer reachable!
    assert(!heap.get_object(str_addr2)->is_active);
    assert(!heap.get_object(list_addr2)->is_active);

    std::cout << "सफलम् (PASSED)\n";
}

void test_memory_ownership_tracking() {
    std::cout << "[परीक्षणम् 10] Memory Ownership & Allocation Tracking Test... ";

    sutra::MemoryModelRegistry::get_instance().reset();
    auto& heap = sutra::MemoryModelRegistry::get_instance().get_heap_manager();
    heap.clear();

    // 1. Allocation tracking & Ownership & Category
    uint64_t addr = heap.allocate(
        sutra::DataType::PAATH,
        100,
        "Test Allocation",
        sutra::MemoryOwnership::MANUAL,
        "CustomCategory"
    );
    const auto* obj = heap.get_object(addr);
    assert(obj != nullptr);
    assert(obj->size == 100);
    assert(obj->ownership == sutra::MemoryOwnership::MANUAL);
    assert(obj->category == "CustomCategory");
    assert(obj->is_active);
    assert(!obj->is_released);

    // 2. Release tracking
    heap.release(addr);
    assert(!obj->is_active);
    assert(obj->is_released);

    // 3. Double release
    try {
        heap.release(addr);
        assert(false && "Should have thrown MemoryError on double release");
    } catch (const sutra::MemoryError& err) {
        // Expected
    }

    // 4. Invalid release
    try {
        heap.release(9999); // invalid address
        assert(false && "Should have thrown MemoryError on invalid release");
    } catch (const sutra::MemoryError& err) {
        // Expected
    }

    // 5. Allocation statistics & limit overflows
    heap.clear();
    heap.set_max_heap_size(500);
    uint64_t a1 = heap.allocate(sutra::DataType::POORNAK, 200);
    assert(heap.get_total_allocated_bytes() == 200);
    uint64_t a2 = heap.allocate(sutra::DataType::POORNAK, 200);
    assert(heap.get_total_allocated_bytes() == 400);

    // This allocation of 200 should exceed 500 max size and fail
    try {
        heap.allocate(sutra::DataType::POORNAK, 200);
        assert(false && "Should have thrown MemoryError on heap size limit exceeded");
    } catch (const sutra::MemoryError& err) {
        // Expected
    }

    // Checking size overflow bounds
    try {
        heap.allocate(sutra::DataType::POORNAK, 200 * 1024 * 1024); // 200 MB exceeds 100 MB limit
        assert(false && "Should have thrown MemoryError on allocation size limit exceeded");
    } catch (const sutra::MemoryError& err) {
        // Expected
    }

    // 6. Stale allocation detection & validate_address
    heap.clear();
    uint64_t a3 = heap.allocate(sutra::DataType::PAATH, 10);
    heap.validate_address(a3); // Should not throw since it's active

    heap.release(a3);
    try {
        heap.validate_address(a3);
        assert(false && "Should have thrown MemoryError on validate of stale address");
    } catch (const sutra::MemoryError& err) {
        // Expected
    }

    try {
        heap.validate_address(9999);
        assert(false && "Should have thrown MemoryError on validate of invalid address");
    } catch (const sutra::MemoryError& err) {
        // Expected
    }

    std::cout << "सफलम् (PASSED)\n";
}

int main() {
#ifdef _WIN32
    SetConsoleOutputCP(65001);
    SetConsoleCP(65001);
#endif

    std::cout << "=== सूत्र (Sutra) परीक्षण-प्रणाली (Automated Test Suite) ===\n";
    test_lexer();
    test_interpreter_namaste();
    test_interpreter_arithmetic();
    test_interpreter_conditional();
    test_interpreter_functions();
    test_semantic_undefined_variable();
    test_memory_model();
    test_runtime_layer();
    test_garbage_collection();
    test_memory_ownership_tracking();

    std::cout << "सर्वाणि परीक्षणानि सफलेन संपादितानि! (All tests passed successfully!)\n";
    return 0;
}
