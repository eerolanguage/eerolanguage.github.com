**Table of contents**
---------------------

General code structure
----------------------

#### [Optional semicolons](#optionalsemicolons)

### [Off-side rule (indentation indicates block scope)](#offsiderule)

### [Optional parentheses around conditions](#optionalparens)

### [Message passing without square brackets](#nomessagebrackets)

Keywords
--------

### [Objective-C keywords without '@'](#noatkeywords)

### [Logical and bitwise operators _and_, _or_, _not_, etc.](#booleannames)

### [The goto statement is illegal](#nogoto)

Namespaces
----------

### [Built-in symbol search on names with the "NS" prefix](#nsprefix)

### [User-defined prefix namespaces](#userprefixes)

Variables and literals
----------------------

### [Object declarations are assumed to be pointers](#objectsarepointers)

### [Local type inference](#typeinference)

### [No variable shadowing](#noshadowing)

### [NSString literals using single quotes](#stringliterals)

### [No '@' needed for array and dictionary literals](#noatliterals)

### [Mutable array and dictionary literals](#mutableliterals)

### [Variable definitions using type inference and *nil* or *Nil*](#inferrednils)

### [Selector and protocol literals](#selectorliterals)

### [NSRange literals (and expressions) using '..' or '...'](#rangeliterals)

### [NSRange variables and literals in *for* *in* loops](#rangeloops)

### [Underscores permitted in numeric literals](#underscores)

### [Stricter *enum* type checking](#strictenums)

Classes
-------

### [Default superclass is NSObject](#defaultsuperclass)

### [Method parameter type names are not enclosed in parentheses](#noparamsmethods)

### [Method parameters have default variable names](#methodvardefaults)

### [Method return type specified by trailing *return*, *void* by default if omitted](#methodreturns)

### [Methods are instance methods by default](#instancemethods)

### [Optional parameters and default arguments](#optionalparams)

### [Default return expression](#defaultreturns)

### [No curly braces needed around member-variable declarations](#nocurlyvars)

### [Declarations of properties of the same type can be grouped together](#groupproperties)

Object operators
----------------

### [Built-in equality and inequality comparison operators](#equalityoperators)

### [Built-in '+' (binary version) and '<<' string operators](#stringplus)

### [Binary operators (effectively, operator overloading)](#binaryoperators)

### [Array and dictionary subscript operators with integer and object indexes](#subscripts)

### [Object subscript operators with NSRange indexes](#rangesubscripts)

Special object casts (boxing and unboxing)
------------------------------------------

### [Converting primitive data types to objects (boxing)](#boxing)

### [Converting objects to primitive data types (unboxing)](#unboxing)

Blocks enhancements
-------------------

### [Compact blocks](#compactblocks)

### [Nested functions (*const* blocks)](#nestedfunctions)

The *switch* statement
----------------------

### [No fall-through](#nofallthrough)

### [Comma-separated lists of cases](#caselists)

### [Case-value ranges](#caseranges)

The preprocessor
------------------------------------

### [Direct *#import* of Eero and legacy (Objective-C and C) headers](#importsincludes)

### [C++ interoperability *#pragma*](#cpppragma)

Reserved symbols for future features
------------------------------------
### [import](#reserved)
### [=>](#reserved)

