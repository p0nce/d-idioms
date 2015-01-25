================
Real-time thread
================

It is often said on Internet forums that D couldn't possibly do real-time work, since _its stop-the-world GC might pause every thread at once_.

**This is wildly inaccurate.** The GC pauses all threads _that have been registered_.


Real-time threads like audio callbacks are doable since forever. Here is how:


- Use a thread that isn't registered. Such a thread could be created by an external library, or with `core.thread.Thread` and then [unregistered](http://dlang.org/phobos/core_thread.html#.thread_detachThis).

- Make the thread function `@nogc`. You can't use the GC from an unregistered thread.

**Another limitation:** Such a thread must not hold roots to GC objects. What it means is that you can use GC objects from the real-time thread, but these GC objects should be pointed to by other threads to avoid them being collected.
