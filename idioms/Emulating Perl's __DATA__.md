Emulating Perl's `__DATA__`
===========================

Using ` import(__FILE__)` allows to embed data at the end of a D file.

Here is an example from the [D newsgroups](https://forum.dlang.org/post/sniryeoaguvrwevzsvxc@forum.dlang.org): 
```d
#! /usr/bin/env dub
/++ dub.sdl:
    dependency "dxml" version="0.4.0"
    stringImportPaths "."
+/
import dxml.parser;
import std;

enum text = import(__FILE__)
    .splitLines
    .find("__EOF__")
    .drop(1)
    .join("\n");

void main() {
    foreach (entity; parseXML!simpleXML(text)) {
        if (entity.type == EntityType.text)
            writeln(entity.text.strip);
    }
}
__EOF__
<!-- comment -->
<root>
    <foo>some text<whatever/></foo>
    <bar/>
    <baz></baz>
    more text
</root>
```

See also: [D lexer special tokens](https://dlang.org/spec/lex.html#specialtokens).
 
