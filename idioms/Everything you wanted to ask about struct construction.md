Everything you wanted to ask about `struct` construction
========================================================


## Isn't that a bit complicated?

```
struct MyStruct
{
    this(int dummy)
    {
    }
}


// This is explicit constructor call
MyStruct a = MyStruct(0);     

// This is an implicit constructor call
MyStruct b = 1;               

// Blit, and eventually postblit call if it is defined
MyStruct c = b;           

// Same as previous line, parameters created from existing structs
myFunction(c);                         

// Implicit call to `opAssign` with an `int` parameter, fails if it doesn't exist
a = 2;                        

// Implicit call to default opAssign, or a custom one with a `MyStruct` parameter
b = a;

// Same as previous line
// Except a temporary instance is created and destroyed on that line
c = MyStruct(3);


struct MyAggregateStruct
{
    // `MyStruct(0)` evaluated at CTFE, 
    // not during MyAggregateStruct construction!
    MyStruct a = MyStruct(0); 
}

```


## The rules to remember

- **Struct declarations are the one place in D where implicit construction can happen.**

- Postblits only happen when a new struct is created from an existing one. If the destination already exists it's a regular `opAssign` call instead.

- To avoid unnecessary copy-construction, either `@disable` the post-blit or pass such a `struct` by reference.

- When an aggregate is created, its members don't get constructed but default initialized with `.init`. Default values for members gets evaluated using CTFE, and stuffed into `.init`.
