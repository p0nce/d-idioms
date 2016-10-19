=================================================================
Rvalue references: Understanding `auto ref` and then not using it
=================================================================

## What are Rvalue references?

_“Rvalue references”_, known from C++, are a way to pass both Lvalues and Rvalues by reference.
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
    foo(v);                   // Pass a Rvaworks
    foo(Vector2f(42, 23));    // works as well
}
```

How do you achieve something similar in D?

## Understanding `auto ref` parameters

The canonical way to pass both Rvalues and Lvalues in D is to use `auto ref` parameters in combination with templates.

```d

struct A
{
    int id;
}

void test(T)(auto ref T a)
{
}

//
// Case 1:
//
// This generates one function:
//
//      void test(ref A a) { ... }
//
// taking the argument by ref.
A a = A(42);
test(a);


//
// Case 2
//
// This generates another function:
//
//      void test(A a) { ... }
//
// taking the argument by value.
test(A(42));

```

What `auto ref` does is generating two different versions of the function, one passing Lvalues by reference, and the other passing Rvalues by copy.

**Wait!** You may immediately notice two key differences with C++:

- There are no Rvalue references: Rvalues are copied instead.
- In the worst case, using `auto ref` may lead to template bloat with many such parameters.

You'll be relieved to know there is a way to mimic the C++ behaviour.


## Here comes the trick

Let's define in our struct a `byRef` method which return `this` by reference.

```d
import std.stdio;

mixin template RvalueRef(T) if (is(T == struct))
{
    @nogc @safe
    ref const(T) byRef() const pure nothrow return
    {
        return this;
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
    foo(v);                           // Works
    foo(Vector2f(42, 23).byRef);      // Works as well, and use the same function
}
```

By effectively converting the Lvalue into an Rvalue using the `ref` storage class on a function return type, we can pass the `Vector2f` to a function taking `ref const` input.

_This idiom was written by_ [Randy Schütt](https://github.com/Dgame)_._