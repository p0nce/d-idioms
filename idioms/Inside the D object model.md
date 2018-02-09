=========================
Inside the D Object Model
=========================

How are inheritance and multiple interfaces implemented?

This blog post by Mathis Beer explains the layout of "Single Inheritance Multiple Interfaces" objects, with graphics:
[https://feepingcreature.github.io/oop.html](https://feepingcreature.github.io/oop.html)


**TL;DR: For each interface implemented by a class instance, there is a hidden field. That field pointing to the corresponding v-table subset.** 
