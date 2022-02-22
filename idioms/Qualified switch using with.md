Qualified switch using "with"
=============================


Let's say we have an enum:

    enum MyEnum
    {
        small,
        normal,
        huge
    }

Switching on an enum value is annoying and redundant: `MyEnum` has to be repeated for each case.

    final switch(enumValue)
    {
    case MyEnum.small:
        writeln("small");
        break;
    case MyEnum.normal:
        writeln("normal");
        break;
    case MyEnum.huge:
        writeln("huge");
        break;
    }


We can work-around this by using `with`:

    final switch(enumValue) with (MyEnum)
    {
    case small:
        writeln("small");
        break;
    case normal:
        writeln("normal");
        break;
    case huge:
        writeln("huge");
        break;
    }


This idiom was discovered by [Amaury Sechet](https://github.com/deadalnix).
