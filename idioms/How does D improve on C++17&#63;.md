============================
How does D improve on C++17?
============================

**Warning: this post is opinionated.**

&nbsp;

With C++ evolving and coming to C++17, **is D still relevant?**

I think that yes, and very much so. Here's is why.

## DUB

D has a package manager. C++ has none that is popular in its community.
Using a [third-party library](http://code.dlang.org/) becomes many times easier.

## No more preprocessor

D has no need for a preprocessor.

## No more header files, today

Even when C++ compilers implement modules and you can finally use them, headers will still survive alongside modules for backward compatibility.

## No more order of declaration

Order of declaration is insignificant in D. There is no need to pre-declare or reorder anything.

## Faster compiles

C++ has [compilation speed problems](http://www.drdobbs.com/cpp/c-compilation-speed/228701711). For example the preprocessor needs to iterate on source files at least 3 times by design.

In C++ development, significant amounts of time can be spent waiting for the compiler.

## Default initialization

Uninitialized variables can create subtle and hard to find bugs in C++ programs. In D all variables and members are initialized by default. If that happens to be expensive, the `= void` initialization can be used instead.

## Name conflict bugs are impossible

A name conflict when importing modules with the same identifier triggers a compilation error. It is thus impossible to use the wrong symbol by mistake.

## No more implicit conversion of arrays to pointers

This is a long-standing problem with C and C++.

## Ranges vs Iterators

Ranges provides a number of [advantages](http://accu.org/content/conf2009/AndreiAlexandrescu_iterators-must-go.pdf) over iterators, being essentially a better tool for iteration.

## Move and copy semantics radically simplified

D makes the assumption that structs and classes are copyable by bit copy. It adds some restrictions on internal pointers, but overall it's simpler.

## `unittest` blocks

Built-in unit-tests lower the barrier for testing.

## Documentation comments

Similarly built-in documentation comments lower the barrier for writing documentation comments.

## The D STL is actually readable

Reading Phobos source code is easy and often enlightening.

## Simpler object model

C++ having multiple inheritance implies a [complex object model](http://www.amazon.fr/Inside-Object-Model-Stanley-Lippman/dp/0201834545).
With `alias this`, multiple implementation inheritance is pretty much never needed.

## Streamlined operator overloading

Making custom numerical types requires a lot less operator overloads.

## ++pre and post-increment++ have been fixed

See how [here](#Should-I-use-++pre-increment-or-post-increment++?).

## GC

For the large majority of programs, the GC is a productivity enhancer. For the other programs, it's [not that bad](#How-the-D-Garbage-Collector-works) and can be work-arounded.

## No need for C++ templates heroes

The easier and more powerful templates of D allow _any_  programmer to create meta-programs routinely. Not just one programmer in your team which happen to be comfortable with them.

## Large language, but approachable

Learning to use D well is tricky, but you can use a subset from the get-go.


&nbsp;

## Downsides

For balance, here are the downsides **(opinionated again)**:

- D has a smaller (growing) community.
- C++ has nice, composable RAII. D has a more complicated [story](#The-trouble-with-class-destructors) with resources.
- D is easy to start using but not that easy to use really well. Hence, this website.
- Not every purpose is compatible with a GC.

