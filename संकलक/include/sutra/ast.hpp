#ifndef SUTRA_AST_HPP
#define SUTRA_AST_HPP

#include "sutra/token.hpp"
#include <string>
#include <vector>
#include <memory>

namespace sutra {

class ASTNode {
public:
    size_t line{0};
    size_t column{0};

    explicit ASTNode(size_t l = 0, size_t c = 0) : line(l), column(c) {}
    virtual ~ASTNode() = default;
};

class ExprASTNode : public ASTNode {
public:
    using ASTNode::ASTNode;
};

class StmtASTNode : public ASTNode {
public:
    using ASTNode::ASTNode;
};

// Literal Expression Node
enum class LiteralType { INT, FLOAT, STRING, BOOL, NULL_VAL, CHAR };

class LiteralExprASTNode : public ExprASTNode {
public:
    LiteralType lit_type;
    std::string value; // Stores raw representation

    LiteralExprASTNode(LiteralType type, std::string val, size_t l, size_t c)
        : ExprASTNode(l, c), lit_type(type), value(std::move(val)) {}
};

// Identifier Expression Node
class IdentifierExprASTNode : public ExprASTNode {
public:
    std::string name;

    IdentifierExprASTNode(std::string n, size_t l, size_t c)
        : ExprASTNode(l, c), name(std::move(n)) {}
};

// Binary Expression Node
class BinaryExprASTNode : public ExprASTNode {
public:
    TokenType op;
    std::unique_ptr<ExprASTNode> left;
    std::unique_ptr<ExprASTNode> right;

    BinaryExprASTNode(TokenType o, std::unique_ptr<ExprASTNode> l_expr, std::unique_ptr<ExprASTNode> r_expr, size_t l, size_t c)
        : ExprASTNode(l, c), op(o), left(std::move(l_expr)), right(std::move(r_expr)) {}
};

// Unary Expression Node (!x, -x)
class UnaryExprASTNode : public ExprASTNode {
public:
    TokenType op;
    std::unique_ptr<ExprASTNode> operand;

    UnaryExprASTNode(TokenType o, std::unique_ptr<ExprASTNode> expr, size_t l, size_t c)
        : ExprASTNode(l, c), op(o), operand(std::move(expr)) {}
};

// Function Call Expression Node
class CallExprASTNode : public ExprASTNode {
public:
    std::string callee;
    std::vector<std::unique_ptr<ExprASTNode>> arguments;

    CallExprASTNode(std::string c_name, std::vector<std::unique_ptr<ExprASTNode>> args, size_t l, size_t c)
        : ExprASTNode(l, c), callee(std::move(c_name)), arguments(std::move(args)) {}
};

// Console Input Expression Node (पठतु())
class InputExprASTNode : public ExprASTNode {
public:
    InputExprASTNode(size_t l, size_t c)
        : ExprASTNode(l, c) {}
};

// Array/List Literal Expression Node ([1, 2, 3])
class ArrayLiteralExprASTNode : public ExprASTNode {
public:
    std::vector<std::unique_ptr<ExprASTNode>> elements;

    ArrayLiteralExprASTNode(std::vector<std::unique_ptr<ExprASTNode>> elems, size_t l, size_t c)
        : ExprASTNode(l, c), elements(std::move(elems)) {}
};

// Dictionary Literal Expression Node ({ "key": val, "key2": val2 })
class DictionaryLiteralExprASTNode : public ExprASTNode {
public:
    std::vector<std::pair<std::string, std::unique_ptr<ExprASTNode>>> elements;

    DictionaryLiteralExprASTNode(std::vector<std::pair<std::string, std::unique_ptr<ExprASTNode>>> elems, size_t l, size_t c)
        : ExprASTNode(l, c), elements(std::move(elems)) {}
};

// Array Subscript Index Expression Node (अंक[0])
class ArrayIndexExprASTNode : public ExprASTNode {
public:
    std::unique_ptr<ExprASTNode> array_expr;
    std::unique_ptr<ExprASTNode> index_expr;

