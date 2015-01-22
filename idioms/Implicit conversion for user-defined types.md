==========================================
Implicit conversion for user-defined types
==========================================

D officially forbid implicit conversions for user-defined types to avoid the pitfalls associated with them.
But defining an implicit conversion is actually possible by abusing `alias this`.

```
import std.stdio;

struct NumberAsString
{
    private string value;
    this(string value)
    {
        this.value = value;
    }

    int convHelper()
    {
        return to!int(value);
    }
    alias convHelper this;
}

void main(string[] args)
{
    auto a = NumberAsString("123");
    int b = a; // implicit conversion happening here
    writefln("%d", b);
}

```

This idiom was discovered by [Benjamin Thaut](http://3d.benjamin-thaut.de/?p=90).
