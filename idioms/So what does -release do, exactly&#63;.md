=====================================
So what does `-release` do, exactly?
=====================================

In D compilers, the `-release` switch does the following things:
- Removing contracts (`in` and `out` blocks).
- Removing bounds checking in all but `@safe` code. That means: `@trusted`, `@system`, and unmarked functions won't have bounds checks. To overide this behaviour, use the `-boundscheck` switch.
- Removing assertions, except `assert(false)` which is [special](#assert(false)-is-special).
**Failed assertions are considered Undefined Behaviour.** The optimizer can assume that a removed assertion always holds and uses this fact for optimization.

See: [http://dlang.org/dmd-windows.html#switch-release](http://dlang.org/dmd-windows.html#switch-release)

**TRIVIA:** Regardless of the use of `-release`, assertions are always on whenever the `-unittest` flag is passed to the compiler. This is the sort of special case that breathes life in this very page!