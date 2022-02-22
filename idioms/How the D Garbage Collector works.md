How the D Garbage Collector works
=================================

There seems to be a stigma surrounding Garbage Collection when you talk to C++ users. The GC would be an wild memory-hungry beast that can't be tamed, essentially outside the control of the programmer. It would render real-time work [impossible](#The-impossible-real-time-thread) by its mere presence.


But the D Garbage Collector is firmly under the application control. Once you learn how it works, it doesn't seem so uncontrollable, and reveal itself as what it really is: a [trade-off](http://dlang.org/garbage.html) that most modern languages have choosen.

## How the D GC works:


First of all, collections are **not triggered randomly** but when a thread allocates memory.

- A thread tries to allocate memory. At this point the GC may decide to collect garbage. If so, the current thread is _hijacked_ for GC work.
- Memory ranges, starting from _roots_, are scanned recursively looking for more pointers into GC-owned memory. Each memory regions use markers to avoid scanning the same block of memory multiple times. **This step can be slow.** The GC features optimizations to speed-up scanning: heap areas are labelled with types, only areas with pointers are scanned, and pointer to GC memory have [restrictions](http://dlang.org/garbage.html).
- GC allocated memory that has no active pointers to it and do not need destructors to run is freed.
- Conversely, all unreachable memory that needs destructors to run is queued.
- All threads are resumed. The GC pause is then finished.
- Destructors for all queued memory are run. Unfortunately there is [caveats](#The-trouble-with-class-destructors) associated with the GC thread calling destructors.
- Remaining unreachable memory is freed.
- The current thread returns to whatever work it was doing.

## Tips

Intuitively, one can see that memory scanning is a potentially long and expensive process. Keeping a small GC heap makes it faster.
What you can do to accelerate scanning is using `malloc`/`free` instead of `new` to allocate big chunks of memory.
Anything that reduces the total amount of GC-owned memory will reduce the maximum pause duration.

## More about the GC
See: [http://dlang.org/garbage.html](http://dlang.org/garbage.html).
