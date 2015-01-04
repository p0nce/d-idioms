module main;

import std.stdio;
import std.file;

import page;


struct Idiom
{
    string markdownFile;
}




void main(string[] args)
{
    Idiom[] idioms;

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

                    push("title");
                    write("d-idioms");
                    pop;
                pop;
                push("body");

                pop;
            pop;
        }

}
