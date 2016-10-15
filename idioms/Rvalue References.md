=============
Rvalue References
=============

Rvalue References (known from C++) are an easy way to pass LValues as well as RValues by ref.
It looks like this:

```cpp
#include <iostream>

struct Vector2f
{
    float x, y;

    explicit Vector2f(float x, float y) : x(x), y(y)
    {
    }
};

void foo(const Vector2f& pos)
{
    std::cout << pos.x << '|' << pos.y << std::endl;
}

int main()
{
    Vector2f v(42, 23);
    foo(v); // works
    foo(Vector2f(42, 23)); // works as well
}
```

The only way to achieve something similar in D is to use `auto ref` in combination with templates, but this leads to massive template bloat.
But there is an easy way to mimic the behaviour by yourself:

```d
import std.stdio;

mixin template RvalueRef(T) if (is(T == struct))
{
    private const(T)* _ptr;

    @nogc @safe
    ref const(T) byRef() pure nothrow return
    {
        if (_ptr is null) {
            _ptr = &this;
        }

        return *_ptr;
    }
}

struct Vector2f
{
    float x, y;

    this(float x, float y) pure nothrow
    {
        this.x = x;
        this.y = y;
    }

    mixin RvalueRef!(typeof(this));
}

void foo(ref const Vector2f pos)
{
    writefln("(%.2f|%.2f)", pos.x, pos.y);
}

void main()
{
    Vector2f v = Vector2f(42, 23);
    foo(v); // works
    foo(Vector2f(42, 23).byRef); // works as well
}
```
