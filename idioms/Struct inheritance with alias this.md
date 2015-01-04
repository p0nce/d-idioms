==================================
Struct inheritance with alias this
==================================

What if we want to decorate an struct with additional features without delegating every method to a member by hand?
We can't use virtual dispatch since the parent aggregate is a `struct`.

Fortunately The `alias this` feature comes to the rescue!

For example, let's write a wrapper around the Phobos `File` struct to write HTML page.


    import std.file;
    class HTMLPage
    {
        public:
        // subtype of File
        File file;
        alias file this;
        this(string path)
        {
            file = File(path, "w");
        }
        void push(string anchor)
        {
            _anchors ~= anchor;
            file.write("<" ~ anchor ~ ">");
        }
        void pop()
        {
            string last = _anchors[$-1];
            _anchors = _anchors[0..$-1];
            file.writef("</" ~ last ~ ">");
        }
    }

When using `HTMLPage` you will still have access to every File method. For example, you'll be able to do:

    htmlPage.writeln("<doctype html");

This site uses this idiom.

