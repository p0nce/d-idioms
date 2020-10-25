=======================
GC-proof resource class
=======================

Class destructors have painful [limitations](#The-trouble-with-class-destructors) when called by the GC.

But there is a way to make a class holding a resource that:
- works with scoped ownership (`std.typecons.RefCounted`, `std.typecons.Unique`, `std.typecons.Scoped`)
- works with manual release (`object.destroy`)
- warns when the GC call the destructor and then release the resource, which is _coincidental correctness_ and dangerous to rely on.

The general idea behind the **GC-proof resource class** is to check why the destructor was called and act accordingly.

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
        // Important bit.
        // Here we verify that the GC isn't responsible
        // for releasing the resource, which is dangerous.
        import core.memory;
        assert(!GC.inFinalizer, "Error: clean-up of MyGCProofResource incorrectly" ~
                                " depends on destructors called by the GC");

        // release resource
        free_handle(handle);
    }
}
```

You'll get a clear message whenever you rely on the GC to release resources.

This idiom was first introduced in the [GFM](https://github.com/d-gamedev-team/gfm) library.

