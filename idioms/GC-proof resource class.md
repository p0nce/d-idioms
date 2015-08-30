=======================
GC-proof resource class
=======================

Class destructors have painful [limitations](#The-trouble-with-class-destructors) when called by the GC.

But there is a way to make a class holding a resource that:
- works with scoped ownership (`std.typecons.RefCounted`, `std.typecons.Unique`, `std.typecons.scoped`)
- works with manual release (`std.object.destroy`)
- warns when the GC call the destructor and then release the resource, which is _coincidental correctness_ and dangerous to rely on.

The general idea is to check why the destructor is called and act accordingly.

```
class MyGCProofResource
{
    void* handle;

    this()
    {
        // acquire resource
        handle = create_handle();
    }

    ~this()
    {
        // Such a destructor must support repeated calls for
        // the case when it is first called by destroy() and
        // then called by the GC later
        if (handle != null)
        {
            // Important bit.
            // Here we verify that the GC isn't responsible
            // for releasing the resource
            debug ensureNotInGC("MyResource");

            // release resource
            free_handle(handle);
            handle = null;
        }
    }
}
```

The `ensureNotInGC()` function can be implemented like this:

```
void ensureNotInGC(string resourceName) nothrow
{
    import core.exception;
    try
    {
        // This will throw InvalidMemoryOperationError when
        // called from within the GC since you can't use GC
        // allocation.
        import core.memory;
        GC.malloc(1);
        return;
    }
    catch(InvalidMemoryOperationError e)
    {
        import core.stdc.stdio;
        fprintf(stderr, "Error: clean-up of %s incorrectly"
                        " depends on destructors called by the GC.\n",
                        resourceName.ptr);
        assert(false); // crash
    }
}
```

This idiom was first introduced in the [GFM](https://github.com/d-gamedev-team/gfm) library.

