The importance of being `pure`
==============================

`pure` is a good looking function attribute that unfortunately doesn't seem to provide much value at first sight. On the other hand, who doesn't want to write `pure` code?

**How can we justify the horizontal space investment in** `pure` **annotations?**


## **Reason 1:** Purity helps with alias analysis

The compiler has to assume a non-`pure` function could modify any global state:
- global variables
- heap allocated by impure means
- I/O
- and so on

Let's say we have a function lacking a `pure` annotation.

```
extern(C) int impureFibonacci(int n);
```

This function gets called.

```
int result = impureFibonacci(8);
// Any global state could have changed, like allocated heap, global variables, and so on.
// That's like a barrier for the optimizer.
```

**The compiler must assume any global state could have changed.**

## **Reason 2:** `pure` is documentation

As dreadful as annotation streaks like `pure const nothrow @nogc` can be, they _are_ some kind of compiler-enforced documentation.

## More about purity

- [Purity in D](http://klickverbot.at/blog/2012/05/purity-in-d/) by David Nadlinger.

_This article was written with the help of_ [Amaury Sechet](https://github.com/deadalnix)_._