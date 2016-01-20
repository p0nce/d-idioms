=============================
Static arrays are value types
=============================

It's important to note that static arrays in D are value types.

```
void addFour(int[16] arr) // The whole of arr is passed on the stack.
{
    arr[] += 4;           // Only the local version is modified.
}

void main()
{
    int[16] a;
    addFour(a);               // a passed by value on the stack, not by pointer.
}
```

That makes such declaration a trap when porting functions from C or C++.

## Static arrays convert implicitely into slices!

To pass static arrays by reference, either write a function taking a slice or use ref.

```
void addFive(ref int[16] arr)
{
    arr[] += 5;         // Caller parameter modified.
}

void addSix(int[] arr)
{
    arr[] += 6;         // Caller parameter modified.
}

void main()
{
    int[16] a;
    addFive(a);         // Works, a is passed by reference
    addSix(a);          // Works, a is converted into a slice referencing the same data
}
```


