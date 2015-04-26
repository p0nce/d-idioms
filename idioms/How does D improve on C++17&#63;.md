============================
How does D improve on C++17?
============================

**Warning: this article is opinionated.**

&nbsp;

With C++ evolving and coming to C++17, **is D still relevant?**

I think that yes, and very much so. Here's is why.

## No more preprocessor

D has no need for a preprocessor.

## No more header files, today

Even when C++ compilers implement modules and you can finally use them, headers will still survive alongside modules for backward compatibility.

## No more order of declaration

Order of declaration is insignificant in D. There is no need to pre-declare or reorder anything.

## Faster compiles

C++ has [compilation speed problems](http://www.drdobbs.com/cpp/c-compilation-speed/228701711). For example the preprocessor needs to iterate on source files at least 3 times by design.


What happens in C++ shops is that programmers spend a significant amount of time waiting for the compiler.

## Lexing stage separated from parsing stage separated from semantics

No need for the semantic pass to separate the language in tokens.

## Name conflict bugs are impossible

A name conflict when importing modules with the same identifier triggers a compilation error. It is thus impossible to use the wrong symbol by mistake.

## Default initialization

Uninitialized variables can create subtle and hard to find bugs in C++ programs. In D all variables and members are initialized by default. If that happens to be expensive, the `= void` initialization can be used instead.

## DUB

D has a package manager. C++ has none that is popular in its community.
Therefore, using a [third-party library](http://code.dlang.org/) is many times easier.

## No more implicit conversion of arrays to pointers

It didn't make much sense even in C.

## Ranges simpler to implement than iterators

Ever implemented a C++ iterator? It can be a bit tricky.

## Move and copy semantics radically simplified

D makes the assumption that structs and classes are copyable by bit copy. It adds some restrictions on internal pointers, but overall it's simpler.

## `unittest` blocks

Built-in unit-tests lower the barrier for testing.

## Documentation comments

Built-in documentation comments avoid the need for an external tool that inevitably nobody uses.

## The D STL is actually readable

C++'s STL are somewhat readable, but less so.

## No more diamond inheritance

C++ having multiple inheritance implies a [complex object model](http://www.amazon.fr/Inside-Object-Model-Stanley-Lippman/dp/0201834545).
With `alias this`, multiple implementation inheritance is pretty much never needed.

## Saner operator overloading

Making custom numerical types requires a lot less operator overloads.

## ++pre and post-increment++ have been fixed

See how [here](#Should-I-use-++pre-increment-or-post-increment++?).

## GC

For the large majority of programs, the GC is a productivity enhancer. For the other programs, it's [not that bad](#How-the-D-Garbage-Collector-works).

## No need for C++ template's heroes

The easier and more powerful templates in D allow the _average_ programmer to create meta-programs routinely. Not just one programmer in your team which happen to be comfortable with them.


&nbsp;

## Downsides

For balance, here are the downsides **(opinionated again)**:

- D has a way smaller (growing) community.
- C++ has nice, composable RAII. D has a more complicated [story](#The-trouble-with-class-destructors) with resources.
- D is easy to start using but not that easy to use really well. Hence, this website.
- Not every purpose is compatible with a GC.

