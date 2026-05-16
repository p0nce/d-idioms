Precise timestamps in microseconds
==================================

```
/// Returns: Most precise clock ticks, in microseconds (us).
long getTickUs() nothrow @nogc
{
    import core.time;
    return convClockFreq(MonoTime.currTime.ticks, MonoTime.ticksPerSecond, 1_000_000);
}

```

