
General code structure
----------------------

<a name="optionalsemicolons"> </a>
### Optional semicolons 

Semicolons serve the same general purpose in Eero as they do in C/Objective-C. That is, they terminate and separate statements and declarations. However, with rare exception, they're optional in Eero. As in Python and Ruby, statements generally end with newlines, but the parser will also handle unambiguous statement continuations, such as dangling commas or arithmetic operators, onto subsequent lines. The parser handles other situations as well.

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="offsiderule"> </a>
### Off-side rule (indentation indicates block scope) 

Like Python (and various other languages), Eero adheres to the [off-side](http://en.wikipedia.org/wiki/Off-side_rule) rule for block scope. The compiler doesn't dictate the level of indentation, but it must remain consistent for consecutive lines in a particular block. This mechanism completely supplants the use of curly braces as block delimiters.

_Motivation_: readability, safety, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself), [WYSIWYG](http://en.wikipedia.org/wiki/Wysiwyg)

<a name="optionalparens"> </a>
### Optional parentheses around conditions 

Eero doesn't require the first level of parentheses around conditional expressions. This applies to _if_, _for_, _while_, _switch_, _catch_, etc..

<div class="highlight">
<pre><span class="k">if</span> <span class="n">counter</span> <span class="n">&gt;</span><span class="p">=</span> 0
   <span class="n">counter</span><span class="n">++</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="nomessagebrackets"> </a>
### Message passing without square brackets 

In Eero, you send messages to objects or classes without using square brackets. As a result, you separate parameters using commas. Furthermore, you can group message-passing expressions with parentheses, just as you can any other expressions.

<div class="highlight">
<pre><span class="kt">id</span> <span class="n">myarray</span> <span class="o">=</span> <span class="n">NSMutableArray</span> <span class="n">new</span>
<span class="n">myarray</span> <span class="nl">addObject:</span> <span class="n">myobject</span>
<span class="n">myarray</span> <span class="nl">replaceObjectAtIndex:</span> <span class="mi">0</span><span class="p">,</span> <span class="nl">withObject:</span> <span class="p">(</span><span class="n">myobject</span> <span class="n">description</span><span class="p">)</span>
</pre>
</div>

_Motivation_: readability

Keywords
--------

<a name="noatkeywords"> </a>
### Objective-C keywords without '@' 

Eero recognizes Objective-C keywords as regular language keywords. They don't need to be preceded by an '@' character.

<div class="highlight">
<pre><span class="k">interface</span> MyClass : <span class="kt">NSObject</span>
<span class="k">end</span></pre>
</div>
_Motivation_: readability

<a name="booleannames"> </a>
### Logical and bitwise operators _and_, _or_, _not_, etc. 

Eero recognizes the alternative logical and bitwise operators introduced in C++. (They're also available to standard C through the inclusion of header iso646.h, introduced to the C90 standard in 1995.)

<div class="highlight">
<pre><span class="k">if</span> <span class="n">ready</span> <span class="k">and</span> <span class="n">initialized</span>
   <span class="n">counter</span><span class="o">++</span>
</pre>
</div>

_Motivation_: readability

<a name="nogoto"> </a>
### The goto statement is illegal 

In Eero, _goto_ is still a recognized keyword but its use is forbidden and will result in a compilation error.

_Motivation_: safety

Namespaces
----------

Neither C nor Objective-C supports namespaces, relying on unique prefixes to prevent symbol collisions. Eero provides a backward-compatible way of obtaining some of the readability benefits of namespaces.

<a name="nsprefix"> </a>
### Built-in symbol search on names with the "NS" prefix

When looking to resolve symbol names, the Eero compiler first checks the name as-is, and if not found, tries again with the "NS" prefix. This means you can use the types, functions, non-macro constants, and so on found throughout the Foundation and Cocoa frameworks without "NS". For example, anywhere a class name is used, you can use "String" instead of "NSString".

<div class="highlight">
<pre><span class="kt">id</span> <span class="n">mystring</span> <span class="o">=</span> <span class="kt">String</span> <span class="nl">stringWithUTF8String:</span> <span class="s">"Hello, World"</span>
</pre>
</div>

_Motivation_: readability

<a name="userprefixes"> </a>
### User-defined prefix namespaces

In addition to the built-in "NS" prefix, users can declare their own prefixes to be applied to any scope (file, method, function, etc.). This is done through the *using* *prefix* declaration. For example, to find symbol names without providing an explicit "AB" prefix (from the AddressBook framework), use the following:

<div class="highlight">
<pre><span class="k">using</span> <span class="k">prefix</span> <span class="n">AB</span>
<span class="p">...</span>
<span class="kt">id</span> <span class="n">theAddressBook</span> <span class="o">=</span> <span class="n">AddressBook</span> <span class="n">sharedAddressBook</span> 
</pre>
</div>

_Motivation_: readability

Variables and literals
----------------------

<a name="objectsarepointers"> </a>
### Object declarations are assumed to be pointers

Since Objective-C objects are always references (pointers to objects), it is never valid to define object variables as anything but pointers. Instead of issuing an error, Eero implicitly treats all declarations of a class type as a pointer to that type. This means that no associated asterisk is needed.

<div class="highlight">
<pre><span class="kt">NSString</span> <span class="n">mystring</span> <span class="o">=</span> <span class="n">myobject</span> <span class="n">description</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="typeinference"> </a>
### Local type inference

You can declare and initialize local variables using the Eero-specific "**:=**" operator. For example, the following code declares an integer initialized with a value:

<div class="highlight">
<pre><span class="n">i</span> <span class="o">:=</span> <span class="mi">100</span>
</pre>
</div>

The _const_ specifier also works with this operator:

<div class="highlight">
<pre><span class="kt">const</span> <span class="n">name</span> <span class="o">:=</span> <span class="s">"Danielle"</span>
</pre>
</div>

You can still declare variables in the standard C/Objective-C way, using explicit types:

<div class="highlight">
<pre><span class="kt">int</span> <span class="n">i</span> <span class="o">=</span> <span class="mi">100</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself), safety (reduces temptation to use types like _id_)

<a name="noshadowing"> </a>
### No variable shadowing

Partly due to the type inference feature, and partly as a general code safety and readability improvement, the compiler does not permit variable shadowing. Attempting to re-declare a variable of the same name in an inner scope will result in a compilation error.

<div class="highlight">
<pre><span class="n">counter</span> <span class="o">:=</span> <span class="mi">0</span>
<span class="k">if</span> <span class="n">isReady</span>
   <span class="n">counter</span> <span class="o">:=</span> <span class="mi">0</span> <span class="c1">// compiler error</span>
</pre>
</div>

_Motivation_: safety, readability

<a name="stringliterals"> </a>
### NSString literals using single quotes

In Eero, you enclose Objective-C/Foundation string literals in single quotes, with no preceding '@' symbol:

<div class="highlight">
<pre><span class="n">mynsstring</span> <span class="p">:=</span> <span class="s">'Hello, world'</span>
</pre>
</div>

_Motivation_: readability

<a name="noatliterals"> </a>
### No '@' needed for array and dictionary literals

As in Objective-C, you can express array and dictionary literals with square and curly brackets, respectively. However, no '@' symbol is needed:

<div class="highlight">
<pre><span class="n">myarray</span> <span class="p">:=</span> <span class="p">[</span><span class="s">'a'</span><span class="p">,</span> <span class="s">'b'</span><span class="p">,</span> <span class="s">'c'</span><span class="p">]</span>

<span class="n">mydict</span> <span class="p">:=</span> <span class="p">{</span> <span class="s">'a'</span> <span class="p">:</span> <span class="s">'A'</span><span class="p">,</span> <span class="s">'b'</span> <span class="p">:</span> <span class="s">'B'</span><span class="p">,</span> <span class="s">'c'</span><span class="p">,</span> <span class="s">'C'</span> <span class="p">}</span>
</pre>
</div>


_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="mutableliterals"> </a>
### Mutable array and dictionary literals

Non-empty array and dictionary literals are immutable. However, unlike Objective-C, empty literals are the mutable versions of their classes, allowing:

<div class="highlight">
<pre><span class="n">mydict</span> <span class="p">:</span> <span class="p">=</span> <span class="p">{}</span>
<span class="n">mydict</span><span class="p">[</span><span class="s">'a'</span><span class="p">]</span> <span class="p">=</span> <span class="s">'A'</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="inferrednils"> </a>
### Variable definitions using type inference and *nil* or *Nil* 

If used with a *nil* or *Nil*, inferred variable types are of type *id* or *Class*, respectively:

<div class="highlight">
<pre><span class="n">myobject</span> <span class="o">:=</span> <span class="nb">nil</span>  <span class="c1">// is of type id</span>
<span class="n">myclass</span> <span class="o">:=</span> <span class="nb">Nil</span>   <span class="c1">// is of type Class</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="selectorliterals"> </a>
### Selector and protocol literals

While you can still use the *selector* compiler directive, Eero recognizes selector literals enclosed in vertical bars:

<div class="highlight">
<pre><span class="n">myobject</span> <span class="nl">performSelector:</span> <span class="o">|</span><span class="nl">applicationReady:</span><span class="o">|</span><span class="p">,</span> <span class="nl">withObject:</span> <span class="nb">nil</span><span class="p">,</span> <span class="nl">afterDelay:</span> <span class="mi">0</span>
</pre>
</div>

Enclose protocol literals in angle brackets:

<div class="highlight">
<pre><span class="k">if</span> <span class="n">myobject</span> <span class="nl">conformsToProtocol:</span> <span class="o">&lt;</span><span class="n">Coding</span><span class="o">&gt;</span>
   <span class="p">...</span>
</pre>
</div>

_Motivation_: readability

<a name="rangeliterals"> </a>
### NSRange literals (and expressions) using '..' or '...'

You can create range literals with integer values (or variables) separated by an ellipsis, which expresses an (inclusive) sequence stored as an NSRange struct. For example:

<div class="highlight">
<pre><span class="n">myrange</span> <span class="o">:=</span> <span class="mi">0</span> <span class="p">..</span> <span class="mi">10</span>  <span class="c1">// the equivalent of NSMakeRange( 0, 11 ) or (NSRange){ 0, 11 }</span>
</pre>
</div>

Note that Eero interprets both two and three consecutive periods as an ellipsis.

_Motivation_: readability

<a name="rangeloops"> </a>
### NSRange variables and literals in *for* *in* loops

You can use variable or literal ranges directly in *for-in* loops:

<div class="highlight">
<pre><span class="k">for</span> <span class="kt">int</span> <span class="n">i</span> <span class="k">in</span> <span class="n">myrange</span>
   <span class="c1">// perform loop operations</span>

<span class="k">for</span> <span class="kt">int</span> <span class="n">i</span> <span class="k">in</span> <span class="mi">0</span> <span class="p">..</span> <span class="mi">10</span>
   <span class="c1">// perform loop operations</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="underscores"> </a>
### Underscores permitted in numeric literals

For improved readability, underscores can appear within numeric literals. The compiler ignores the underscores, which do not modify the value in any way. Underscores cannot be the first or last character of the literal. Some examples:

<div class="highlight">
<pre><span class="kt">const</span> TimeInMilliseconds := <span class="mi">30_000</span>  <span class="c1">// 30 seconds</span>
<span class="kt">const int</span> MinimumBalanceInCents = <span class="mi">100_00</span> <span class="c1">// 100 dollars</span>
<span class="kt">const</span> RGBASolidWhite := <span class="mi">0x_FF_FF_FF_FF</span>
<span class="kt">const long double</span> Pi = <span class="mi">3.141_592_653_589</span></pre>
</div>

_Motivation_: readability

<a name="strictenums"> </a>
### Stricter *enum* type checking

Variables of *enum* types have stronger type checking than in standard C/Objective-C. Without an explicit cast, they can only be assigned values defined for their specific *enum* type. Since the *enum* values carry type information, they can also be used with type inference.

<div class="highlight">
<pre><span class="k">enum</span> <span class="n">RGBColors</span> <span class="p">{</span> <span class="no">RED</span><span class="p">,</span> <span class="no">GREEN</span><span class="p">,</span> <span class="no">BLUE</span> <span class="p">}</span>
<span class="n">color</span> <span class="o">:=</span> <span class="no">RED</span> <span class="c1">// inferred to enum type RGBColors</span>

<span class="n">color</span> <span class="o">=</span> <span class="no">GREEN</span> <span class="c1">// valid</span>
<span class="n">color</span> <span class="o">=</span> <span class="mi">0</span> <span class="c1">// compiler error</span>

<span class="k">enum</span> <span class="n">CMYKColors</span> <span class="p">{</span> <span class="no">CYAN</span><span class="p">,</span> <span class="no">MAGENTA</span><span class="p">,</span> <span class="no">YELLOW</span><span class="p">,</span> <span class="no">BLACK</span> <span class="p">}</span>
<span class="n">color</span> <span class="o">=</span> <span class="no">MAGENTA</span> <span class="c1">// compiler error</span>
</pre>
</div>


Implicit conversion from an *enum* value to an integer type is still allowed, however:

<div class="highlight">
<pre><span class="kt">int</span> <span class="n">value</span> <span class="o">=</span> <span class="no">RED</span> <span class="c1">// valid</span>
</pre>
</div>

Classes
-------

<a name="noparamsmethods"> </a>
### Method parameter type names are not enclosed in parentheses

In Eero, you do not enclose method parameter types in parentheses. However, like their message-sending counterparts, you do separate parameters with commas.

<div class="highlight">
<pre> <span class="nl">initWithBytes:</span> <span class="kt">const</span> <span class="kt">void</span><span class="kt">*</span> <span class="n">bytes</span><span class="p">,</span>
        <span class="nl">length:</span> <span class="kt">UInteger</span> <span class="n">length</span><span class="p">,</span>
      <span class="nl">encoding:</span> <span class="kt">StringEncoding</span> <span class="n">encoding</span>
</pre>
</div>

_Motivation_: readability

<a name="methodvardefaults"> </a>
### Method parameters have default variable names

If omitted, Eero generates argument variable names derived from their selectors. They're determined by the following rules, listed by most to least commonly encountered:

* If the method or parameter name contains words separated by camel case, then the last word (scanning left to right), converted entirely to lowercase, is used. For example, method name "initWithString" results in variable name "string."

* The first camel-case word encountered that contains two consecutive uppercase characters (scanning left to right) is used, along with all subsequent words, and no character cases are modified. For example, method name "initWithUTF8String" results in variable name "UTF8String."

* If no uppercase characters are encountered, the entire method or parameter name is used. For example, parameter name "encoding" results in variable name "encoding."

* If the first character in the method or parameter name is uppercase, the entire name is used. For example, method name "CreateNewString" results in variable name "CreateNewString"

<div class="highlight">
<pre> <span class="nl">initWithBytes:</span> <span class="kt">const</span> <span class="kt">void</span><span class="kt">*</span><span class="p">,</span>
        <span class="nl">length:</span> <span class="kt">UInteger</span><span class="p">,</span>
      <span class="nl">encoding:</span> <span class="kt">StringEncoding</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="methodreturns"> </a>
### Method return type specified by trailing *return*, *void* by default if omitted

To specify a return type, use a comma followed by the *return* keyword and a type. Unlike Objective-C, if unspecified, there is no return value for the method. This does not affect Foundation, Cocoa, or any other imported legacy headers.

<div class="highlight">
<pre> <span class="nl">initWithBytes:</span> <span class="kt">const</span> <span class="kt">void</span><span class="kt">*</span><span class="p">,</span>
        <span class="nl">length:</span> <span class="kt">UInteger</span><span class="p">,</span>
      <span class="nl">encoding:</span> <span class="kt">StringEncoding</span><span class="p">,</span>
         <span class="k">return</span> <span class="kt">id</span>
</pre>
</div>

_Motivation_: readability, [WYSIWYG](http://en.wikipedia.org/wiki/Wysiwyg)

<a name="instancemethods"> </a>
### Methods are instance methods by default

Like standard Objective-C, whether a method is an instance or class method is determined by a preceding '-' or '+', respectively. However, the '-' is optional for Eero.

<div class="highlight">
<pre><span class="k">interface</span> <span class="n">MyStringClass</span> <span class="o">:</span> <span class="kt">Object</span>
   <span class="n">+</span> <span class="nl">stringWithUTF8String:</span> <span class="kt">const</span> <span class="kt">char</span><span class="kt">*</span><span class="p">,</span> <span class="k">return</span> <span class="kt">instancetype</span>
   <span class="nl">initWithCString:</span> <span class="kt">const</span> <span class="kt">char</span><span class="kt">*</span><span class="p">,</span> <span class="nl">encoding:</span> <span class="kt">StringEncoding</span><span class="p">,</span> <span class="k">return</span> <span class="kt">instancetype</span>
   <span class="nl">initWithString:</span> <span class="kt">String</span><span class="p">,</span> <span class="k">return</span> <span class="kt">instancetype</span>
<span class="k">end</span>
</pre>
</div>

_Motivation_: readability (via sane defaults)

<a name="optionalparams"> </a>
### Optional parameters and default arguments

Eero supports a shorthand notation for optional method parameters and default arguments. The Objective-C way of doing this -- defining a set of methods, some of which omit parameters -- is still possible, and can be mixed freely with this notation.

There are two distinct parts to the process: flagging the parameters in the interface/protocol as optional, and specifying default values in the implementation.

For the interface, optional parameters are enclosed in square brackets, following a common technical documentation convention:

<div class="highlight">
<pre><span class="k">interface</span> <span class="n">MyClass</span> <span class="o">:</span> <span class="kt">Object</span>
   <span class="n">openFile</span> <span class="kt">String</span><span class="o">,</span> <span class="p">[</span><span class="n">withPermissions</span><span class="o">:</span> <span class="kt">String</span><span class="p">]</span><span class="o">,</span> <span class="n">return</span> <span class="kt">FileHandle</span>
<span class="k">end</span>
</pre>
</div>

For the implementation, the default values of the optional parameters are assigned using an '=' (equal) after the type or variable name, followed by the default assignment expression:

<div class="highlight">
<pre><span class="k">implementation</span> <span class="n">MyClass</span>
   <span class="n">openFile</span><span class="p">:</span> <span class="kt">String</span><span class="p">,</span> <span class="n">withPermissions</span><span class="p">:</span> <span class="kt">String</span> <span class="o">=</span> <span class="s">'r'</span><span class="p">,</span> <span class="k">return</span> <span class="kt">FileHandle</span>
      <span class="n">handle</span> <span class="p">:</span><span class="o">=</span> <span class="nb">nil</span>
      <span class="k">if</span> <span class="n">permissions</span> <span class="o">==</span> <span class="s">'r'</span>
         <span class="n">handle</span> <span class="o">=</span> <span class="n">FileHandle</span> <span class="n">fileHandleForReadingAtPath</span><span class="p">:</span> <span class="n">file</span>
      <span class="k">else</span> <span class="k">if</span> <span class="n">permissions</span> <span class="o">==</span> <span class="s">'w'</span> <span class="k">or</span> <span class="n">permissions</span> <span class="o">==</span> <span class="s">'rw'</span>
         <span class="n">handle</span> <span class="o">=</span> <span class="n">FileHandle</span> <span class="n">fileHandleForUpdatingAtPath</span><span class="p">:</span> <span class="n">file</span>
      <span class="k">return</span> <span class="n">handle</span>
<span class="k">end</span>
</pre>
</div>

An added advantage is that the user of the interface should not generally know (or care about) what the default value is; it's an implementation detail.

Because of this separation of interface and implementation, and like properties' *synthesize*, this convenience notation is not required. The individual methods can be constructed manually, like so:

<div class="highlight">
<pre><span class="k">implementation</span> <span class="n">MyClass</span>
   <span class="nl">openFile:</span> <span class="kt">String</span><span class="p">,</span> <span class="nl">withPermissions:</span> <span class="kt">String</span><span class="p">,</span> <span class="k">return</span> <span class="kt">FileHandle</span>
      <span class="p">...</span>
   <span class="nl">openFile:</span> <span class="kt">String</span><span class="p">,</span> <span class="k">return</span> <span class="kt">FileHandle</span>
      <span class="p">...</span>
<span class="k">end</span>
</pre>
</div>

The same holds for interfaces with discrete method declarations and corresponding implementations using the assignment notation. Thus even standard Objective-C interfaces and protocols can benefit.

Optional parameters are restricted to the second and subsequent items. However, required and optional parameters may be alternated. (Thanks to named parameters, there are no C++-like restrictions in this regard.) For example:

<div class="highlight">
<pre><span class="k">interface</span> <span class="n">MyClass</span> <span class="o">:</span> <span class="kt">Object</span>
   <span class="nl">openFile:</span> <span class="kt">String</span><span class="p">,</span> <span class="p">[</span><span class="nl">withPermissions:</span> <span class="kt">String</span><span class="p">],</span> <span class="nl">seekToEnd:</span> <span class="kt">BOOL</span><span class="p">,</span> <span class="p">[</span><span class="nl">closeAfterReading:</span> <span class="kt">BOOL</span><span class="p">],</span> <span class="k">return</span> <span class="kt">FileHandle</span>
<span class="k">end</span>
</pre>
</div>

Like all other Eero features, this does not introduce any binary breaks. This is just syntactic sugar that generates simple boiler-plate methods "under the hood."

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="defaultreturns"> </a>
### Default return expression

You can specify a default return expression for a method definition by providing an '=' (equal) after the return type, followed by an expression:

<div class="highlight">
<pre><span class="n">openFile</span><span class="o">:</span> <span class="kt">String</span><span class="o">,</span> <span class="n">withPermissions</span><span class="o">:</span> <span class="kt">String</span><span class="o">,</span> <span class="k">return</span> <span class="kt">FileHandle</span> <span class="o">=</span> <span class="n">nil</span>
   <span class="k">if</span> <span class="n">permissions</span> <span class="o">==</span> <span class="s1">'r'</span>
      <span class="k">return</span> <span class="n">FileHandle</span> <span class="n">fileHandleForReadingAtPath</span><span class="o">:</span> <span class="n">file</span>
   <span class="k">else</span> <span class="k">if</span> <span class="n">permissions</span> <span class="o">==</span> <span class="s1">'w'</span> <span class="k">or</span> <span class="n">permissions</span> <span class="o">==</span> <span class="s1">'rw'</span>
      <span class="k">return</span> <span class="o">=</span> <span class="n">FileHandle</span> <span class="n">fileHandleForUpdatingAtPath</span><span class="o">:</span> <span class="n">file</span>
</pre>
</div>

If no *return* statement is encountered in the method body, the method will return the value of this expression. This also allows compact method definitions for getter-like or stubbed methods:

<div class="highlight">
<pre><span class="k">interface</span> <span class="n">MyClass </span><span class="p">:</span> <span class="kt">Object</span>
   <span class="n">model</span><span class="p">,</span> <span class="k">return</span> <span class="kt">String</span> <span class="o">=</span> <span class="s">'G35'</span>
   <span class="n">serialNumber</span><span class="p">,</span> <span class="k">return</span> <span class="kt">String</span> <span class="o">=</span> <span class="s">'X344434AABC'</span>
<span class="k">end</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="nocurlyvars"> </a>
### No curly braces needed around member-variable declarations

Member variables, while still requiring placement at the beginning of an interface or implementation, don't need to be surrounded by curly braces:

<div class="highlight">
<pre><span class="k">interface</span> <span class="n">MyClass</span> <span class="o">:</span> <span class="kt">Object</span>
   <span class="k">protected</span>
      <span class="kt">int</span> <span class="n">counter</span>
      <span class="kt">id</span> <span class="n">delegate</span>
   <span class="n">model</span><span class="p">,</span> <span class="k">return</span> <span class="kt">String</span>
   <span class="n">serialNumber</span><span class="p">,</span> <span class="k">return</span> <span class="kt">String</span>
<span class="k">end</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="groupproperties"> </a>
### Declarations of properties of the same type can be grouped together

You can use a single property specification with a group of declarations. The declarations must follow any member variables.

<div class="highlight">
<pre><span class="k">interface</span> <span class="n">MyClass</span> <span class="o">:</span> <span class="kt">Object</span>
   <span class="k">protected</span>
      <span class="kt">id</span> <span class="n">delegate</span>
   <span class="k">property</span> <span class="k">(</span><span class="k">assign</span><span class="k">)</span>
      <span class="kt">String</span> <span class="n">name</span>
      <span class="kt">String</span> <span class="n">desc</span>
   <span class="n">model</span><span class="p">,</span> <span class="k">return</span> <span class="kt">String</span>
   <span class="n">serialNumber</span><span class="p">,</span> <span class="k">return</span> <span class="kt">String</span>
<span class="k">end</span>
</pre>
</div>

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

Object operators
----------------

Eero supports a limited set of common operators for Objective-C objects. All operands involved must be objects. The operators are, in fact, aliases for certain methods. However, the operators follow the same precedence rules as their primitive-data-type counterparts.

<a name="equalityoperators"> </a>
### Built-in equality and inequality comparison operators

For all objects, the comparison operators '==' (equals) and '!=' (not equal) map to the *isEqual* method. The result is negated for '!='. This replaces the low-level address comparison used in standard Objective-C for two objects. This allows valid comparisons of the form:

<div class="highlight">
<pre><span class="n">mystring</span> <span class="p">:</span><span class="o">=</span> <span class="n">MutableString</span> <span class="n">new</span>
<span class="n">mystring</span> <span class="n">appendString</span><span class="p">:</span> <span class="s">'Hello, World'</span>

<span class="k">if</span> <span class="n">mystring</span> <span class="o">==</span> <span class="s">'Hello, World'</span>
   <span class="c1">// gets here, since above condition is true</span>
</pre>
</div>

You can still perform explicit address comparisons by casting both operands to *void** types.

_Motivation_: readability, [WYSIWYG](http://en.wikipedia.org/wiki/Wysiwyg)

<a name="stringplus"> </a>
### Built-in '+' (binary version) and '<<' string operators

When the '+' binary operator is used, *stringByAppendingString* will be sent to instances of classes or protocols that respond to it (mainly NSString and its subclasses):

<div class="highlight">
<pre><span class="n">helloString</span> <span class="p">:</span><span class="o">=</span> <span class="s">'Hello'</span>
<span class="n">worldString</span> <span class="p">:</span><span class="o">=</span> <span class="s">'World'</span>

<span class="n">helloWorldString</span> <span class="p">:</span><span class="o">=</span> <span class="n">helloString</span> <span class="o">+</span> <span class="s">', '</span> <span class="o">+</span> <span class="n">worldString</span>
</pre>
</div>

When the '<<' binary operator is used, *appendString* will be sent to instances of classes or protocols that respond to it (mainly NSMutableString):

<div class="highlight">
<pre><span class="n">mystring</span> <span class="p">:</span><span class="o">=</span> <span class="s">''</span>
<span class="n">mystring</span> <span class="o">&lt;&lt;</span> <span class="s">'Hello, World'</span>
</pre>
</div>

_Motivation_: readability

<a name="binaryoperators"> </a>
### Binary operators

The following chart shows the supported object binary operators and resulting methods. In the cases of '+' and '<<', defining these methods for a particular class overrides the built-in versions.

<table>
<tr><td><strong>Operator</strong></td><td><strong>Method name</strong></td><td><strong>Notes</strong></td></tr>
<tr><td class="centered-cell">+</td><td>plus</td><td>includes support for +=</td></tr>
<tr><td class="centered-cell">-</td><td>minus</td><td>includes support for -=</td></tr>	
<tr><td class="centered-cell">*</td><td>multipliedBy</td><td>includes support for *=</td></tr>	
<tr><td class="centered-cell">/</td><td>dividedBy</td><td>includes support for /=</td></tr>	
<tr><td class="centered-cell">&lt;</td><td>isLess</td><td></td></tr>	
<tr><td class="centered-cell">&gt;</td><td>isGreater</td><td></td></tr>	
<tr><td class="centered-cell">&lt;=</td><td>isGreater</td><td>result is !(left isGreater: right)</td></tr>	
<tr><td class="centered-cell">&gt;=</td><td>isLess</td><td>result is !(left isLess: right)</td></tr>	
</table>

_Motivation_: readability


<a name="subscripts"> </a>
### Array and dictionary subscript operators with integer and object indexes

Eero supports the same array and dictionary object subscript operators ('\[\]') found in Objective-C. For platforms that support them, these operators acts as aliases for methods *IndexedSubscript*, *KeyedSubscript*, etc.. However, on systems with older versions of the Foundation library that are missing this family of methods, Eero falls back to *objectAtIndex*, *objectForKey*, etc..

_Motivation_: readability, backward compatibility

<a name="rangesubscripts"> </a>
### Object subscript operators with NSRange indexes

Objects indexed using '\[NSRange\]' that are derived from classes or protocols that respond to method *substringWithRange* (mainly NSString and its subclasses) will be sent that message. This allows concise string slices:

<div class="highlight">
<pre><span class="n">mystring</span> <span class="p">:</span><span class="o">=</span> <span class="s">'Hello, World'</span>
<span class="n">worldString</span> <span class="p">:</span><span class="o">=</span> <span class="n">mystring</span><span class="p">[</span><span class="mi">7</span> <span class="o">..</span> <span class="mi">11</span><span class="p">]</span>
</pre>
</div>

All other object types indexed using '\[NSRange\]' will be sent *subarrayWithRange* (found in NSArray and its subclasses). This allows concise array slices:

<div class="highlight">
<pre><span class="n">myarray</span> <span class="p">:</span><span class="o">=</span> <span class="p">[</span><span class="s">'a'</span><span class="p">,</span> <span class="s">'b'</span><span class="p">,</span> <span class="s">'c'</span><span class="p">,</span> <span class="s">'d'</span><span class="p">,</span> <span class="s">'e'</span><span class="p">,</span> <span class="s">'f'</span><span class="p">]</span>
<span class="n">abcRange</span> <span class="p">:</span><span class="o">=</span> <span class="mi">0</span> <span class="o">..</span> <span class="mi">2</span>
<span class="n">abcSubarray</span> <span class="p">:</span><span class="o">=</span> <span class="n">myarray</span><span class="p">[</span><span class="n">abcRange</span><span class="p">]</span>
</pre>
</div>

_Motivation_: readability

Special object casts (boxing and unboxing)
------------------------------------------

**Note:** Although not directly related to these conversions, casting an object variable to a class (without the trailing "\*") simply casts the object to the target class type. This is in line with Eero's general class-name policy:

<div class="highlight">
<pre><span class="n">mystring</span> <span class="n">:=</span> <span class="p">(</span><span class="n">String</span><span class="p">)</span> <span class="n">someObject</span>  <span class="c1">// same as "(String*) someObject"</span>
</pre>
</div>

<a name="boxing"> </a>
### Converting primitive data types to objects (boxing)

"Casting" a primitive data type to an Objective-C class results in the creation of an object of that type (boxing), implicitly using the appropriate method to do so. For example:

<div class="highlight">
<pre><span class="kt">unsigned</span> <span class="kt">int</span> <span class="n">age</span> <span class="o">=</span> <span class="mi">25</span>
<span class="n">ageAsNumberObject</span> <span class="o">:=</span> <span class="p">(</span><span class="kt">Number</span><span class="p">)</span> <span class="n">age</span>  <span class="c1">// same as (Number numberWithUnsignedInt: age)</span>
<span class="n">array</span> <span class="o">:=</span> <span class="p">[</span> <span class="p">(</span><span class="kt">Number</span><span class="p">)</span> <span class="mf">1.0</span><span class="p">,</span> <span class="p">(</span><span class="kt">Number</span><span class="p">)</span> <span class="mf">2.0</span><span class="p">,</span> <span class="p">(</span><span class="kt">Number</span><span class="p">)</span> <span class="mf">3.0</span> <span class="p">]</span>  <span class="c1">// same as (Number numberWithDouble: x)</span>
</pre>
</div>

This works with any class that implements the appropriate *numberWith&lt;Type&gt;* class methods. 

C-style character strings are also supported, implicitly using class method *stringWithUTF8String*:

<div class="highlight">
<pre><span class="k">const</span> <span class="kt">char</span><span class="o">*</span> <span class="n">helloworld</span> <span class="o">=</span> <span class="s">"Hello, World"</span>
<span class="n">stringObject</span> <span class="o">:=</span> <span class="p">(</span><span class="kt">String</span><span class="p">)</span> <span class="n">helloworld</span>
<span class="n">mutableStringObject</span> <span class="o">:=</span> <span class="p">(</span><span class="kt">MutableString</span><span class="p">)</span> <span class="n">helloworld</span>
</pre>
</div>
There are no implicit conversions from primitive to object.

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

<a name="unboxing"> </a>
### Converting objects to primitive data types (unboxing)

"Casting" an Objective-C object to a primitive data type results in a value extraction (unboxing), implicitly using the appropriate method to do so:

<div class="highlight">
<pre><span class="n">age</span> <span class="o">:=</span> <span class="p">(</span><span class="kt">unsigned</span> <span class="kt">int</span><span class="p">)</span> <span class="n">ageAsNumberObject</span>
</pre>
</div>

Methods *intValue*, *unsignedIntValue*, *doubleValue*, etc. are used, as determined by the cast type. These messages are sent to objects of any type, so any class that supports these methods (not just *NSNumber* and its subclasses) can take advantage of them. For example, since *NSString* supports *floatValue*, this works:

<div class="highlight">
<pre><span class="n">pi</span> <span class="p">:</span><span class="o">=</span> <span class="p">(</span><span class="kt">float</span><span class="p">)</span> <span class="s">'3.14159'</span>
</pre>
</div>

Conversion of *NSString* objects to C strings (technically, UTF8 strings) is also supported, sending message *UTF8String* to the source object:

<div class="highlight">
<pre>helloworld := (<span class="kt">const char*</span>) <span class="s">'Hello World'</span>
<span class="kt">FILE*</span> file = fopen( (<span class="kt">const char*</span>)fileName, <span class="s">"r"</span> )
</pre>
</div>

(Please see [NSString Class Reference](http://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSString_Class/Reference/NSString.html) for details on memory management of the returned C string).

_Motivation_: readability, [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself)

Blocks enhancements
-------------------

Blocks are generally unchanged from Apple's C/Objective-C implementation. The primary difference in Eero is the use of indentation instead of braces to enclose them. A newline must immediately follow the parameter declaration list:

<div class="highlight">
<pre><span class="n">myblock</span> <span class="o">:=</span> <span class="o">^</span><span class="p">(</span><span class="kt">int</span> <span class="n">x</span><span class="p">,</span> <span class="kt">int</span> <span class="n">y</span><span class="p">)</span>
   <span class="k">if</span> <span class="n">x</span> <span class="o">&lt;</span> <span class="mi">0</span>
      <span class="n">printf</span><span class="p">(</span> <span class="s">"value was negative! (%d)</span><span class="se">\n</span><span class="s">"</span><span class="p">,</span> <span class="n">x</span> <span class="p">)</span>
      <span class="n">x</span> <span class="o">=</span> <span class="mi">0</span>
   <span class="k">return</span> <span class="n">x</span> <span class="o">+</span> <span class="n">y</span>
</pre>
</div>

<a name="compactblocks"> </a>
### Compact blocks

Eero supports a compact form for blocks that only requires a single expression or *return* statement. Within the parentheses following the '^' (caret), a vertical bar separates the parameters from the expression or *return* statement. Aside from a *return*, no statements are allowed, so condition statements and loops cannot be present.

<div class="highlight">
<pre><span class="n">xyblock</span> <span class="o">:=</span> <span class="o">^</span><span class="p">(</span><span class="kt">int</span> <span class="n">x</span><span class="p">,</span> <span class="kt">int</span> <span class="n">y</span> <span class="o">|</span> <span class="k">return</span> <span class="n">x</span> <span class="o">+</span> <span class="n">y</span><span class="p">)</span>
</pre>
</div>

<div class="highlight">
<pre><span class="n">vblock</span> <span class="o">:=</span> <span class="o">^</span><span class="p">(</span><span class="kt">int</span><span class="o">*</span> <span class="n">value</span> <span class="o">|</span> <span class="o">*</span><span class="n">value</span> <span class="o">=</span> <span class="mi">0</span><span class="p">)</span>
</pre>
</div>

<div class="highlight">
<pre><span class="n">descriptions</span> <span class="o">:=</span> <span class="n">mylist</span> <span class="nl">mapWith:</span> <span class="o">^</span><span class="p">(</span><span class="kt">id</span> <span class="n">element</span> <span class="o">|</span> <span class="k">return</span> <span class="n">element</span> <span class="n">description</span><span class="p">)</span>
</pre>
</div>

_Motivation_: readability

<a name="nestedfunctions"> </a>
### Nested functions (*const* blocks)

Eero supports constructions that look and act like nested functions but are semantically *const* blocks. These can be defined in methods, functions, or other blocks, and the normal block-closure rules apply. They can also be defined within *if*, *else*, *while*, *for*, etc. indented bodies. It is possible to call them directly, like a normal function, or pass them as block arguments.

<div class="highlight">
<pre><span class="k">implementation</span> <span class="kt">MyClass</span>
   processMutableStrings: <span class="kt">Array</span>
      <span class="kt">void</span> addPositionSuffix( <span class="kt">id</span> obj,  <span class="kt">UInteger</span> idx, <span class="kt">BOOL*</span> stop )
         <span class="k">if</span> obj == <span class="s">''</span>
            *stop = <span class="nb">YES</span>
         <span class="k">else</span>
            obj appendFormat <span class="s">'%u'</span>, idx
      strings enumerateObjectsUsingBlock: addPositionSuffix
      addPositionSuffix = <span class="nb">nil</span>  <span class="c1">// generates a compiler error: addPositionSuffix is a const</span>
<span class="k">end</span></pre>
</div>

_Motivation_: readability

The *switch* statement
----------------------

While being very similar in structure (and the same in performance) to the *switch* statement in the C language family, Eero makes various changes to the construct.

<a name="nofallthrough"> </a>
### No fall-through 

Eero *case* statements do **not** fall through, and thus do not require break statements. The ':' (colon) following the *case* value is optional, but the newline and indented code block is not. (The usual off-side rules apply.) Furthermore, these blocks automatically form declaration scopes, allowing declarations and definitions local to these scopes.

<div class="highlight">
<pre><span class="k">switch</span> <span class="nx">color</span>
   <span class="k">case</span> <span class="nx">kRed</span>
      <span class="nx">colorName</span> <span class="o">=</span> <span class="s1">'red'</span>
   <span class="k">case</span> <span class="nx">kGreen</span>
      <span class="nx">colorName</span> <span class="o">=</span> <span class="s1">'green'</span>
   <span class="k">case</span> <span class="nx">kBlue</span>
      <span class="nx">colorName</span> <span class="o">=</span> <span class="s1">'blue'</span>
   <span class="k">case</span> <span class="nx">kAlpha</span>
      <span class="p">;</span> <span class="c1">// do nothing</span>
   <span class="k">default</span> 
      <span class="nx">colorName</span> <span class="o">=</span> <span class="s1">'unknown'</span>
</pre>
</div>

The loss of convenience due to the absence of fall-through is compensated for by the safer mechanisms described in the next two sections.

_Motivation_: safety, readability

<a name="caselists"> </a>
### Comma-separated lists of cases <a name="commacases"> </a>

Cases can be grouped together as comma-separated lists of values:

<div class="highlight">
<pre><span class="k">switch</span> <span class="nx">color</span>
   <span class="k">case</span> <span class="nx">kRed</span><span class="p">,</span> <span class="nx">kGreen</span><span class="p">,</span> <span class="nx">kBlue</span>
      <span class="nx">colorIsValid</span> <span class="o">=</span> <span class="nb">YES</span>
   <span class="k">default</span>
      <span class="nx">colorIsValid</span> <span class="o">=</span> <span class="nb">NO</span>
</pre>
</div>

These can be freely mixed with single and ranged *case* values within the same *switch* statement.

_Motivation_: safety, readability

<a name="caseranges"> </a>
### Case-value ranges

You can specify a set of *case* values using an ellipsis between the first and last items in a consecutive range of values:

<div class="highlight">
<pre><span class="k">enum</span> <span class="n">Colors</span> <span class="p">{</span> <span class="n">RED</span><span class="p">,</span> <span class="n">ORANGE</span><span class="p">,</span> <span class="n">YELLOW</span><span class="p">,</span> <span class="n">GREEN</span><span class="p">,</span> <span class="n">BLUE</span><span class="p">,</span> <span class="n">INDIGO</span><span class="p">,</span> <span class="n">VIOLET</span> <span class="p">}</span>

<span class="k">switch</span> <span class="n">color</span>
   <span class="k">case</span> <span class="n">RED</span> <span class="p">..</span> <span class="n">VIOLET</span>
      <span class="n">colorIsValid</span> <span class="o">=</span> <span class="nb">YES</span>
   <span class="k">default</span>
      <span class="n">colorIsValid</span> <span class="o">=</span> <span class="nb">NO</span>
</pre>
</div>

These can be freely mixed with single and comma-separated list values within the same *switch* statement.

_Motivation_: safety, readability

<a name="reserved"> </a>
Reserved symbols for future features
------------------------------------

* The symbol *import* is an unused but reserved keyword, in anticipation of the *@import* feature, which will likely be introduced by Apple in the future.

* '=>' is an unused but reserved operator symbol.


