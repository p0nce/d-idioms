========================================================
Everything you wanted to ask about `struct` construction
========================================================


```
// This is explicit constructor call
MyStruct a = MyStruct(0);     

// This is an implicit constructor call
MyStruct b = 1;               

// Blit and eventually postblit call if it is defined
MyStruct c = b;           

// Same as previous line, parameters created from existing structs
f(c);                         

// Implicit call to `opAssign` with an `int` parameter, fails if it doesn't exist
a = 2;                        

// Implicit call to default opAssign, or a custom one with a `MyStruct` parameter
b = a;

// Same as previous line, but the temporary instance is created
c = MyStruct(3);
```


## The rules to remember

- **Struct declarations are the one place in D where implicit construction can happen.**

- Postblits only happen when a new struct is created from an existing one. If the destination already exists it's a regular `opAssign` call instead.

- To avoid unecessary copy-construction resources, either disable the post-blit or pass such structs by reference.

- When an aggregate is created, its members don't get constructed but default initialized with `.init`.
