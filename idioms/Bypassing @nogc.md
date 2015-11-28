===============
Bypassing @nogc
===============

`@nogc` is a function attribute which ensures a function never allocates through the GC.

```
void processStuff(double[] data) @nogc
{
    double[] tempBuffer;

    // Error: setting 'length' in @nogc function processStuff may cause GC a
    tempBuffer.length = data.length; 

    ...
}
```

Using `@nogc` is a must for memory-conscious code sections or for real-time threads.


However, not all library functions that could be marked `@nogc` are. At one point, you'll probably want to call functions as if they were `@nogc`. Here's how to do it:

```
import std.traits;

// Casts @nogc out of a function or delegate type.
auto assumeNoGC(T) (T t) if (isFunctionPointer!T || isDelegate!T)
{
    enum attrs = functionAttributes!T | FunctionAttribute.nogc;
    return cast(SetFunctionAttributes!(T, functionLinkage!T, attrs)) t;
}

// This function can't be marked @nogc but you know with application knowledge it won't use the GC.
void funcThatMightUseGC(int timeout)
{
    if (unlikelyCondition(timeout))
        throw new Exception("The world actually imploded.");

    doMoreStuff();
}

void funcThatCantAffortGC() @nogc
{
    // using a casted delegate literal to call non-@nogc code
    assumeNoGC( (int timeout)
                {
                    funcThatMightUseGC(timeout);
                })(10000);
}
```    

