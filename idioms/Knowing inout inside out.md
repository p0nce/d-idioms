==========================
Knowing `inout` inside out
==========================

`inout` **is a good-looking storage class. When should it be used?**

## Firstly, `inout` is great for **writing getters returning references**.

```
struct MyBuffer(T)
{
    private T* data;

    // This getter needs inout to fit MyBuffer,
    // const(MyBuffer) or immutable(MyBuffer) as caller
    inout(T)* getData() inout // <= 2nd inout applies to "this"
    {
        return data;
    }
}
```

It avoids to write the longer equivalent:

```
// Longer struct without inout
struct MyBuffer(T)
{
    private T* data;

    T* getData()
    {
        return data;
    }

    const(T)* getData() const
    {
        return data;
    }

    immutable(T)* getData() immutable
    {
        return data;
    }
}
```

## Secondly, `inout` is also useful for free functions walking reference types:

```
// An example of a useful free function using inout
inout(char)[] chomp(inout(char)[] str)
{
    if (str.length && str[$-1] == '\n')
        return str[0..$-1];
    else
        return str;
}
```

## It is allowed to use `inout` variables inside of an `inout`-enabled function:

```
// Useless example to demonstrate inout local variables
inout(int)[] lastItems(inout(int)[] arr, size_t pivot)
{
    // Local inout variables are allowed
    inout(int)[] lasts = arr[nth+1..$];
    return lasts;
}
```

But `inout` member variables are **not** allowed, because `inout` doesn't mean anything outside the context of a function.

```
struct InoutMember
{
    inout(int) member; // Wrong, won't compile
}