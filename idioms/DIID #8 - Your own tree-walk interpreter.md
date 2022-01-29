# DIID #8 - Your own tree-walk interpreter

**Solution:** Use the `pegged` [package](https://code.dlang.org/packages/pegged).

## `dub.json`

```json
{
    "name": "treewalk-interpreter",
    "dependencies":
    {
        "pegged": "~>0.0"
    }
}
```

## `source/main.d`

```d
import std.conv;
import pegged.grammar;

mixin(grammar(`
Arithmetic:
    Term     < Factor (Add / Sub)*
    Add      < "+" Factor
    Sub      < "-" Factor
    Factor   < Primary (Mul / Div)*
    Mul      < "*" Primary
    Div      < "/" Primary
    Primary  < Parens / Neg / Number / Variable
    Parens   < :"(" Term :")"
    Neg      < "-" Primary
    Number   < ~([0-9]+)
    Variable <- identifier
`));

double interpreter(string expr)
{
    auto p = Arithmetic(expr);

    double value(ParseTree p)
    {
        switch (p.name)
        {
            case "Arithmetic":
                return value(p.children[0]);
            case "Arithmetic.Term":
                double v = 0.0;
                foreach(child; p.children) v += value(child);
                return v;
            case "Arithmetic.Add":
                return value(p.children[0]);
            case "Arithmetic.Sub":
                return -value(p.children[0]);
            case "Arithmetic.Factor":
                double v = 1.0;
                foreach(child; p.children) v *= value(child);
                return v;
            case "Arithmetic.Mul":
                return value(p.children[0]);
            case "Arithmetic.Div":
                return 1.0/value(p.children[0]);
            case "Arithmetic.Primary":
                return value(p.children[0]);
            case "Arithmetic.Parens":
                return value(p.children[0]);
            case "Arithmetic.Neg":
                return -value(p.children[0]);
            case "Arithmetic.Number":
                return to!double(p.matches[0]);
            default:
                return double.nan;
        }
    }
    return value(p);
}

void main(string[] args)
{
    assert(interpreter("3 * 1 - (3 + 3) * 4") == -21);
}
``` 

Get `pegged` documentation [here](https://github.com/PhilippeSigaud/Pegged).
Get the source code for all DIID examples [here](https://github.com/p0nce/DIID).