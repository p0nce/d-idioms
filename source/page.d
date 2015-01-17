module page;

import std.stdio;
import std.file;
import std.typecons;
import dmarkdown;

class Page
{
public:
    // subtype of File
    File file;
    alias file this;

    this(string path)
    {
        file = File(path, "w");
    }

    void close()
    {
        file.close();
    }

    void push(string anchor, string params = null)
    {
        _anchors ~= anchor;

        if (params == null)
            file.write("<" ~ anchor ~ ">");
        else
            file.write("<" ~ anchor ~ " " ~ params ~ ">");
    }

    void pop()
    {
        string last = _anchors[$-1];
        _anchors = _anchors[0..$-1];

        file.writef("</" ~ last ~ ">");
    }

    void appendRawFile(string filename)
    {
        file.rawWrite(std.file.read(filename));
    }

    // render and append markdown
    void appendMarkdown(string filename)
    {
        auto settings = new MarkdownSettings();
        settings.flags = MarkdownFlags.forumDefault;

        string text = cast(string) std.file.read(filename);
        string html = filterMarkdown(text);
        file.writef("%s", html);
    }

private:
    string[] _anchors;
}

string dataURIBase64(string mime, string filename)
{
    import std.base64;
    ubyte[] data = cast(ubyte[])(std.file.read(filename));
    const(char)[] bdata = Base64.encode(data);
    return "data:" ~ mime ~ ";base64," ~ bdata.idup;
}

string dataURIUTF8(string mime, string filename)
{
    import std.base64;
    string data = cast(string)(std.file.read(filename));
    return "data:" ~ mime ~ ";UTF-8," ~ data;
}
