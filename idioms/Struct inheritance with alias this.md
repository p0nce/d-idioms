==================================
Struct inheritance with alias this
==================================

What if we want to decorate an struct with additional features without delegating every method to a member by hand?
We can't use virtual dispatch since the parent aggregate is a `struct`.

Fortunately the `alias this` feature comes to the rescue!

For example, let's write a wrapper around the Phobos `File` struct to write HTML page.


    import std.stdio;
    import std.file;
    class HTMLPage
    {
    public:
        File file;
        alias file this; // file's methods are looked at on name lookup.
        this(string path)
        {
            file = File(path, "w"); // akin to calling parent constructor
        }
        void writeAnchor(string anchor)
        {
            writeln("<" ~ anchor ~ ">"); // will call file.writeln
        }
    }

When using `HTMLPage` you will still have access to every File method. For example, you'll be able to do:

    htmlPage.writeln("<doctype html");

This site uses this idiom.

