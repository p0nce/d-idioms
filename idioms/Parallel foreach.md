Parallel foreach
===========

This performs a parallel loop with a default task pool.

```
import core.atomic;
import std.parallelism;
import std.range;

void main()
{
    shared(int) A = 0;
    foreach(n; iota(2000).parallel)
    {
        atomicOp!"+="(A, 1);
    }
    assert(A == 2000);
}
```
