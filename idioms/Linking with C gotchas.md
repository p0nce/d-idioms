======================
Linking with C gotchas
======================

## The little known `pragma(mangle)`

`pragma(mangle)` is extremely useful when you need to statically link with a C function whose name is a reserved D keyword:

    pragma(mangle, "version") extern(C) void c_version();

