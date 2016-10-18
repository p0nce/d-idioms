======================
Let compiler determine length for fixed-length arrays
======================

In C/C++ you can write:
```c
int as[] = {1, 2, 3};
// or
auto as = {1, 2, 3};
```
And you get a static array with a length of 3. The Compiler will determine the length for you.
The same is not possible in D, because
```d
int[] as = [1, 2, 3];
// or
auto as = [1, 2, 3];
```
will (without optimizations etc.) allocate a **dynamic** array on the GC heap.
But it would be very convenient, e.g. if you want to pass the array directly to a function:
```d
void foo(int[3] xyz)
{
	// Do something with xyz
}

foo([1, 2, 3]); // this will allocate
```
But you can avoid that:

```d
@nogc @safe
T[n] s(T, size_t n)(auto ref T[n] array) pure nothrow
{
	return array;
}

void foo(int[3] xyz)
{
	// Do something with xyz
}

foo([1, 2, 3].s);
```

Sadly you can also write
```d
int[] as = [1, 2, 3].s;
```
which will slice the stack allocated array and can lead to memory corruption.
This is not a failure of the function or a bug in D, it's a well known "feature" which you should enjoy with caution.