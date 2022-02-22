Skip initialization with `= void`
=================================

In D, everything is initialized by default.
Because it may have a runtime cost, the syntax `= void` allows to skip default assignment for stack variables.

```
void bark()
{
    int dog = void; // dog contains garbage
    if(cond)
        dog = 1;
    else
        dog = 2;
}
```

`= void` is also accepted for `struct` or `class` members but doesn't do anything useful at the moment. Don't use it there.