    ArrayIndexExprASTNode(std::unique_ptr<ExprASTNode> arr, std::unique_ptr<ExprASTNode> idx, size_t l, size_t c)
        : ExprASTNode(l, c), array_expr(std::move(arr)), index_expr(std::move(idx)) {}
};

// Variable Declaration Statement Node (मान आयु = 22;)
class VarDeclStmtASTNode : public StmtASTNode {
public:
    std::string type_name;
    std::string var_name;
    std::unique_ptr<ExprASTNode> initializer;

    VarDeclStmtASTNode(std::string t_name, std::string v_name, std::unique_ptr<ExprASTNode> init, size_t l, size_t c)
        : StmtASTNode(l, c), type_name(std::move(t_name)), var_name(std::move(v_name)), initializer(std::move(init)) {}
};

// Variable Assignment Statement Node (आयु = 23;)
class AssignStmtASTNode : public StmtASTNode {
public:
    std::string var_name;
    std::unique_ptr<ExprASTNode> value;

    AssignStmtASTNode(std::string v_name, std::unique_ptr<ExprASTNode> val, size_t l, size_t c)
        : StmtASTNode(l, c), var_name(std::move(v_name)), value(std::move(val)) {}
};

// Array Subscript Index Assignment Statement Node (अंक[1] = 50; / अंक[1][0] = 99;)
class ArrayIndexAssignStmtASTNode : public StmtASTNode {
public:
    std::string array_name;
    std::vector<std::unique_ptr<ExprASTNode>> index_exprs;
    std::unique_ptr<ExprASTNode> value_expr;

    ArrayIndexAssignStmtASTNode(std::string arr_name, std::unique_ptr<ExprASTNode> idx, std::unique_ptr<ExprASTNode> val, size_t l, size_t c)
        : StmtASTNode(l, c), array_name(std::move(arr_name)), value_expr(std::move(val)) {
        index_exprs.push_back(std::move(idx));
    }

    ArrayIndexAssignStmtASTNode(std::string arr_name, std::vector<std::unique_ptr<ExprASTNode>> idxs, std::unique_ptr<ExprASTNode> val, size_t l, size_t c)
        : StmtASTNode(l, c), array_name(std::move(arr_name)), index_exprs(std::move(idxs)), value_expr(std::move(val)) {}
};

// Expression Statement Node
class ExprStmtASTNode : public StmtASTNode {
public:
    std::unique_ptr<ExprASTNode> expression;

    ExprStmtASTNode(std::unique_ptr<ExprASTNode> expr, size_t l, size_t c)
        : StmtASTNode(l, c), expression(std::move(expr)) {}
};

// Output Statement Node (लिखतु("..."), दर्शयतु("..."), पंक्तिं("..."))
enum class PrintKind { LIKHATU, DARSHAYATU, PANKTIM };

class PrintStmtASTNode : public StmtASTNode {
public:
    PrintKind print_kind{PrintKind::LIKHATU};
    std::unique_ptr<ExprASTNode> expression;

    PrintStmtASTNode(std::unique_ptr<ExprASTNode> expr, size_t l, size_t c, PrintKind kind = PrintKind::LIKHATU)
        : StmtASTNode(l, c), print_kind(kind), expression(std::move(expr)) {}
};

// Block Statement Node ({ ... })
class BlockStmtASTNode : public StmtASTNode {
public:
    std::vector<std::unique_ptr<StmtASTNode>> statements;

    BlockStmtASTNode(std::vector<std::unique_ptr<StmtASTNode>> stmts, size_t l, size_t c)
        : StmtASTNode(l, c), statements(std::move(stmts)) {}
};

// If/Else Statement Node (यदि (...) { ... } / अगर (...) { ... } अन्यथा { ... })
class IfStmtASTNode : public StmtASTNode {
public:
    std::unique_ptr<ExprASTNode> condition;
    std::unique_ptr<BlockStmtASTNode> then_branch;
    std::unique_ptr<BlockStmtASTNode> else_branch; // can be null

