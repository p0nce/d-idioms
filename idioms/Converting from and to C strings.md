Converting from and to C strings
=============================

## Convert to C strings

Use `std.string.toStringz`.

```
extern(C) nothrow @nogc void log_message(const char* message);

void logMessage(string msg)
{
    import std.string: toStringz;
    log_message(toStringz(msg));
}
```

**D string literals are already zero-terminated**, you don't have anything to do in this case.

```
extern(C) nothrow @nogc void window_set_title(const char* title);

void main()
{
    window_set_title("Welcome to zombo.com");  // Works: literals terminated with '\0'
}

```

See also: [http://dlang.org/phobos/std_string.html#.toStringz](http://dlang.org/phobos/std_string.html#.toStringz)


## Convert from C strings

Use `std.string.fromStringz`.

```
extern(C) nothrow @nogc char* window_get_title(window_id id);

struct Window
{
    // Note: to avoid allocations you can return a slice within the C string
    // and keep the slice constant. Else you can use .dup or .idup to get
    // an immutable string.
    const(char)[] name(string msg)
    {
        import std.string: fromStringz;
        return fromStringz( window_get_title(_id) );
    }

    window_id _id;
}
```

**What if you already know the length of the C string?**

Then you can use regular slicing.

```
assert(len == strlen(messageC));
string messageD = messageC[0..len];
```


See also: [http://dlang.org/phobos/std_string.html#.fromStringz](http://dlang.org/phobos/std_string.html#.fromStringz)

