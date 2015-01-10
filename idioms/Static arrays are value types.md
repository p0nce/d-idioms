=============================
Static arrays are value types
=============================

It's important to note that static arrays in D are value types.

    void addFour(int[16] arr) // The whole of arr is passed on the stack.
    {
        arr[] += 4;           // Only the local version is modified.
    }
    int[16] a;
    addFour(a);               // a passed by value on the stack, not by pointer.

That makes such declaration a trap when porting functions from C or C++.


To pass static arrays by reference, either write a function taking a slice or use ref.

    void addFive(ref int[16] arr)
    {
        arr[] += 5;         // Caller parameter modified.
    }
    void addSix(int[] arr)
    {
        arr[] += 6;         // Caller parameter modified.
    }
    int[16] a;
    addFive(a);
    addSix(a);              // Static arrays implicitely convertible to slices.


