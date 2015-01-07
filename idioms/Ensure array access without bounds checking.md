===========================================
Ensure array access without bounds checking
===========================================

Slice indexing can perform bounds check depending on `-boundscheck` and `@safe`.

But pointer indexing won't ever check bounds.

    int[] myArray;
    myArray.ptr[index] = 4; // no bounds check, guaranteed


