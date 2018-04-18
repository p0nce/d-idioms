==================================
So what does `-debug` do, exactly?
==================================

In D compilers, the `-debug` switch does **only one thing**: compiling in code in `debug` clauses.

```
debug
{
    writeln("-debug was used");
}
else
{
    writeln("-debug was NOT used");   
}
```



- The `-debug` switch has **nothing to do with debug information (-g)** of lack thereof.

- The `-debug` switch has **nothing to do with optimizations (-O)** or lack thereof.

- The `-debug` switch has **nothing to do with the -release switch**, in fact both switches can be used at once, or none.

- **There is no "debug mode" or "release mode" in D compilers**, those are a DUB convention.


## `debug` identifiers: who are they and what do they want?

You can define a "debug identifier" `ident` that will be compiled in if `-debug=ident` is passed through the command-line.


```
debug(complicatedAlg)
    writeln("-debug=complicatedAlg was used"); // useful for debug logging
else
    writeln("-debug=complicatedAlg was NOT used");
```

That makes `debug` remarkedly similar to... `version`.


## `debug` is indeed strikingly similar to `version`

The **2 key differences** between `-debug` and `-version` are:

- Semantic: `version` is for software features, and `debug` is to enable logging/information/statistics... about programs with no user-facing effect.

- Quick printf-debugging: under a `debug` clause, you don't have to follow `pure`, `nothrow`, `@nogc` or `@safe`. It's a special case in the compiler to enable debug logging.

**Breaking** `pure`/`@nogc`/`nothrow`/`@safe` **with** `-debug` **is Undefined Behaviour**, though in most cases it will work just fine and you don't have to worry. Just **don't ship code with -debug** enabled.


Read more about `-debug`: [https://dlang.org/dmd-windows.html#switch-debug](https://dlang.org/dmd-windows.html#switch-debug)