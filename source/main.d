module main;

import std.stdio;
import std.file;
import std.string;
import std.algorithm;

import page;


struct Idiom
{
    string markdownFile;

    string title()
    {
        return markdownFile[7..$-3];
    }

    string anchorName()
    {
        dchar[dchar] transTable1 = [' ' : '-'];
        return translate(title(), transTable1);
    }
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
                        appendRawFile("common.css");
                        appendRawFile("hybrid.css");
                    pop();
                    writeln("<link href='http://fonts.googleapis.com/css?family=Inconsolata' rel='stylesheet' type='text/css'>");

                    push("title");
                    write("d-idioms - Idioms for the D programming language");
                    pop;
                pop;
                push("body");
                    write(`<script>`
`(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){`
`(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),`
`m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)`
`})(window,document,'script','//www.google-analytics.com/analytics.js','ga');`
`ga('create', 'UA-71912218-1', 'auto');`
`ga('send', 'pageview');</script>`);

                    writeln("<script src=\"highlight.pack.js\"></script>");
                    writeln("<script>hljs.initHighlightingOnLoad();</script>");

                    push("header");
                        push("img", "id=\"logo\" src=\"d-logo.svg\"");
                        pop;
                        push("div", "id=\"title\"");
                            writeln("Idioms for the D Programming Language");
                        pop();
                    pop;

                    push("nav");
                        foreach(idiom; idioms)
                        {
                            push("a", "href=\"#" ~ idiom.anchorName() ~ "\"");
                                writeln(idiom.title());
                            pop;
                        }
                    pop;

                    push("div", "class=\"container\"");
                        foreach(idiom; idioms)
                        {
                            push("a", "name=\"" ~ idiom.anchorName() ~ "\"");
                            pop;
                            push("div", "class=\"idiom\"");
                                push("a", "class=\"permalink\" href=\"#" ~ idiom.anchorName() ~ "\"");
                                    writeln("Link");
                                pop;
                                appendMarkdown(idiom.markdownFile);
                            pop;
                        }
                    pop;
                    writeln("<a href=\"https://github.com/p0nce/d-idioms/\"><img style=\"position: absolute; top: 0; right: 0; border: 0;\" src=\"https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67\" alt=\"Fork me on GitHub\" data-canonical-src=\"https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png\"></a>");


                     push("footer");

                        push("h2");
                            writeln("About");
                        pop;

                        push("p");
                            writeln(`I'm a software developer making voice processing software with D at <a href="https://www.auburnsounds.com">Auburn Sounds</a>. `
                                    `<br> Looking for a developer? I'm available for high-performance consulting. You can find my resume <a href="http://guillaumepiolat.fr/">here</a>. `
                                    `<br> I hope this site is as useful for you to read, as it was for me to write!`);
                        pop();

                        struct Contributor
                        {
                            string name;
                            string link;
                        }

                        auto contributors = [
                            Contributor("Basile Burg", "https://github.com/BBasile"),
                            Contributor("Dmitry Bubnenkov", "https://github.com/bubnenkoff"),
                        ];

                        push("h2");
                            writeln("Other contributors:");
                        pop;

                        push("ul", `id="contributors"`);
                            foreach(c; contributors)
                            {
                                push("li");
                                    push("a", format(`href="%s"`, c.link));
                                        writeln(c.name);
                                    pop();
                                pop;
                            }
                        pop();
                    pop;
                pop;
            pop;
        }

}
