==========================================================
Four ways to use the static keyword you may not know about
==========================================================

The `static` keyword is heavily re-used in the D language. With this uniquely detailed article, you'll learn to recognize the different species of `static` in the wild.


## 1. Most obvious: `static` member functions and `static` data members

**Like in Java and C++**, you can declare `static` data and functions members in a `struct` or a `class`.
They won't be associated with a particular object.

```
class MyClass
{
    // A static member variable => only one exist for all MyClass instances
    static int instanceCount = 0;

    // A static member function => does not receive "this"
    static void incrementCount()
    {
        // Can't use "this" here
        instanceCount += 1;
    }
}

void main()
{
    import std.stdio;
    MyClass.incrementCount();
    writeln(MyClass.instanceCount); // Prints: "1"
}
```

## 2. Top-level `static` variables and functions

This is perhaps the strangest `static` abuse. At top-level, `static` does **nothing** for variables and function declarations.


Here, a TLS variable:
```
// At top-level
static int numEngines = 4;          // Accepted. Does nothing.
```

This is 100% equivalent to:
```
// At top-level.
int numEngines = 4;                 // The normal way to declare a TLS variable.
```

Similarly for functions:

```
static int add(int a, int b)        // You can leave "static" out. It does nothing.
{
    return a + b;
}
```

As the D specification [says](http://dlang.org/spec/attribute.html#static):

_"Static does not have the additional C meaning of being local to a file. Use the private attribute in D to achieve that."_

**Leave your C++ knowledge about** `static inline` **functions and** `static` **top-level variables at the door: doesn't apply here.**


## 3. Nested `static struct`, nested `static class`, and nested `static` functions

`static` can be put before nested `struct`, `class` or functions.

**It means "I don't have a pointer to the outer context"**.

```
import std.stdio;

void main()
{
    float contextData;

    struct InternalA
    {
        void uglyStuff()
        {
            // can access contextData here, and use this.outer
        }
    }

    static struct InternalB
    {
        void uglyStuff()
        {
            // cannot access contextData here, cannot use this.outer
        }
    }

    void subFunA()
    {
        // can access contextData here
    }

    static void subFunB()
    {
        // cannot access contextData here
    }

    writeln(typeof(&subFunA).stringof); // Prints: "void delegate()"
    writeln(typeof(&subFunB).stringof); // Prints: "void function()"
}
```

**To sum up**, a nested `static struct` or `static class`:
  * Cannot access the parent context because it has no `this.outer` property,
  * Might be a bit smaller in memory because `this.outer` is a hidden field.

A nested `static` function:
  * Cannot access the parent context because it has no context pointer to the upper frame,
  * Can fit in a simple `function` pointer instead of a `delegate` for this reason.