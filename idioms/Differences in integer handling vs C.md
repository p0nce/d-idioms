====================================
Differences in integer handling vs C
====================================

By and large D integer handling is identical to C. However there are some differences you might want to be aware of.

By design, **none of those can break C code ported to D.**

## `>>>` operator

D has a `>>>` operator to force unsigned right bit-shifting, regardless of the type of the left operand.

```
import std.stdio;

void main()
{
    short i = -48;
    writeln(i >>  1);                                     // Output: -24

    // unsigned shift, regardless of signedness of i
    writeln(i >>> 1);                                     // Output: 2147483624

    writeln(typeof(i >>> 1).stringof);                    // Output: int
}
```

The `>>>` operator promotes integers like the other bit-shifting operators.


## Signed overflow is not Undefined Behaviour

In D signed integer overflow is well-defined with wrapping semantics. You can rely on it and don't have to avoid signed overflow.

Source: [https://forum.dlang.org/post/n23bo3$qe$1@digitalmars.com](https://forum.dlang.org/post/n23bo3$qe$1@digitalmars.com)

