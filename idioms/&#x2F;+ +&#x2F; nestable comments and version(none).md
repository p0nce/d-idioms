=============================================
`/+ +/` nestable comments and `version(none)`
=============================================

In addition to single-line comments `//` and block comments `/* */`, D supports nestable block comments with `/+ +/`.

```
/+
    This whole block is commented.

    /**
     * A documented function.
     */
    void doStuff()
    {
        // blah blah
    }

    /+
      Such block comments are nestable.
    +/
+/

```


They are handy when commenting large swaths of code. It would be the D equivalent to `#if 0` / `#endif` pairs in C or C++.


If you prefer the commented portion of code to stay valid, prefer using `version(none)`.

```
version(none)
{
    // This whole block is commented, but still must parse.

    /**
     * A documented function
     */
    void doStuff()
    {
        // blah blah
    }
}

```

Indeed, `none` is a special version identifier that cannot be set.

```
version = none; // Error: version identifier 'none' is reserved and cannot be set
```