    IfStmtASTNode(std::unique_ptr<ExprASTNode> cond, std::unique_ptr<BlockStmtASTNode> then_b, std::unique_ptr<BlockStmtASTNode> else_b, size_t l, size_t c)
        : StmtASTNode(l, c), condition(std::move(cond)), then_branch(std::move(then_b)), else_branch(std::move(else_b)) {}
};

// While Loop Statement Node (यावत् (...) { ... } / जबतक (...) { ... })
class WhileStmtASTNode : public StmtASTNode {
public:
    std::unique_ptr<ExprASTNode> condition;
    std::unique_ptr<BlockStmtASTNode> body;

    WhileStmtASTNode(std::unique_ptr<ExprASTNode> cond, std::unique_ptr<BlockStmtASTNode> b, size_t l, size_t c)
        : StmtASTNode(l, c), condition(std::move(cond)), body(std::move(b)) {}
};

// Return Statement Node (परत् <expr>;)
class ReturnStmtASTNode : public StmtASTNode {
public:
    std::unique_ptr<ExprASTNode> value; // can be null

    ReturnStmtASTNode(std::unique_ptr<ExprASTNode> val, size_t l, size_t c)
        : StmtASTNode(l, c), value(std::move(val)) {}
};

// For Loop Statement Node (पुनरावृत्तिः (init; condition; update) { ... })
class ForStmtASTNode : public StmtASTNode {
public:
    std::unique_ptr<StmtASTNode> init;      // can be null
    std::unique_ptr<ExprASTNode> condition; // can be null
    std::unique_ptr<StmtASTNode> update;    // can be null
    std::unique_ptr<BlockStmtASTNode> body;

    ForStmtASTNode(std::unique_ptr<StmtASTNode> i, std::unique_ptr<ExprASTNode> cond, std::unique_ptr<StmtASTNode> upd, std::unique_ptr<BlockStmtASTNode> b, size_t l, size_t c)
        : StmtASTNode(l, c), init(std::move(i)), condition(std::move(cond)), update(std::move(upd)), body(std::move(b)) {}
};

// Break Statement Node (विरामः;)
class BreakStmtASTNode : public StmtASTNode {
public:
    BreakStmtASTNode(size_t l, size_t c)
        : StmtASTNode(l, c) {}
};

// Continue Statement Node (जारीरह; / अग्रिमः;)
class ContinueStmtASTNode : public StmtASTNode {
public:
    ContinueStmtASTNode(size_t l, size_t c)
        : StmtASTNode(l, c) {}
};

// Try-Catch Statement Node (प्रयत्न { ... } पकड़ो (err) { ... })
class TryCatchStmtASTNode : public StmtASTNode {
public:
    std::unique_ptr<BlockStmtASTNode> try_block;
    std::string catch_var_name;
    std::unique_ptr<BlockStmtASTNode> catch_block;

    TryCatchStmtASTNode(std::unique_ptr<BlockStmtASTNode> try_b,
                        std::string var_name,
                        std::unique_ptr<BlockStmtASTNode> catch_b,
                        size_t l, size_t c)
        : StmtASTNode(l, c),
          try_block(std::move(try_b)),
          catch_var_name(std::move(var_name)),
          catch_block(std::move(catch_b)) {}
};

// Throw Statement Node (प्रक्षेपः <expr>; / फेको <expr>;)
class ThrowStmtASTNode : public StmtASTNode {
public:
    std::unique_ptr<ExprASTNode> expression;

    ThrowStmtASTNode(std::unique_ptr<ExprASTNode> expr, size_t l, size_t c)
        : StmtASTNode(l, c), expression(std::move(expr)) {}
};

// Import Statement Node (आयात "मार्गः.सूत्र";)
class ImportStmtASTNode : public StmtASTNode {
public:
    std::string module_path;

    ImportStmtASTNode(std::string path, size_t l, size_t c)
        : StmtASTNode(l, c), module_path(std::move(path)) {}
};

// Object Instantiation Node (नवीन छात्र(...))
class NewExprASTNode : public ExprASTNode {
public:
    std::string class_name;
    std::vector<std::unique_ptr<ExprASTNode>> arguments;

