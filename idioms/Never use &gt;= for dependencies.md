=============================
Never use >= for dependencies
=============================

Using DUB and dependencies? Here is a pattern you should avoid:

```
{
    "name": "my-program",

    "dependencies":
    {
        "awesome-lib": ">=1.0.0"
    }
}


```

Depending on a library using `>=` is risky. If `awesome-lib` breaks its API then releases a new major tag, your project will break. This is implicit in SemVer and using `>=` suscribes for immediate breakage.

Now this can be useful for executables, but this is especially bad for publicly released libraries. Any downstream project might break in the future when using your already released tags. And _how will you fix tags that are already in use?_


**TL;DR Do not depend on APIs that will break in the future. Use `~>` or `==` instead.**


See: [http://code.dlang.org/package-format#version-specs](http://code.dlang.org/package-format#version-specs)
