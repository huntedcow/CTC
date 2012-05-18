CocoaTypeChecker
================

Runtime type checking for Cocoa containers.

Motivation
----------
Validating data sent over the network can be complex and time consuming.  CTC aims to simplify at least part of the process – type checking the objects you receive.

Current State
-------------
Currently CTC is made up of a few simple categories on Cocoa's container classes that allow you to check the types of all the objects within those containers.  Future versions will allow you to specify type specifications for entire trees of objects, and quickly type check everything within.

Please bear in mind that CTC is in a very early state, it's API is subject to change!

