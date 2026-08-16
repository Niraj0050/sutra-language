import re

def fix():
    paths = [
        r"d:\my project\सूत्र\संकलक\src\compiler\sutra_runtime.c",
        r"d:\my project\सूत्र\sutra_runtime.c"
    ]
    for p in paths:
        with open(p, "r", encoding="utf-8") as f:
            content = f.read()
        
        # We want to replace:
        # fprintf(stderr, "error message\n" ... );
        # exit(1);
        # WITH:
        # sutra_throw_str("error message");
        
        # Regex to catch fprintf followed by exit(1)
        # Note: Some have formatting args: fprintf(stderr, "msg %lld\n", args...);
        pattern = r'fprintf\(\s*stderr\s*,\s*"([^"]+)\\n"[^;]*\);\s*exit\(1\);'
        
        def replacer(match):
            msg = match.group(1)
            # Clean up %lld etc from msg
            msg = re.sub(r':\s*%lld\s*\(.*?%lld.*?\)', '', msg)
            msg = re.sub(r':\s*%lld', '', msg)
            # Replace common ones with exact parity strings
            if "सूची सूचकांक सीमा से बाहर" in msg:
                msg = "त्रुटिः — सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)"
            elif "शून्य सूची पर सूचकांक प्रयास" in msg:
                msg = "त्रुटिः — शून्य सूची पर सूचकांक प्रयास"
            return f'sutra_throw_str("{msg}");'
            
        new_content = re.sub(pattern, replacer, content)
        
        with open(p, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"Patched {p}")

if __name__ == "__main__":
    fix()
