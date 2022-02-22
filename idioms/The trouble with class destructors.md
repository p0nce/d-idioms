The trouble with class destructors
==================================

Despite having a GC, resource management in D is one of the most difficult point of the language.

In particular, class destructors in D enjoy a variety of limitations you should be aware of.

## 1. Don't expect class destructors to be called at all by the GC

The garbage collector is not guaranteed to run the destructors for all unreferenced objects.

## 2. Don't expect class destructors to be called timely and by the right thread

Class destructors might be called **when a collect is performed** which can be later than you wished and by **any thread** the GC is currently running on.

## 3. Don't expect members to be valid in a class destructor

The order in which the garbage collector calls destructors for unreferenced objects is _not specified_. **Don't use members in class destructors if you expect to be called by the GC.**

## 4. Don't allocate within a destructor called by the GC

Using GC allocation is forbidden within a class destructor.

## 5. Don't assume a class destructor won't be called because the constructor threw an exception.

If a class constructor throw, the corresponding destructor **will** be called as part of the normal teardown sequence! Be prepared for this: your class destructor should check for object validity.


## Conclusion

All this is in sharp contrast with the deterministic way C++ deals with destructors. However, all these constraints go away if destructors are called manually using:
- `std.typecons.scoped` (documentation [here](http://dlang.org/phobos/std_typecons.html#.scoped))
- `std.typecons.Unique` (documentation [here](http://dlang.org/phobos/std_typecons.html#.Unique))
- calling [`destroy`](http://dlang.org/phobos/object.html#.destroy) on an object manually
- using `delete` or `scope class` (deprecated)


**TL;DR There is not much that can safely be done in a class destructor if called by the GC. A solution to this problem is** [GC-proof resource classes](#GC-proof-resource-class).

See: [http://dlang.org/class.html](http://dlang.org/class.html)
