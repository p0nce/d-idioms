@nogc Array Literals: Breaking the Limits
======================

## Array literals may allocate

The most vexing limitation of `@nogc` is that array literals generally can't be used anymore.

```d
void main() @nogc
{
    // Works: the array literal is used as a value.
    int[3] myStaticArray = [1, 2, 3]; 

    // Doesn't work.
    int[] myDynamicArray = [1, 2, 3];  // Error: array literal in @nogc function 
                                       // may cause GC allocation
}
```

Indeed, such literals may well **allocate a new array on the GC heap**.

## The little template that could

Fortunately, like often in the D world, there is an easy work-around to lift the limitations.


```d
T[n] s(T, size_t n)(auto ref T[n] array) pure nothrow @nogc @safe
{
    return array;
}

void main() @nogc
{
    int[] myDynamicArray = [1, 2, 3].s; // Slice that static array which is on stack

    // Use myDynamicArray...
}
```

## Beware of the stack lifetime

That work-around slices the stack allocated array and turn it into a slice. This would lead to memory corruption if the reference escapes. 

Do not fear! The compiler warns you of escaped references to the stack, even in unsafe D.

```d
// This function is illegal
int[] doNotDoThat() @nogc
{
    return [1, 2, 3].s; // Error: escaping reference to stack allocated 
                        // value returned by s([1, 2, 3])
}
```

Instead, duplicate this slice `@nogc`-style, for example with `malloc`. **You are now able to use array literals in** `@nogc` **code.**

_This idiom originated from_ [Randy Schütt](https://github.com/Dgame). 