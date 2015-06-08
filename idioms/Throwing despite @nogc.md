========================
Throwing despite `@nogc`
========================

The major limitation of `@nogc` is that you can't throw exceptions allocated with `new`.

But exceptions can be pre-allocated to be thrown later:

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
catch(Exception e)
{
    // Message, file and line number won't be given though
    import std.stdio;    
    writefln("Received an exception: %s", e.msg);
}
```

Such a pre-allocated exception won't hold any information other than _"something went wrong"_.
