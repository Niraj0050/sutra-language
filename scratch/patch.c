#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void replace_all(char** text, const char* search, const char* replace) {
    char* pos;
    int search_len = strlen(search);
    int replace_len = strlen(replace);
    
    while ((pos = strstr(*text, search)) != NULL) {
        int index = pos - *text;
        int new_size = strlen(*text) - search_len + replace_len + 1;
        char* new_text = malloc(new_size);
        strncpy(new_text, *text, index);
        new_text[index] = '\0';
        strcat(new_text, replace);
        strcat(new_text, pos + search_len);
        free(*text);
        *text = new_text;
    }
}

int main() {
    FILE* f = fopen("scratch/temp.c", "rb");
    if (!f) return 1;
    fseek(f, 0, SEEK_END);
    long size = ftell(f);
    fseek(f, 0, SEEK_SET);
    char* content = malloc(size + 1);
    fread(content, 1, size, f);
    content[size] = 0;
    fclose(f);

    replace_all(&content, "fprintf(stderr, \"त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\\n\");\r\n        exit(1);", "sutra_throw_str(\"त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\\n\");\n        exit(1);", "sutra_throw_str(\"त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\\n\");\n    exit(1);", "sutra_throw_str(\"त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\\n\");\r\n    exit(1);", "sutra_throw_str(\"त्रुटिः — पाठस्य सीमा अतिक्रान्ता (String index out of bounds)\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\\n\");\r\n        exit(1);", "sutra_throw_str(\"त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\\n\");\n        exit(1);", "sutra_throw_str(\"त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\\n\");\n    exit(1);", "sutra_throw_str(\"त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\\n\");\r\n    exit(1);", "sutra_throw_str(\"त्रुटिः — अमान्य सूचकांक मान (Index cannot be negative)\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — शून्य पाठ पर सूचकांक प्रयास\\n\");\r\n        exit(1);", "sutra_throw_str(\"त्रुटिः — शून्य पाठ पर सूचकांक प्रयास\");");
    replace_all(&content, "fprintf(stderr, \"त्रुटिः — शून्य पाठ पर सूचकांक प्रयास\\n\");\n        exit(1);", "sutra_throw_str(\"त्रुटिः — शून्य पाठ पर सूचकांक प्रयास\");");

    f = fopen("scratch/temp.c", "wb");
    fwrite(content, 1, strlen(content), f);
    fclose(f);
    return 0;
}
