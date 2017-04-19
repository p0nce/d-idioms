=============================================================
Should this property be available at compile-time or runtime?
=============================================================

It is common in [Design by Introspection](#Design-by-Introspection) to decide between a runtime value and a compile-time value.

- "Should this image abstraction have a runtime or compile-time dimension?"
- "Should this sound abstraction have a runtime or compile-time duration?"
- "Should this allocator abstraction have a runtime or compile-time alignment?"

## A hot sample

For example, our generic example library will operate on a `Volcano` concept.
The only requirement is to have a `.magma` property, be it compile-time or runtime, implicitely convertible to `int`.

```
template isVolcano(S)
{
    enum bool isVolcano = hasMagma!S; // only requirement for now
}

template hasMagma(S)
{
    enum bool hasDuration = is(typeof(
        (inout int = 0)
        {
            S s = S.init;
            int d = s.magma; // need a magma property
        }));
}
```

## You don't necessarily have to choose

It turns out generic algorithms can work with both a runtime or compile-time `.magma` property, **with this simple C++ trick**.

```
template hasStaticMagma(S)
{
    enum bool hasStaticMagma = hasMagma!S && __traits(compiles, int[S.magma]);
}

void myVolcanoGenericAlgorithm(S) if (isVolcano!S)
{
    static if (hasStaticMagma!S)
    {
        // optimized version for statically known .magma ...
    }
    else
    {
        // plain version ...
    }
}
```

You aren't forced to choose runtime or static for your meta-programming design. This idiom enables faster code when some value is statically known, without necessarily hindering your design.