========================
Throwing despite `@nogc`
========================

 **This trick is a dirty Proof Of Concept. Just never do it.**

The major limitation of `@nogc` is that you can't throw exceptions allocated with `new`.

But if you really want it, exceptions can be pre-allocated to be thrown later:

```
// Statically initialize an exception instance.
static immutable Exception g_Exception = new Exception("This message won't be helpful");

// Function that throws despite being @nogc
void nogcFunction() @nogc
{
    throw g_Exception;
}

try
{
    nogcFunction();
}
catch(const(Exception) e)
{
    // Message, file and line number won't be given though
    import std.stdio;
    writefln("Received an exception: %s", e.msg);
}
```

Such a pre-allocated exception won't hold any information other than _"something went wrong"_. And it breaks the type system badly.

Note from [Jakob Ovrum](https://github.com/JakobOvrum):

```
I really don't think you should promote that hack anywhere.
Even the druntime internal exception code will mutate it post-allocation regardless of mutability.
The compiler is even allowed to put the exception in ROM which would of course break everything.
You can also throw a mutable exception and catch it as immutable(Exception),
the whole thing is completely unintegrated with D2's type system.
Again, it doesn't matter if you catch it or not because the unwinding code will mutate it.
It's just straight up bad code.
```
