#include "sutra/token.hpp"

namespace sutra {

static const std::unordered_map<std::string, TokenType> SUTRA_KEYWORDS = {
    {"कार्य", TokenType::K_KARYA},
    {"मुख्य", TokenType::K_MUKHYA},
    {"लिखतु", TokenType::K_LIKHATU},
    {"दर्शयतु", TokenType::K_DARSHAYATU},
    {"पंक्तिं", TokenType::K_PANKTIM},
    {"यदि", TokenType::K_YADI},
    {"अगर", TokenType::K_AGAR},
    {"अन्यथा", TokenType::K_ANYATHA},
    {"पुनरावृत्तिः", TokenType::K_PUNARAVRTTIH},
    {"यावत्", TokenType::K_YAVAT},
    {"जबतक", TokenType::K_JABTAK},
    {"पठतु", TokenType::K_PATHATU},
    {"विरामः", TokenType::K_VIRAMAH},
    {"जारीरह", TokenType::K_JARIRAH},
    {"अग्रिमः", TokenType::K_JARIRAH},
    {"प्रयत्न", TokenType::K_PRAYATNA},
    {"प्रयासः", TokenType::K_PRAYATNA},
    {"पकड़ो", TokenType::K_PAKADO},
    {"ग्रहणम्", TokenType::K_PAKADO},
    {"प्रक्षेपः", TokenType::K_PRAKSHEPAH},
    {"फेको", TokenType::K_PRAKSHEPAH},
    {"आयात", TokenType::K_AAYAT},
    {"आयानम्", TokenType::K_AAYAT},
    {"परत्", TokenType::K_PARAT},
    {"सत्य", TokenType::K_SATYA},
    {"असत्य", TokenType::K_ASATYA},
    {"शून्यम्", TokenType::K_SHUNYAM},
    {"मान", TokenType::K_MAAN},
    {"संख्या", TokenType::K_SANKHYA},
    {"दशमलव", TokenType::K_DASHAMLAV},
    {"पाठ", TokenType::K_PATH},
    {"बूल", TokenType::K_BOOL},
    {"सूची", TokenType::K_SUCHI},
    {"वर्ग", TokenType::K_VARGA},
    {"नवीन", TokenType::K_NAVIN},
    {"स्व", TokenType::K_SVA},
    {"तथा", TokenType::K_TATHA},
    {"अथवा", TokenType::K_ATHAVA},
    {"न", TokenType::K_NA}
};

TokenType lookup_keyword(const std::string& identifier) {
    auto it = SUTRA_KEYWORDS.find(identifier);
    if (it != SUTRA_KEYWORDS.end()) {
        return it->second;
    }
    return TokenType::IDENTIFIER;
}

std::string token_type_to_string(TokenType type) {
    switch (type) {
        case TokenType::K_KARYA: return "K_KARYA (कार्य)";
        case TokenType::K_MUKHYA: return "K_MUKHYA (मुख्य)";
        case TokenType::K_LIKHATU: return "K_LIKHATU (लिखतु)";
        case TokenType::K_DARSHAYATU: return "K_DARSHAYATU (दर्शयतु)";
        case TokenType::K_PANKTIM: return "K_PANKTIM (पंक्तिं)";
        case TokenType::K_YADI: return "K_YADI (यदि)";
        case TokenType::K_AGAR: return "K_AGAR (अगर)";
        case TokenType::K_ANYATHA: return "K_ANYATHA (अन्यथा)";
        case TokenType::K_PUNARAVRTTIH: return "K_PUNARAVRTTIH (पुनरावृत्तिः)";
        case TokenType::K_YAVAT: return "K_YAVAT (यावत्)";
        case TokenType::K_JABTAK: return "K_JABTAK (जबतक)";
        case TokenType::K_PATHATU: return "K_PATHATU (पठतु)";
        case TokenType::K_VIRAMAH: return "K_VIRAMAH (विरामः)";
        case TokenType::K_JARIRAH: return "K_JARIRAH (जारीरह)";
        case TokenType::K_PRAYATNA: return "K_PRAYATNA (प्रयत्न)";
        case TokenType::K_PAKADO: return "K_PAKADO (पकड़ो)";
        case TokenType::K_PRAKSHEPAH: return "K_PRAKSHEPAH (प्रक्षेपः)";
        case TokenType::K_AAYAT: return "K_AAYAT (आयात)";
        case TokenType::K_PARAT: return "K_PARAT (परत्)";
        case TokenType::K_SATYA: return "K_SATYA (सत्य)";
        case TokenType::K_ASATYA: return "K_ASATYA (असत्य)";
        case TokenType::K_SHUNYAM: return "K_SHUNYAM (शून्यम्)";
        case TokenType::K_MAAN: return "K_MAAN (मान)";
        case TokenType::K_SANKHYA: return "K_SANKHYA (संख्या)";
        case TokenType::K_DASHAMLAV: return "K_DASHAMLAV (दशमलव)";
        case TokenType::K_PATH: return "K_PATH (पाठ)";
        case TokenType::K_BOOL: return "K_BOOL (बूल)";
        case TokenType::K_SUCHI: return "K_SUCHI (सूची)";
        case TokenType::K_VARGA: return "K_VARGA (वर्ग)";
        case TokenType::K_NAVIN: return "K_NAVIN (नवीन)";
        case TokenType::K_SVA: return "K_SVA (स्व)";
        case TokenType::K_TATHA: return "K_TATHA (तथा)";
        case TokenType::K_ATHAVA: return "K_ATHAVA (अथवा)";
        case TokenType::K_NA: return "K_NA (न)";

        case TokenType::IDENTIFIER: return "IDENTIFIER";
        case TokenType::INT_LITERAL: return "INT_LITERAL";
        case TokenType::FLOAT_LITERAL: return "FLOAT_LITERAL";
        case TokenType::STRING_LITERAL: return "STRING_LITERAL";

        case TokenType::PLUS: return "PLUS (+)";
        case TokenType::MINUS: return "MINUS (-)";
        case TokenType::STAR: return "STAR (*)";
        case TokenType::SLASH: return "SLASH (/)";
        case TokenType::MOD: return "MOD (%)";
        case TokenType::ASSIGN: return "ASSIGN (=)";
        case TokenType::EQUAL: return "EQUAL (==)";
        case TokenType::NOT_EQUAL: return "NOT_EQUAL (!=)";
        case TokenType::GREATER: return "GREATER (>)";
        case TokenType::LESS: return "LESS (<)";
        case TokenType::GREATER_EQUAL: return "GREATER_EQUAL (>=)";
        case TokenType::LESS_EQUAL: return "LESS_EQUAL (<=)";
        case TokenType::LOGICAL_AND: return "LOGICAL_AND (&&)";
        case TokenType::LOGICAL_OR: return "LOGICAL_OR (||)";
        case TokenType::LOGICAL_NOT: return "LOGICAL_NOT (!)";

        case TokenType::LPAREN: return "LPAREN (";
        case TokenType::RPAREN: return "RPAREN )";
        case TokenType::LBRACE: return "LBRACE {";
        case TokenType::RBRACE: return "RBRACE }";
        case TokenType::LBRACKET: return "LBRACKET [";
        case TokenType::RBRACKET: return "RBRACKET ]";
        case TokenType::COMMA: return "COMMA ,";
        case TokenType::SEMICOLON: return "SEMICOLON ;";
        case TokenType::DOT: return "DOT .";
        case TokenType::END_OF_FILE: return "END_OF_FILE";
        default: return "UNKNOWN_TOKEN";
    }
}

} // namespace sutra
