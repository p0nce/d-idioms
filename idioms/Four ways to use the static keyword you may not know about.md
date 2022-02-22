Four ways to use the static keyword you may not know about
==========================================================

The `static` keyword is heavily re-used in the D language. With this uniquely detailed article, you'll learn to recognize the different species of `static` in the wild.


## 1. Most obvious: `static` member functions and `static` data members

Much like in Java and C++, you can declare `static` data and functions members in a `struct` or a `class`. The one caveat is that **static data members will be put in Thread Local Storage unless marked with** `__gshared`.

```
class MyClass
{
    // A static member variable => only one exist for all MyClass instances
    // You need __gshared here else instanceCount would be thread-local
    static __gshared int instanceCount = 0;

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

**Additionally**, `static immutable` can be used instead of `enum` to force compile-time evaluation of a constant, **while keeping an address.**

This is especially useful for [arrays computed at compile-time](#Precomputed-tables-at-compile-time-through-CTFE).


## 2. Top-level `static` variables and functions

This is perhaps the strangest `static` abuse. At top-level, `static` does **nothing** for variables and function declarations.


Here, a TLS (Thread Local Storage) variable:
```
// At top-level
static int numEngines = 4;          // Accepted. Does nothing.
```

This is 100% equivalent to:
```
// At top-level.
int numEngines = 4;                 // The normal way to declare a TLS variable.
```

Similarly for top-level functions:

```
static int add(int a, int b)        // You can leave out "static" at top-level. It does nothing.
{
    return a + b;
}
```

As the D specification [says](http://dlang.org/spec/attribute.html#static):

_"Static does not have the additional C meaning of being local to a file. Use the private attribute in D to achieve that."_

**Leave your C++ knowledge about** `static inline` **functions and** `static` **top-level variables at the door: it doesn't apply here.**


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


## 4. Global constructors and global destructors

Arguably the most important `static` use out of the four we've listed.


### _Thread-local_ global constructors `static this()`:

Called when a thread is registered to the D runtime. **Typically used to initialize TLS variables.**


### _Thread-local_ global destructor `static ~this()`:

Called when a thread is unregistered to the D runtime. **Typically used to finalize TLS variables.**


### Global constructors `shared static this()`:

Called when the D runtime is initialized. **Typically used to initialize** `shared` **or** `__gshared` **variables**, for example in [Derelict](https://github.com/DerelictOrg).


### Global destructor `shared static ~this()`:

Called when the D runtime is finalized. **Typically used to finalize** `shared` **or** `__gshared` **variables.**

Important: global constructors and global destructors can be placed within a `struct` or a `class`, where they will be able to initialize `shared`, `__gshared` or `static` _members_.


**Beware:** It's a common mistake to write `static this()` instead of `shared static this()`. **Don't be a TLS victim.**
