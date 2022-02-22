Placement new with `emplace`
============================

C++ has ["placement new"](http://www.drdobbs.com/cpp/calling-constructors-with-placement-new/232901023) which is a language construct to construct an object at a given pointer location.

The D equivalent is a Phobos function called `std.conv.emplace` (documentation [here](http://dlang.org/phobos/std_conv.html#.emplace)).


`emplace` can be used as an alternative to `new` to support custom allocation. For example this perform construction of a class instance on the stack.


    import std.conv : emplace;
    ubyte[__traits(classInstanceSize, YourClass)] buffer;
    YourClass obj = emplace!YourClass(buffer[], ctor args...);
    // Destroy the object explicitly at scope exit, which will
    // call the destructor deterministically.
    scope(exit) .destroy(obj);

Courtesy of [Adam D. Ruppe](http://arsdnet.net/).
