===============================
Grouping modules with package.d
===============================

`package.d` is a special filename which is used in import resolution. When reading:

```
import mymodule;
```

a D compiler will search for either `mymodule.d` or `mymodule/package.d` (and if both exist, it will complain about the name conflict).

This feature allows to organize modules logically and combined with `public import` to split big modules in several parts.


Here is an example:
```
// In file path/mypackage/package.d
module mypackage;
public import mypackage.foo;
public import mypackage.bar;
```

```
// In file path/mypackage/foo.d
module mypackage.foo;
```

```
// In file path/mypackage/bar.d
module mypackage.bar;
```

```
// In user code
// mypackage.foo and mypackage.bar are also imported
import mypackage;
```
