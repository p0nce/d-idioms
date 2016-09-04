=========================================
So what do module declarations do, exactly?
=========================================

Module declarations are the things found at the top of modules.

```
module fancylib.interfaces; // this is a module declaration aka module directive
```

They seem simple enough, but elicit a number of questions in the long run:

- _What if we don't name them after their position in the file system?_

- _What if we omit module declarations like some D programs do?_


## Every module has a name

Every module has a module name whether it has a `module` declaration or not.

If you don't use one, the compiler uses the file name by default, but *only* the file name. The path on the file system is in no way taken into account.

Given a source file `source/foo.d`, using the following declaration is the same as not using a module declaration at all:

```
module foo; // can be omitted for a file source/foo.d
```

However, you rarely want to omit module declarations, we'll see why.



## Module names role in ` import`

When a module is imported, the compiler will search for it in D files directly given through the command-line. If this fails, it will append the module name to import directories (the paths given with `-I`) in order to find such a file.

```
// Do I know such a module with this name?
// Can I find it in <import-paths>/mylib/foo/bar.d otherwise?
import mylib.foo.bar;
```


## If you need to remember one thing

Modules have two ways to be found:
  - Being passed directly on the command-line. In this case, modules can hold any name in the `module` declaration, as long as such names are used consistently.
  - Using the module name to search inside import directories given by `-I`.

Unless your program is small and self-contained, you should prefer the latter, and use module names matching file pathes in the file-system.