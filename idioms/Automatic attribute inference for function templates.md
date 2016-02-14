====================================================
Automatic attribute inference for function templates
====================================================

A `pure`, `nothrow`, `@nogc` or `@safe` function can only call functions that are respectively `pure`, `nothrow`, `@nogc` or `@safe`/`@trusted`.

```
int plusOne(int a)
{
    return a + 1;
}

void f() pure nothrow @nogc @safe
{
    // Error: pure function 'f' cannot call impure function 'plusOne'
    // Error: safe function 'f' cannot call system function 'plusOne'
    // Error: @nogc function 'f' cannot call non-@nogc function 'plusOne'
    // Error: 'plusOne' is not nothrow
    plusOne(3);
}
```

**However,** function _templates_ have their attribute automatically inferred.

```
int plusOne(int b = 2)(int a)
{
    return a + 1;
}

void f() pure nothrow @nogc @safe
{
    plusOne(3); // everything fine
}
```


## Why?

Function templates bodies are always available to the compiler. Which is not the case for non-templated functions, who could be `extern`.
**For consistency,** non-templated functions attributes don't get inferred, even if the source code is available.

See also: [https://dlang.org/spec/function.html#function-attribute-inference](https://dlang.org/spec/function.html#function-attribute-inference)
