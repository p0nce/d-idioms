Get parent class of a class at compile-time
===========================================

Surprisingly, there is no `__traits` or `std.traits` to do this, but you can use this secret `is()` syntax to get the parent class of a class.

```
class A { }
class B : A {}

template ParentOf(Class)
{
    static if(is(Class Parents == super) && Parents.length)
        alias ParentOf = Parents[0];
    else
        static assert(0, "No parent for this");
}

static assert(is(ParentOf!B == A));
```