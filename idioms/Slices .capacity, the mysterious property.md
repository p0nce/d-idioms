===========================================
Slices `.capacity`, the mysterious property
===========================================

Dynamic arrays aka slices in D have a `.capacity` property: the maximum length the slice can reach before needing reallocation.

```
int[] arr = new int[10];
writeln(arr.capacity);
assert(arr.capacity >= arr.length);
```

Since `.capacity` is read-only, the `.reserve` builtin property also exist to ensure allocation size. This is similar to C++'s `std::vector::capacity()` and `std::vector::reserve(size_t n)`. Handy!

```
T[] arr;
arr.reserve(N);
foreach(i ; 0..N)
  arr ~= expr(i);                        // guaranteed not to allocate in the loop
```

I hear you saying: **"How is that possible since D slices are only a pointer and a length?"**
There is a trick, getting that information relies on the GC, and slices pointing to non-GC memory will report a capacity of 0 which means reallocating is mandatory for appending.

```
char[16] hexChars = "0123456789abcdef";
char[] decChars = hexChars[0..10];
writeln(decChars.capacity);              // output '0' since decChars points to non-GC memory

decChars = decChars.dup;                 // makes a GC copy of the slice
writeln(decChars.capacity);              // outputs non-zero value now that decChars points to GC memory
```
