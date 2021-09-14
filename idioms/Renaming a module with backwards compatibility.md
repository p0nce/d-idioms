==============================================
Renaming a module with backwards compatibility
==============================================

It is easy to rename a function or object in D with the `deprecated alias` idiom.


```d
deprecated("Use myNewFun() instead") alias myOldFun = myNewFun; 

void myNewFun()
{
     // Show a deprecation message if called with myOldFun() name
}
```

` deprecated` can also be used for module renaming.

```d
deprecated("Import lib.newer.mod; instead") module lib.older.mod;

public import lib.newer.mod; 
```

However, at times you might want to write code that can work without deprecation message, with either the new or old module name.

That is also possible:

```d
static if (__traits(compiles, (){import my.renamed.mod;})) 
    import my.renamed.mod;
else
    import my.original.mod;
```

The origin of that idiom is unknown, but probably first appeared in the [arsd library](https://github.com/adamdruppe/arsd).