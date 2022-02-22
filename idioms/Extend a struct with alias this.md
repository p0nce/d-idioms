Extend a struct with `alias this`
=================================

What if we want to decorate a struct with additional features?
We can't use virtual dispatch since the parent aggregate is a `struct`.
That means we are on board for extensive manual delegation of method calls to a member.


Fortunately the `alias this` feature comes to the rescue!


As an example, let's write a wrapper around the Phobos `File` struct for writing an HTML page.


    import std.stdio;
    import std.file;
    struct HTMLPage
    {
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

When using `HTMLPage` you will still have access to every method in `File`. For example, you'll be able to do:

    htmlPage.writeln("<doctype html>");

This site uses this idiom.



`alias this` can also define an implicit conversion.

    struct A
    {
        int a;
    }
    struct B
    {
        A a;
        alias a this;
        string b;
    }
    int f(A a)
    {
        return a.a+1;
    }
    int g(ref A a)
    {
        return a.a+1;
    }
    ref A h(ref A a)
    {
        return a;
    }
    void main(string[]ags)
    {
        B b;
        return f(b)  // b implicitely converted to an A
             + g(b); // b implicitely converted to a ref A
    }

As [TDPL](http://www.amazon.fr/The-Programming-Language-Andrei-Alexandrescu/dp/0321635361) says it, using `alias this` is subtyping.
