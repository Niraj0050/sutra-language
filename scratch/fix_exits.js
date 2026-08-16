const fs = require('fs');

function fix() {
    const paths = [
        "d:\\my project\\सूत्र\\संकलक\\src\\compiler\\sutra_runtime.c",
        "d:\\my project\\सूत्र\\sutra_runtime.c"
    ];

    for (const p of paths) {
        let content = fs.readFileSync(p, 'utf8');
        
        // Regex to catch fprintf followed by exit(1)
        const pattern = /fprintf\(\s*stderr\s*,\s*"([^"]+)\\n"[^;]*\);\s*exit\(1\);/g;
        
        content = content.replace(pattern, (match, msg) => {
            // Clean up %lld etc from msg
            msg = msg.replace(/:\s*%lld\s*\(.*?%lld.*?\)/g, '');
            msg = msg.replace(/:\s*%lld/g, '');
            
            // Replace common ones with exact parity strings
            if (msg.includes("सूची सूचकांक सीमा से बाहर")) {
                msg = "त्रुटिः — सूच्याः सीमा अतिक्रान्ता (Array index out of bounds)";
            } else if (msg.includes("शून्य सूची पर सूचकांक प्रयास")) {
                msg = "त्रुटिः — शून्य सूची पर सूचकांक प्रयास";
            }
            
            return `sutra_throw_str("${msg}");`;
        });
        
        // Also fix inline ones like: if (!out) { fprintf(stderr, "...\n"); exit(1); }
        const patternInline = /\{\s*fprintf\(\s*stderr\s*,\s*"([^"]+)\\n"[^;]*\);\s*exit\(1\);\s*\}/g;
        content = content.replace(patternInline, (match, msg) => {
            return `{ sutra_throw_str("${msg}"); }`;
        });
        
        fs.writeFileSync(p, content, 'utf8');
        console.log(`Patched ${p}`);
    }
}

fix();
