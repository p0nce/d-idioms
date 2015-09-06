========================================================
Friend don't let friends use the default struct postblit
========================================================

By default D structs are copyable and that copy is just a `.dup` verbatim bit copy.
Indeed the default struct [postblit](http://dlang.org/struct.html) does nothing.

```
struct MyStruct
{
    int field;
}

MyStruct a;
MyStruct b;

a = b; // Bit copy here.
```

The trouble happens with structs that hold a resource: whenever copied, the struct destructor would be called twice, and twice the resource would be freed.

That doesn't look like the beginning of a success story. To solve this, follow the Rule of Two.


## Rule of Two

**If a struct has a non-trivial destructor, then:**
**- either disable the default postblit with `@disable this(this)`**,
**- or implement the postblit.**
**Don't let the default one.**


## Example

```
struct MyResource
{
    this()
    {
        acquireResource();
    }

    ~this()
    {
        releaseResource();
    }

    // Disabling the postblit to avoid the destructor being
    // called twice after an accidental copy.
    @disable this(this);

    /*
        // Alternatively, duplicate the resource
        this(this)
        {
            duplicateResource();
        }
    */
}

```



See: [http://dlang.org/struct.html](http://dlang.org/struct.html)

