Precise timestamps in milliseconds
==================================

`core.time.MonoTime.currTime()` returns the most precise (as opposed to *accurate*) available clock.

```
/// Returns: Most precise clock ticks, in milliseconds.
long getTickMs() nothrow @nogc
{
    import core.time;
    return convClockFreq(MonoTime.currTime.ticks, MonoTime.ticksPerSecond, 1_000);
}

```

