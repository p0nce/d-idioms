===================================
Custom `format()` for builtin types
===================================

When using `std.conv.to()` or `std.stdio.write()`, the arguments are formatted using a predefined format.

Structs are processed differently. By default, all the members of a `struct` are converted
but the internal `to()` also checks if a `struct` implements a custom `toString()` function.
If so, this function is used and the default formatting of the members doesn't happen.

This can be used as a trick to override the default predefined formats of a basic type.

For example, to display a pointer as a hexadecimal address prefixed with `0x`, we can define a `struct` with a single member of type `void*` and a custom `toString()` function:

```D
import std.stdio;

struct FmtPtr
{
    void* ptr;
    string toString()
    {
        import std.format;
        static if (size_t.sizeof == 4)
            return format("0x%.8X ", cast(size_t)ptr);
        static if (size_t.sizeof == 8)
            return format("0x%.16X ", cast(size_t)ptr);
    }
}

void main(string[] args)
{
    import core.stdc.stdlib;
    auto a = malloc(8);
    auto b = malloc(8);
    auto c = malloc(8);

    // ugly custom formatting
    writeln("0X", a, " ", "0X", b, " ", "0X", c);
    writefln("0X%.8X 0X%.8X 0X%.8X", a, b, c);

    // clean and clear equivalent using the struct
    writeln(FmtPtr(a), FmtPtr(b), FmtPtr(c));
}
```
