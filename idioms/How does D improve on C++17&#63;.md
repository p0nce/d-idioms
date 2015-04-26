============================
How does D improve on C++17?
============================

With C++ evolving and coming to C++17, **is D still relevant?**

Yes, and very much so. Here's is why.

## No more preprocessor

D has no need for a preprocessor.

## No more header files, today

Even in 2025 when C++ compilers get modules and you are finally allowed to use them, headers will still survive alongside modules in third-party libraries and for backward compatibility.

## No more order of declaration

Order of declaration is unsignificant in D. There is no need to predeclare or reorder anything.

## Faster compiles

C++ has [compilation speed problems](http://www.drdobbs.com/cpp/c-compilation-speed/228701711). For example the preprocessor needs to iterate on source files at least 3 times by design.

What happen in C++ shops is that people spend a significant amount of time **waiting for the compiler**.

## Lexing stage separated from parsing stage separated from semantics

No need for the semantic pass to separate the language in tokens.

## Name conflict bugs are impossible

A name conflict when importing modules with the same identifier trigger a compilation error. It is impossible to use the wrong symbol unknowingly.

## DUB

D has a package manager. C++ has none that is popular in its community.
Therefore, using a third-party library is many times easier.

## No more implicit conversion of arrays to pointers

It didn't make much sense even in C.

## Ranges simpler to implement than iterators

Ever tried implementing a C++ iterator? I'd bet it was fun.

## Move and copy semantics radically simplified

D makes the assumption that structs and classes are copyable by bit copy. It adds some restrictions on internal pointers, but overall it's simpler.

## `unittest` blocks

Unit-tests have been made a builtin in D to lower the barrier for testing.

## Documentation comments

Documentation comments are builtin to avoid the need for an external tool that inevitably nobody uses.

## The D STL is actually readable

C++'s STL are somewhat readable, but less so.

## No more diamond inheritance

C++ having multiple inheritance implies a [complex object model](www.amazon.fr/Inside-Object-Model-Stanley-Lippman/dp/0201834545).
With `alias this`, multiple implementation inheritance is pretty much unneeded.

## Saner operator overloading

Making custom numerical types requires a lot less operator overloads.

## ++pre and post-increment++ have been fixed

See how [here](#Should-I-use-++pre-increment-or-post-increment++?).

## GC

For the large majority of programs, the GC is a productivity enhancer. For the other programs, it's not that bad.

## No need for C++ templates heroes

The easier and more powerful templates in D allow the _average_ programmer to create meta-programs routinely. Not just one programmer in your team which happen to be comfortable with them.
