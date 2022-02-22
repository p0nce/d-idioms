Trailing commas
===============

D accepts trailing commas in every comma-separated list of things.

```
// Function declarations
void doNothing(
        int unusedA,
        int unusedB,
    )
{
}

// enum declarations
enum
{
    whatever,
    yolo,
}

// Array literals
static immutable double[] valuesOfPI =
[
    22.0 / 7.0,
];

void main()
{
    // Function calls
    doNothing(
       0,
       31,
    );

    // AA literals
    string[int] severities =
    [
         0: "info",
         1: "warning",
         2: "error",
    ];
}
```