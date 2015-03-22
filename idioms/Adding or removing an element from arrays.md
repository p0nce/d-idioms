=========================================
Adding or removing an element from arrays
=========================================

Appending an element to a dynamic array:

```
T[] arr;
arr ~= value;                    // value is pushed at the back of the array
```

Removing an element from a dynamic array given an index:

```
import std.algorithm : remove;
T[] arr;
arr = arr.remove(index);         // index-th element is removed from array
```

Removing an element from a dynamic array given a value:
```
auto removeElement(R, N)(R haystack, N needle)
{
    import std.algorithm : countUntil, remove;
    auto index = _haystack.countUntil(needle);
    return (index != -1) ? haystack.remove(index) : haystack;
}
int[] arr = [1, 5, 10];
arr = arr.removeElement(5);
assert(arr == [1,10]);
```

Adding an element into an associate array:
```
aa[key] = value;                 // aa[key] is created if not already existing
```

Removing an element from an associate array given a key:
```
aa.remove(key);                  // there is a builtin property to do that
```