    NewExprASTNode(std::string c_name, std::vector<std::unique_ptr<ExprASTNode>> args, size_t l, size_t c)
        : ExprASTNode(l, c), class_name(std::move(c_name)), arguments(std::move(args)) {}
};

// Self Expression Node (स्व)
class SelfExprASTNode : public ExprASTNode {
public:
    SelfExprASTNode(size_t l, size_t c) : ExprASTNode(l, c) {}
};

// Member Access Expression Node (ऑब्जेक्ट.फ़ील्ड)
class MemberAccessExprASTNode : public ExprASTNode {
public:
    std::unique_ptr<ExprASTNode> object_expr;
    std::string member_name;

    MemberAccessExprASTNode(std::unique_ptr<ExprASTNode> obj, std::string mem, size_t l, size_t c)
        : ExprASTNode(l, c), object_expr(std::move(obj)), member_name(std::move(mem)) {}
};

// Member Assignment Statement Node (ऑब्जेक्ट.फ़ील्ड = मूल्य;)
class MemberAssignStmtASTNode : public StmtASTNode {
public:
    std::unique_ptr<ExprASTNode> object_expr;
    std::string member_name;
    std::unique_ptr<ExprASTNode> value_expr;

    MemberAssignStmtASTNode(std::unique_ptr<ExprASTNode> obj, std::string mem, std::unique_ptr<ExprASTNode> val, size_t l, size_t c)
        : StmtASTNode(l, c), object_expr(std::move(obj)), member_name(std::move(mem)), value_expr(std::move(val)) {}
};

// Method Call Expression Node (ऑब्जेक्ट.विधि(तर्क))
class MethodCallExprASTNode : public ExprASTNode {
public:
    std::unique_ptr<ExprASTNode> object_expr;
    std::string method_name;
    std::vector<std::unique_ptr<ExprASTNode>> arguments;

    MethodCallExprASTNode(std::unique_ptr<ExprASTNode> obj, std::string m_name, std::vector<std::unique_ptr<ExprASTNode>> args, size_t l, size_t c)
        : ExprASTNode(l, c), object_expr(std::move(obj)), method_name(std::move(m_name)), arguments(std::move(args)) {}
};

// Function Parameter Structure
struct FunctionParam {
    std::string type_name;
    std::string name;
};

// Function Declaration Node (कार्य मुख्य() { ... })
class FunctionDeclASTNode : public ASTNode {
public:
    std::string name;
    std::vector<FunctionParam> params;
    std::unique_ptr<BlockStmtASTNode> body;

    FunctionDeclASTNode(std::string n, std::vector<FunctionParam> p, std::unique_ptr<BlockStmtASTNode> b, size_t l, size_t c)
        : ASTNode(l, c), name(std::move(n)), params(std::move(p)), body(std::move(b)) {}
};

// Class Declaration Node (वर्ग छात्र { ... })
class ClassDeclASTNode : public ASTNode {
public:
    std::string name;
    std::vector<std::unique_ptr<VarDeclStmtASTNode>> fields;
    std::vector<std::unique_ptr<FunctionDeclASTNode>> methods;

    ClassDeclASTNode(std::string n,
                     std::vector<std::unique_ptr<VarDeclStmtASTNode>> f,
                     std::vector<std::unique_ptr<FunctionDeclASTNode>> m,
                     size_t l, size_t c)
        : ASTNode(l, c), name(std::move(n)), fields(std::move(f)), methods(std::move(m)) {}
};

// Root Program Node
class ProgramASTNode : public ASTNode {
public:
    std::vector<std::unique_ptr<ClassDeclASTNode>> classes;
    std::vector<std::unique_ptr<FunctionDeclASTNode>> functions;
    std::vector<std::unique_ptr<StmtASTNode>> global_statements;

    ProgramASTNode() : ASTNode(1, 1) {}
};

} // namespace sutra

#endif // SUTRA_AST_HPP
