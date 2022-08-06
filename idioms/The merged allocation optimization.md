The merged allocation optimization
==================================

One of the most suprisingly effective optimization is to merge your array allocations together, if they have a chance to be accessed together. 

You can do that with eg. `MergedAlloc`, a handy way to do that in an aggregate, that supports alignment, does the memory reclaim, and supports both pointers and slices.


## Usage

Consider the following `struct`. It process things with intermediate buffers, who themselved have alignment requirements.

```d
struct A
{
    float[] buf0;
    int[]   buf1;
    double* buf2;

    void init(int n)
    {
        // allocate arrays
        buf0 = allocateAligned!float(n, 16);
        buf1 = allocateAligned!int(n, 16);
        buf2 = allocateAligned!double(n, 16).ptr;
    }

    ~this()
    {
        // reclaim memory
        deallocate(buf0); 
        deallocate(buf1);
        deallocate(buf2);
    }

    void process(float[] input)
    {
        // Do things with buf0, buf1, buf2, and input
    }
}
```

Let's introduce `MergedAlloc` instead to have all the arrays in a single `malloc` call.


```d
struct A
{
    float[] buf0;
    int[]   buf1;
    double* buf2;
    MergedAllocation mergedAlloc;

    void init(int n)
    {
        mergedAlloc.start();       // initialize merged alloc counter
        layout(n);                 // first layout call count the bytes
        mergedAlloc.allocate();    // make single allocation
        layout(n);                 // second layout call sets the final pointers
    }

    void layout(int n)
    {
        mergedAlloc.allocArray(buf0, n, 16);
        mergedAlloc.allocArray(buf1, n, 16);
        mergedAlloc.alloc(buf2, n, 16);
    }

    void process(float[] input)
    {
        // Do things with buf0, buf1, buf2, and input
    }
}
```

The `layout` functions is called twice:
- first call is as if the allocation was at address `0`, and simply count the bytes
- second call sets the right pointers into fields, into the merge allocation


## `MergedAlloc` implementation

See its [source code](https://github.com/AuburnSounds/Dplug/blob/master/core/dplug/core/vec.d#L593).