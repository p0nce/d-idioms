=================================================
Should I use ++pre-increment or post-increment++?
=================================================

Either one. It did matter a bit in C++ but doesn't in D. The compiler rewrites internally post-increments to pre-increments if the expression result is unused.

```
  it++; // lowered to ++it since the result isn't used
  it--; // ditto, lowered to --it
```

Contrarily to [C++](http://en.cppreference.com/w/cpp/language/operator_incdec), a single operator overload is used to define both pre-increment and post-increment in user-defined types.

```
struct WrappedInt
{
    int m;

    // overload both ++pre and post++
    int opUnary(string op)() if (op == "++")
    {
        return ++m;
    }
}
```
