# DIID #3 - Convert Markdown to HTML

**Solution:** Use the `commonmark-d` package.

## `dub.json`

```d
{
    "name": "md2html",
    "dependencies":
    {
        "commonmark-d": "~>1.0"
    }
}
```

## `input.md`

```md
# title
Some **bold** text.
```

## `source/main.d`

```d
import std.stdio;
import std.file;
import commonmarkd;

void main(string[] args)
{
    string text = cast(string) std.file.read("input.md");
    text.convertMarkdownToHTML.writeln; // simply writeln the HTML
    // CommonMark and Github Flavoured Markdown are supported.
}
``` 

Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).