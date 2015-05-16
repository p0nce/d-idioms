=====================================
So what does `-release` do, exactly?
=====================================

In the DMD compiler, the `-release` switch does the following things:
- Removing contracts (`in` and `out` blocks).
- Removing bounds checking in all but `@safe` code. That means: `@trusted`, `@system`, and unmarked functions won't have bounds checks. To overide this behaviour, use the `-boundscheck` switch.
- Removing assertions, except `assert(false)` which is [special](#assert(false)-is-special).
**Failed assertions are considered Undefined Behaviour.** The optimizer can assume that a removed assertion always holds and use this fact for optimization.

See: [http://dlang.org/dmd-windows.html#switch-release](http://dlang.org/dmd-windows.html#switch-release)
