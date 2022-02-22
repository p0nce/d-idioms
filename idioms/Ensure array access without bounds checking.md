Ensure array access without bounds checking
===========================================

Slice indexing will check bounds depending on `-boundscheck` and `@safe`.

But pointer indexing won't ever check bounds.

    int[] myArray;
    myArray.ptr[index] = 4; // no bounds check, guaranteed


