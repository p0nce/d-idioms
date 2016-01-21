====================================
Using `std.typecons.Flag` like a pro
====================================

Functions calls with boolean arguments are often hard to read and don't provide meaning.

```
void doSomething(bool frob);

...

doSomething(false);         // false what?
```

Fortunately `std.typecons.Flag`can help you turn `bool` arguments into readable flags at no cost.
Buy it now! At your local standard library dealer.


```
void doSomething(Flag!"frob" frob);

...

doSomething(No.frob);       // ok, no frob. Got it
```



## Here are the guidelines straight from Andrei Alexandrescu:

- Use the name `Flag!"frob"` for the type of the flag

- Use `Yes.frob` and `No.frob` for the flag values

- **Do not alias** `Flag!"frob"` **to a new name.**


For more documentation: [https://dlang.org/phobos/std_typecons.html#.Flag](https://dlang.org/phobos/std_typecons.html#.Flag)