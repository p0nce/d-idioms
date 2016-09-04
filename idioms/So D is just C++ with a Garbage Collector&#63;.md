==========================================
So D is just C++ with a Garbage Collector?
==========================================

There is sometimes a perception in Internet forums that D is a mere repackaging of C++. D would bring more or less the same feature set with a more friendly syntax, and not bring any new possibility.

The goal of this article is to provide counterpoints to this belief. D does allows some design that the community regards as new, alongside with the expected [incremental improvements](#How-does-D-improve-on-C++17?).

Here is an edited list of things that D can do, and C++ can't.


## Static introspection

Can this module be `import`ed?
Is this method `const`?
What is the list of all child classes of the given `class`?

Branded under the moniker _Design by Introspection_, static introspection applied to APIs enables code that abandon more type-safety in the quest for more genericity.

Examples:
- [Design By Introspection](#Design-by-Introspection)
- [Enumerate field at compile-time](#Enumerate-fields-with-__traits(allMembers)-and-static-foreach)


## Full-on CTFE

Compile-Time Function Evaluation, patiently evolved from a "glorified constant folder", is ubiquitous in D. Endlessly applicable, it also requires very few explanations: just add `enum` and you get it.
Regular looking code, evaluated at compile-time, with only a few limitations: what's not to love?

Examples:
- [Pre-computed tables computed at compile-time](#Precomputed-tables-at-compile-time-through-CTFE)


## Generative abilities

CTFE and deep type introspection would be nothing without the ability to generate code at compile-time easily.
String mixins, templates, mixin templates, "static" `foreach` are different way in which this can be achieved.

Examples:
- [String interpolation as a library](#String-interpolation-as-a-library)
- [Using external files as data](#Embed-a-dynamic-library-in-an-executable)

The combination of Static Introspection, generative features and CTFE forms the trinity that powers D's unique selling point. It's the fire behind the proverbial smoke.

