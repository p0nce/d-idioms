===============================
The impossible real-time thread
===============================

It is often said on Internet forums that D couldn't possibly do real-time work, since _its stop-the-world GC might pause every thread at once_.

**This is wildly inaccurate.** The GC pauses all threads _registered to the D runtime_.


Real-time threads like audio callbacks are doable since forever. Here is how:


- Use a thread that isn't registered. Such a thread could be created by an external library, or with `core.thread.Thread` and then unregistered with [`thread_detachThis()`](http://dlang.org/phobos/core_thread.html#.thread_detachThis). This moves the thread out of [druntime](https://github.com/D-Programming-Language/druntime) supervision: it won't be stopped by the GC, and won't be able to use GC allocations.

- Make the thread function or callback `@nogc`. This will enforce you don't use the GC.

**Another limitation:** Such a thread must not hold roots to GC objects. What it means is that you **can** use GC objects from the real-time thread, but these GC objects should be pointed to by registered threads to avoid them being collected.
