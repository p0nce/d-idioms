module main;

import std.stdio;
import std.file;
import std.algorithm;

import page;


struct Idiom
{
    string markdownFile;
}

void main(string[] args)
{
    Idiom[] idioms;

    // finds all idioms by enumarating Markdown
    auto mdFiles = filter!`endsWith(a.name,".md")`(dirEntries("idioms",SpanMode.depth));
    foreach(md; mdFiles)
        idioms ~= Idiom(md);

    auto page = new Page("index.html");

    with(page)
        {
            writeln("<!DOCTYPE html>");
            push("html");
                push("head");

                    writeln("<meta charset=\"utf-8\">");
                    writeln("<meta name=\"description\" content=\"D Programming Language idioms.\">");
                    push("style", "type=\"text/css\"  media=\"all\" ");
                        appendRawFile("reset.css");
                    pop();

                    writeln("<link rel=\"stylesheet\" type=\"text/css\" href=\"common.css\">");
                    writeln("<link rel=\"stylesheet\" type=\"text/css\" href=\"hybrid.css\">");
                    writeln("<link href='http://fonts.googleapis.com/css?family=Inconsolata' rel='stylesheet' type='text/css'>");

                    push("title");
                    write("d-idioms");
                    pop;
                pop;
                push("body");

                    writeln("<script src=\"highlight.pack.js\"></script>");
                    writeln("<script>hljs.initHighlightingOnLoad();</script>");

                    push("div", "class=\"container\"");
                        foreach(idiom; idioms)
                        {
                            push("div", "class=\"idiom\"");
                                appendMarkdown(idiom.markdownFile);
                            pop;
                        }
                    pop;
                pop;
            pop;
        }

}
