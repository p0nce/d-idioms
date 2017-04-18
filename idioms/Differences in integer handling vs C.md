====================================
Differences in integer handling vs C
====================================

By and large D integer handling is identical to C. However there are some differences you might want to be aware of.

By design, none of those can break C code ported to D, **except in one case described here.**

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



## Unary `+` and `-` operators do not promote

In C, `+` and `-` promote their operand to `int` if smaller than `int`.

```
#include <stdio.h>

int main(void) {
    char a = 1;
    printf("%zu\n", sizeof( +a ));                        // Output: 4
    printf("%zu\n", sizeof( -a ));                        // Output: 4
    return 0;
}
```

But not in D:

```
import std.stdio;

void main()
{
    byte a = 1;
    writeln(( +a ).sizeof);                               // Output: 1
    writeln(( -a ).sizeof);                               // Output: 1
}
```

**This can make a subtle difference in rare occurences.**


This C program prints "128".

```
#include <stdio.h>

int main()
{
    signed char c = -128;

    // Prints 128 because unary minus 
    // promotes to int if smaller
    printf("%d\n", (int)(-c)); 
    return 0;
}
```

Whereas this similar D program prints "-128".

```
import core.stdc.stdio;
void main()
{
    byte c = -128;

    // Prints -128 because unary minus 
    // does not promote and 128 cannot
    // be represented with 8-bit signed
    // integers.
    printf("%d\n", cast(int)(-c)); 
}
```

**This is the only known risk when porting integer code from C to D.**

_This trap was reported by_ [ketmar](http://code.dlang.org/).