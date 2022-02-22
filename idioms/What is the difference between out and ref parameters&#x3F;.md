What is the difference between `out` and `ref` parameters?
=========================

Both pass parameters by reference. But `out` parameters are initialized with `.init` at function startup, while `ref` parameters aren't.

```
import std.stdio;
import std.math;

void functionUsingRef(ref float refParam)
{
    writeln(refParam);
}

void functionUsingOut(out float outParam)
in
{
    // Initialization for out parameters happens
    // before function pre-conditions.
    assert(isNaN(outParam));
}
body
{
    writeln(outParam);
    // Nothing actually forces you to write outParam
    // but that's what you should normally do.
    // You can also read it's value.
}

void main()
{
    float x = 2.5f;
    functionUsingRef(x); // Output: 2.5
    functionUsingOut(x); // Output: nan
    writeln(x);          // Output: nan
}

```

`ref` and `out` are **storage classes**, not **type qualifiers**. They don't belong to the parameter's type.