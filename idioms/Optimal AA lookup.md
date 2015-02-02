=================
Optimal AA lookup
=================

When used on an Associative Array, the `in` operator returns a pointer to the searched element, or `null` if not found.

Instead of:

    key in aa ? aa[key] : ValueType.init;

which perform 2 AA lookups prefer:

    auto ptr = key in aa;
    ptr ? *ptr : ValueType.init;


The `.get` builtin property can also be used. It provides a default value when the key doesn't exist.

    aa.get(key, defaultValue);
