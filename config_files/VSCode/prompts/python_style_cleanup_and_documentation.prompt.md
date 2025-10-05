---
mode: agent
---
# Task: Clean up the code to adhere to proper and consistent style guidelines. Add appropriate documentation and type hints. Do not change the logic of the code.

## Do: 
- place appropriate and consistent docstrings 
- put correct type hints where appropriate
- when putting type hints, follow the generic alias types (i.e. list, dict, tuple, set, frozenset) instead of the typing module types (i.e. List, Dict, Tuple, Set, FrozenSet), which is possible since python 3.9
- use descriptive names (e.g. for variables, functions, classes)
- use comments sparingly, only where an additional explanation is necessary
- apply these modifications only to the directly attached file(s)
- ensure the code is clean, readable, and maintainable
- Adhere to PEP8 > PEP257 > PEP484 > Google Python Style Guide conventions in that order of importance.

## Don't:
- be overly verbose
- Refactor or change logic/control flow, side effects, data structures, I/O, or external behavior.
- Change function signatures beyond adding type annotations.
- Introduce dependencies or modify configuration


## References:
<!-- Peps were obtained from https://github.com/python/peps -->
<!-- Google Python Style Guide was obtained from https://github.com/google/styleguide/blob/gh-pages/pyguide.md -->
### PEP8 - Style Guide for Python Code
```rst
PEP: 8
Title: Style Guide for Python Code
Author: Guido van Rossum <guido@python.org>,
        Barry Warsaw <barry@python.org>,
        Alyssa Coghlan <ncoghlan@gmail.com>
Status: Active
Type: Process
Created: 05-Jul-2001
Post-History: 05-Jul-2001, 01-Aug-2013


Introduction
============

This document gives coding conventions for the Python code comprising
the standard library in the main Python distribution.  Please see the
companion informational PEP describing :pep:`style guidelines for the C code
in the C implementation of Python <7>`.

This document and :pep:`257` (Docstring Conventions) were adapted from
Guido's original Python Style Guide essay, with some additions from
Barry's style guide [2]_.

This style guide evolves over time as additional conventions are
identified and past conventions are rendered obsolete by changes in
the language itself.

Many projects have their own coding style guidelines. In the event of any
conflicts, such project-specific guides take precedence for that project.


A Foolish Consistency is the Hobgoblin of Little Minds
======================================================

One of Guido's key insights is that code is read much more often than
it is written.  The guidelines provided here are intended to improve
the readability of code and make it consistent across the wide
spectrum of Python code.  As :pep:`20` says, "Readability counts".

A style guide is about consistency.  Consistency with this style guide
is important.  Consistency within a project is more important.
Consistency within one module or function is the most important.

However, know when to be inconsistent -- sometimes style guide
recommendations just aren't applicable.  When in doubt, use your best
judgment.  Look at other examples and decide what looks best.  And
don't hesitate to ask!

In particular: do not break backwards compatibility just to comply with
this PEP!

Some other good reasons to ignore a particular guideline:

1. When applying the guideline would make the code less readable, even
   for someone who is used to reading code that follows this PEP.

2. To be consistent with surrounding code that also breaks it (maybe
   for historic reasons) -- although this is also an opportunity to
   clean up someone else's mess (in true XP style).

3. Because the code in question predates the introduction of the
   guideline and there is no other reason to be modifying that code.

4. When the code needs to remain compatible with older versions of
   Python that don't support the feature recommended by the style guide.


Code Lay-out
============

Indentation
-----------

Use 4 spaces per indentation level.

Continuation lines should align wrapped elements either vertically
using Python's implicit line joining inside parentheses, brackets and
braces, or using a *hanging indent* [#fn-hi]_.  When using a hanging
indent the following should be considered; there should be no
arguments on the first line and further indentation should be used to
clearly distinguish itself as a continuation line:

.. code-block::
   :class: good

   # Correct:

   # Aligned with opening delimiter.
   foo = long_function_name(var_one, var_two,
                            var_three, var_four)

   # Add 4 spaces (an extra level of indentation) to distinguish arguments from the rest.
   def long_function_name(
           var_one, var_two, var_three,
           var_four):
       print(var_one)

   # Hanging indents should add a level.
   foo = long_function_name(
       var_one, var_two,
       var_three, var_four)

.. code-block::
   :class: bad

   # Wrong:

   # Arguments on first line forbidden when not using vertical alignment.
   foo = long_function_name(var_one, var_two,
       var_three, var_four)

   # Further indentation required as indentation is not distinguishable.
   def long_function_name(
       var_one, var_two, var_three,
       var_four):
       print(var_one)

The 4-space rule is optional for continuation lines.

Optional:

.. code-block::
   :class: good

   # Hanging indents *may* be indented to other than 4 spaces.
   foo = long_function_name(
     var_one, var_two,
     var_three, var_four)

.. _`multiline if-statements`:

When the conditional part of an ``if``-statement is long enough to require
that it be written across multiple lines, it's worth noting that the
combination of a two character keyword (i.e. ``if``), plus a single space,
plus an opening parenthesis creates a natural 4-space indent for the
subsequent lines of the multiline conditional.  This can produce a visual
conflict with the indented suite of code nested inside the ``if``-statement,
which would also naturally be indented to 4 spaces.  This PEP takes no
explicit position on how (or whether) to further visually distinguish such
conditional lines from the nested suite inside the ``if``-statement.
Acceptable options in this situation include, but are not limited to:

.. code-block::
   :class: good

   # No extra indentation.
   if (this_is_one_thing and
       that_is_another_thing):
       do_something()

   # Add a comment, which will provide some distinction in editors
   # supporting syntax highlighting.
   if (this_is_one_thing and
       that_is_another_thing):
       # Since both conditions are true, we can frobnicate.
       do_something()

   # Add some extra indentation on the conditional continuation line.
   if (this_is_one_thing
           and that_is_another_thing):
       do_something()

(Also see the discussion of whether to break before or after binary
operators below.)

The closing brace/bracket/parenthesis on multiline constructs may
either line up under the first non-whitespace character of the last
line of list, as in:

.. code-block::
   :class: good

   my_list = [
       1, 2, 3,
       4, 5, 6,
       ]
   result = some_function_that_takes_arguments(
       'a', 'b', 'c',
       'd', 'e', 'f',
       )

or it may be lined up under the first character of the line that
starts the multiline construct, as in:

.. code-block::
   :class: good

   my_list = [
       1, 2, 3,
       4, 5, 6,
   ]
   result = some_function_that_takes_arguments(
       'a', 'b', 'c',
       'd', 'e', 'f',
   )

Tabs or Spaces?
---------------

Spaces are the preferred indentation method.

Tabs should be used solely to remain consistent with code that is
already indented with tabs.

Python disallows mixing tabs and spaces for indentation.


Maximum Line Length
-------------------

Limit all lines to a maximum of 79 characters.

For flowing long blocks of text with fewer structural restrictions
(docstrings or comments), the line length should be limited to 72
characters.

Limiting the required editor window width makes it possible to have
several files open side by side, and works well when using code
review tools that present the two versions in adjacent columns.

The default wrapping in most tools disrupts the visual structure of the
code, making it more difficult to understand. The limits are chosen to
avoid wrapping in editors with the window width set to 80, even
if the tool places a marker glyph in the final column when wrapping
lines. Some web based tools may not offer dynamic line wrapping at all.

Some teams strongly prefer a longer line length.  For code maintained
exclusively or primarily by a team that can reach agreement on this
issue, it is okay to increase the line length limit up to 99 characters,
provided that comments and docstrings are still wrapped at 72
characters.

The Python standard library is conservative and requires limiting
lines to 79 characters (and docstrings/comments to 72).

The preferred way of wrapping long lines is by using Python's implied
line continuation inside parentheses, brackets and braces.  Long lines
can be broken over multiple lines by wrapping expressions in
parentheses. These should be used in preference to using a backslash
for line continuation.

Backslashes may still be appropriate at times.  For example, long,
multiple ``with``-statements could not use implicit continuation
before Python 3.10, so backslashes were acceptable for that case:

.. code-block::
   :class: maybe

   with open('/path/to/some/file/you/want/to/read') as file_1, \
        open('/path/to/some/file/being/written', 'w') as file_2:
       file_2.write(file_1.read())

(See the previous discussion on `multiline if-statements`_ for further
thoughts on the indentation of such multiline ``with``-statements.)

Another such case is with ``assert`` statements.

Make sure to indent the continued line appropriately.


.. _`pep8-operator-linebreak`:

Should a Line Break Before or After a Binary Operator?
------------------------------------------------------

For decades the recommended style was to break after binary operators.
But this can hurt readability in two ways: the operators tend to get
scattered across different columns on the screen, and each operator is
moved away from its operand and onto the previous line.  Here, the eye
has to do extra work to tell which items are added and which are
subtracted:

.. code-block::
   :class: bad

   # Wrong:
   # operators sit far away from their operands
   income = (gross_wages +
             taxable_interest +
             (dividends - qualified_dividends) -
             ira_deduction -
             student_loan_interest)

To solve this readability problem, mathematicians and their publishers
follow the opposite convention.  Donald Knuth explains the traditional
rule in his *Computers and Typesetting* series: "Although formulas
within a paragraph always break after binary operations and relations,
displayed formulas always break before binary operations" [3]_.

Following the tradition from mathematics usually results in more
readable code:

.. code-block::
   :class: good

   # Correct:
   # easy to match operators with operands
   income = (gross_wages
             + taxable_interest
             + (dividends - qualified_dividends)
             - ira_deduction
             - student_loan_interest)

In Python code, it is permissible to break before or after a binary
operator, as long as the convention is consistent locally.  For new
code Knuth's style is suggested.

Blank Lines
-----------

Surround top-level function and class definitions with two blank
lines.

Method definitions inside a class are surrounded by a single blank
line.

Extra blank lines may be used (sparingly) to separate groups of
related functions.  Blank lines may be omitted between a bunch of
related one-liners (e.g. a set of dummy implementations).

Use blank lines in functions, sparingly, to indicate logical sections.

Python accepts the control-L (i.e. ^L) form feed character as
whitespace; many tools treat these characters as page separators, so
you may use them to separate pages of related sections of your file.
Note, some editors and web-based code viewers may not recognize
control-L as a form feed and will show another glyph in its place.

Source File Encoding
--------------------

Code in the core Python distribution should always use UTF-8, and should not
have an encoding declaration.

In the standard library, non-UTF-8 encodings should be used only for
test purposes. Use non-ASCII characters sparingly, preferably only to
denote places and human names. If using non-ASCII characters as data,
avoid noisy Unicode characters like z̯̯͡a̧͎̺l̡͓̫g̹̲o̡̼̘ and byte order
marks.

All identifiers in the Python standard library MUST use ASCII-only
identifiers, and SHOULD use English words wherever feasible (in many
cases, abbreviations and technical terms are used which aren't
English).

Open source projects with a global audience are encouraged to adopt a
similar policy.

Imports
-------

- Imports should usually be on separate lines:

  .. code-block::
     :class: good

     # Correct:
     import os
     import sys

  .. code-block::
     :class: bad

     # Wrong:
     import sys, os


  It's okay to say this though:

  .. code-block::
     :class: good

     # Correct:
     from subprocess import Popen, PIPE

- Imports are always put at the top of the file, just after any module
  comments and docstrings, and before module globals and constants.

  Imports should be grouped in the following order:

  1. Standard library imports.
  2. Related third party imports.
  3. Local application/library specific imports.

  You should put a blank line between each group of imports.

- Absolute imports are recommended, as they are usually more readable
  and tend to be better behaved (or at least give better error
  messages) if the import system is incorrectly configured (such as
  when a directory inside a package ends up on ``sys.path``):

  .. code-block::
     :class: good

     import mypkg.sibling
     from mypkg import sibling
     from mypkg.sibling import example

  However, explicit relative imports are an acceptable alternative to
  absolute imports, especially when dealing with complex package layouts
  where using absolute imports would be unnecessarily verbose:

  .. code-block::
     :class: good

     from . import sibling
     from .sibling import example

  Standard library code should avoid complex package layouts and always
  use absolute imports.

- When importing a class from a class-containing module, it's usually
  okay to spell this:

  .. code-block::
     :class: good

     from myclass import MyClass
     from foo.bar.yourclass import YourClass

  If this spelling causes local name clashes, then spell them explicitly:

  .. code-block::
     :class: good

     import myclass
     import foo.bar.yourclass

  and use ``myclass.MyClass`` and ``foo.bar.yourclass.YourClass``.

- Wildcard imports (``from <module> import *``) should be avoided, as
  they make it unclear which names are present in the namespace,
  confusing both readers and many automated tools. There is one
  defensible use case for a wildcard import, which is to republish an
  internal interface as part of a public API (for example, overwriting
  a pure Python implementation of an interface with the definitions
  from an optional accelerator module and exactly which definitions
  will be overwritten isn't known in advance).

  When republishing names this way, the guidelines below regarding
  public and internal interfaces still apply.

Module Level Dunder Names
-------------------------

Module level "dunders" (i.e. names with two leading and two trailing
underscores) such as ``__all__``, ``__author__``, ``__version__``,
etc. should be placed after the module docstring but before any import
statements *except* ``from __future__`` imports.  Python mandates that
future-imports must appear in the module before any other code except
docstrings:

.. code-block::
   :class: good

   """This is the example module.

   This module does stuff.
   """

   from __future__ import barry_as_FLUFL

   __all__ = ['a', 'b', 'c']
   __version__ = '0.1'
   __author__ = 'Cardinal Biggles'

   import os
   import sys


String Quotes
=============

In Python, single-quoted strings and double-quoted strings are the
same.  This PEP does not make a recommendation for this.  Pick a rule
and stick to it.  When a string contains single or double quote
characters, however, use the other one to avoid backslashes in the
string. It improves readability.

For triple-quoted strings, always use double quote characters to be
consistent with the docstring convention in :pep:`257`.


Whitespace in Expressions and Statements
========================================

Pet Peeves
----------

Avoid extraneous whitespace in the following situations:

- Immediately inside parentheses, brackets or braces:

  .. code-block::
     :class: good

     # Correct:
     spam(ham[1], {eggs: 2})

  .. code-block::
     :class: bad

     # Wrong:
     spam( ham[ 1 ], { eggs: 2 } )

- Between a trailing comma and a following close parenthesis:

  .. code-block::
     :class: good

     # Correct:
     foo = (0,)

  .. code-block::
     :class: bad

     # Wrong:
     bar = (0, )

- Immediately before a comma, semicolon, or colon:

  .. code-block::
     :class: good

     # Correct:
     if x == 4: print(x, y); x, y = y, x


  .. code-block::
     :class: bad

     # Wrong:
     if x == 4 : print(x , y) ; x , y = y , x

- However, in a slice the colon acts like a binary operator, and
  should have equal amounts on either side (treating it as the
  operator with the lowest priority).  In an extended slice, both
  colons must have the same amount of spacing applied.  Exception:
  when a slice parameter is omitted, the space is omitted:

  .. code-block::
     :class: good

     # Correct:
     ham[1:9], ham[1:9:3], ham[:9:3], ham[1::3], ham[1:9:]
     ham[lower:upper], ham[lower:upper:], ham[lower::step]
     ham[lower+offset : upper+offset]
     ham[: upper_fn(x) : step_fn(x)], ham[:: step_fn(x)]
     ham[lower + offset : upper + offset]

  .. code-block::
     :class: bad

     # Wrong:
     ham[lower + offset:upper + offset]
     ham[1: 9], ham[1 :9], ham[1:9 :3]
     ham[lower : : step]
     ham[ : upper]

- Immediately before the open parenthesis that starts the argument
  list of a function call:

  .. code-block::
     :class: good

     # Correct:
     spam(1)

  .. code-block::
     :class: bad

     # Wrong:
     spam (1)

- Immediately before the open parenthesis that starts an indexing or
  slicing:

  .. code-block::
     :class: good

     # Correct:
     dct['key'] = lst[index]

  .. code-block::
     :class: bad

     # Wrong:
     dct ['key'] = lst [index]

- More than one space around an assignment (or other) operator to
  align it with another:

  .. code-block::
     :class: good

     # Correct:
     x = 1
     y = 2
     long_variable = 3

  .. code-block::
     :class: bad

     # Wrong:
     x             = 1
     y             = 2
     long_variable = 3

Other Recommendations
---------------------

- Avoid trailing whitespace anywhere.  Because it's usually invisible,
  it can be confusing: e.g. a backslash followed by a space and a
  newline does not count as a line continuation marker.  Some editors
  don't preserve it and many projects (like CPython itself) have
  pre-commit hooks that reject it.

- Always surround these binary operators with a single space on either
  side: assignment (``=``), augmented assignment (``+=``, ``-=``
  etc.), comparisons (``==``, ``<``, ``>``, ``!=``, ``<=``, ``>=``, ``in``,
  ``not in``, ``is``, ``is not``), Booleans (``and``, ``or``, ``not``).

- If operators with different priorities are used, consider adding
  whitespace around the operators with the lowest priority(ies). Use
  your own judgment; however, never use more than one space, and
  always have the same amount of whitespace on both sides of a binary
  operator:

  .. code-block::
     :class: good

     # Correct:
     i = i + 1
     submitted += 1
     x = x*2 - 1
     hypot2 = x*x + y*y
     c = (a+b) * (a-b)

  .. code-block::
     :class: bad

     # Wrong:
     i=i+1
     submitted +=1
     x = x * 2 - 1
     hypot2 = x * x + y * y
     c = (a + b) * (a - b)

- Function annotations should use the normal rules for colons and
  always have spaces around the ``->`` arrow if present.  (See
  `Function Annotations`_ below for more about function annotations.):

  .. code-block::
     :class: good

     # Correct:
     def munge(input: AnyStr): ...
     def munge() -> PosInt: ...

  .. code-block::
     :class: bad

     # Wrong:
     def munge(input:AnyStr): ...
     def munge()->PosInt: ...

- Don't use spaces around the ``=`` sign when used to indicate a
  keyword argument, or when used to indicate a default value for an
  *unannotated* function parameter:

  .. code-block::
     :class: good

     # Correct:
     def complex(real, imag=0.0):
         return magic(r=real, i=imag)

  .. code-block::
     :class: bad

     # Wrong:
     def complex(real, imag = 0.0):
         return magic(r = real, i = imag)


  When combining an argument annotation with a default value, however, do use
  spaces around the ``=`` sign:

  .. code-block::
     :class: good

     # Correct:
     def munge(sep: AnyStr = None): ...
     def munge(input: AnyStr, sep: AnyStr = None, limit=1000): ...

  .. code-block::
     :class: bad

     # Wrong:
     def munge(input: AnyStr=None): ...
     def munge(input: AnyStr, limit = 1000): ...

- Compound statements (multiple statements on the same line) are
  generally discouraged:

  .. code-block::
     :class: good

     # Correct:
     if foo == 'blah':
         do_blah_thing()
     do_one()
     do_two()
     do_three()

  Rather not:

  .. code-block::
     :class: bad

     # Wrong:
     if foo == 'blah': do_blah_thing()
     do_one(); do_two(); do_three()

- While sometimes it's okay to put an if/for/while with a small body
  on the same line, never do this for multi-clause statements.  Also
  avoid folding such long lines!

  Rather not:

  .. code-block::
     :class: bad

     # Wrong:
     if foo == 'blah': do_blah_thing()
     for x in lst: total += x
     while t < 10: t = delay()

  Definitely not:

  .. code-block::
     :class: bad

     # Wrong:
     if foo == 'blah': do_blah_thing()
     else: do_non_blah_thing()

     try: something()
     finally: cleanup()

     do_one(); do_two(); do_three(long, argument,
                                  list, like, this)

     if foo == 'blah': one(); two(); three()


When to Use Trailing Commas
===========================

Trailing commas are usually optional, except they are mandatory when
making a tuple of one element.  For clarity, it is recommended to
surround the latter in (technically redundant) parentheses:

.. code-block::
   :class: good

   # Correct:
   FILES = ('setup.cfg',)

.. code-block::
   :class: bad

   # Wrong:
   FILES = 'setup.cfg',

When trailing commas are redundant, they are often helpful when a
version control system is used, when a list of values, arguments or
imported items is expected to be extended over time.  The pattern is
to put each value (etc.) on a line by itself, always adding a trailing
comma, and add the close parenthesis/bracket/brace on the next line.
However it does not make sense to have a trailing comma on the same
line as the closing delimiter (except in the above case of singleton
tuples):

.. code-block::
   :class: good

   # Correct:
   FILES = [
       'setup.cfg',
       'tox.ini',
       ]
   initialize(FILES,
              error=True,
              )

.. code-block::
   :class: bad

   # Wrong:
   FILES = ['setup.cfg', 'tox.ini',]
   initialize(FILES, error=True,)


Comments
========

Comments that contradict the code are worse than no comments.  Always
make a priority of keeping the comments up-to-date when the code
changes!

Comments should be complete sentences.  The first word should be
capitalized, unless it is an identifier that begins with a lower case
letter (never alter the case of identifiers!).

Block comments generally consist of one or more paragraphs built out of
complete sentences, with each sentence ending in a period.

You should use one or two spaces after a sentence-ending period in
multi-sentence comments, except after the final sentence.

Ensure that your comments are clear and easily understandable to other
speakers of the language you are writing in.

Python coders from non-English speaking countries: please write your
comments in English, unless you are 120% sure that the code will never
be read by people who don't speak your language.

Block Comments
--------------

Block comments generally apply to some (or all) code that follows
them, and are indented to the same level as that code.  Each line of a
block comment starts with a ``#`` and a single space (unless it is
indented text inside the comment).

Paragraphs inside a block comment are separated by a line containing a
single ``#``.

Inline Comments
---------------

Use inline comments sparingly.

An inline comment is a comment on the same line as a statement.
Inline comments should be separated by at least two spaces from the
statement.  They should start with a # and a single space.

Inline comments are unnecessary and in fact distracting if they state
the obvious.  Don't do this:

.. code-block::
   :class: bad

   x = x + 1                 # Increment x

But sometimes, this is useful:

.. code-block::
   :class: good

   x = x + 1                 # Compensate for border

Documentation Strings
---------------------

Conventions for writing good documentation strings
(a.k.a. "docstrings") are immortalized in :pep:`257`.

- Write docstrings for all public modules, functions, classes, and
  methods.  Docstrings are not necessary for non-public methods, but
  you should have a comment that describes what the method does.  This
  comment should appear after the ``def`` line.

- :pep:`257` describes good docstring conventions.  Note that most
  importantly, the ``"""`` that ends a multiline docstring should be
  on a line by itself:

  .. code-block::
     :class: good


     """Return a foobang

     Optional plotz says to frobnicate the bizbaz first.
     """

- For one liner docstrings, please keep the closing ``"""`` on
  the same line:

  .. code-block::
     :class: good

     """Return an ex-parrot."""


Naming Conventions
==================

The naming conventions of Python's library are a bit of a mess, so
we'll never get this completely consistent -- nevertheless, here are
the currently recommended naming standards.  New modules and packages
(including third party frameworks) should be written to these
standards, but where an existing library has a different style,
internal consistency is preferred.

Overriding Principle
--------------------

Names that are visible to the user as public parts of the API should
follow conventions that reflect usage rather than implementation.

Descriptive: Naming Styles
--------------------------

There are a lot of different naming styles.  It helps to be able to
recognize what naming style is being used, independently from what
they are used for.

The following naming styles are commonly distinguished:

- ``b`` (single lowercase letter)
- ``B`` (single uppercase letter)
- ``lowercase``
- ``lower_case_with_underscores``
- ``UPPERCASE``
- ``UPPER_CASE_WITH_UNDERSCORES``
- ``CapitalizedWords`` (or CapWords, or CamelCase -- so named because
  of the bumpy look of its letters [4]_).  This is also sometimes known
  as StudlyCaps.

  Note: When using acronyms in CapWords, capitalize all the
  letters of the acronym.  Thus HTTPServerError is better than
  HttpServerError.
- ``mixedCase`` (differs from CapitalizedWords by initial lowercase
  character!)
- ``Capitalized_Words_With_Underscores`` (ugly!)

There's also the style of using a short unique prefix to group related
names together.  This is not used much in Python, but it is mentioned
for completeness.  For example, the ``os.stat()`` function returns a
tuple whose items traditionally have names like ``st_mode``,
``st_size``, ``st_mtime`` and so on.  (This is done to emphasize the
correspondence with the fields of the POSIX system call struct, which
helps programmers familiar with that.)

The X11 library uses a leading X for all its public functions.  In
Python, this style is generally deemed unnecessary because attribute
and method names are prefixed with an object, and function names are
prefixed with a module name.

In addition, the following special forms using leading or trailing
underscores are recognized (these can generally be combined with any
case convention):

- ``_single_leading_underscore``: weak "internal use" indicator.
  E.g. ``from M import *`` does not import objects whose names start
  with an underscore.

- ``single_trailing_underscore_``: used by convention to avoid
  conflicts with Python keyword, e.g. :

  .. code-block::
     :class: good

     tkinter.Toplevel(master, class_='ClassName')

- ``__double_leading_underscore``: when naming a class attribute,
  invokes name mangling (inside class FooBar, ``__boo`` becomes
  ``_FooBar__boo``; see below).

- ``__double_leading_and_trailing_underscore__``: "magic" objects or
  attributes that live in user-controlled namespaces.
  E.g. ``__init__``, ``__import__`` or ``__file__``.  Never invent
  such names; only use them as documented.

Prescriptive: Naming Conventions
--------------------------------

Names to Avoid
~~~~~~~~~~~~~~

Never use the characters 'l' (lowercase letter el), 'O' (uppercase
letter oh), or 'I' (uppercase letter eye) as single character variable
names.

In some fonts, these characters are indistinguishable from the
numerals one and zero.  When tempted to use 'l', use 'L' instead.

ASCII Compatibility
~~~~~~~~~~~~~~~~~~~

Identifiers used in the standard library must be ASCII compatible
as described in the
:pep:`policy section <3131#policy-specification>`
of :pep:`3131`.

Package and Module Names
~~~~~~~~~~~~~~~~~~~~~~~~

Modules should have short, all-lowercase names.  Underscores can be
used in the module name if it improves readability.  Python packages
should also have short, all-lowercase names, although the use of
underscores is discouraged.

When an extension module written in C or C++ has an accompanying
Python module that provides a higher level (e.g. more object oriented)
interface, the C/C++ module has a leading underscore
(e.g. ``_socket``).

Class Names
~~~~~~~~~~~

Class names should normally use the CapWords convention.

The naming convention for functions may be used instead in cases where
the interface is documented and used primarily as a callable.

Note that there is a separate convention for builtin names: most builtin
names are single words (or two words run together), with the CapWords
convention used only for exception names and builtin constants.

Type Variable Names
~~~~~~~~~~~~~~~~~~~

Names of type variables introduced in :pep:`484` should normally use CapWords
preferring short names: ``T``, ``AnyStr``, ``Num``. It is recommended to add
suffixes ``_co`` or ``_contra`` to the variables used to declare covariant
or contravariant behavior correspondingly:

.. code-block::
   :class: good

   from typing import TypeVar

   VT_co = TypeVar('VT_co', covariant=True)
   KT_contra = TypeVar('KT_contra', contravariant=True)

Exception Names
~~~~~~~~~~~~~~~

Because exceptions should be classes, the class naming convention
applies here.  However, you should use the suffix "Error" on your
exception names (if the exception actually is an error).

Global Variable Names
~~~~~~~~~~~~~~~~~~~~~

(Let's hope that these variables are meant for use inside one module
only.)  The conventions are about the same as those for functions.

Modules that are designed for use via ``from M import *`` should use
the ``__all__`` mechanism to prevent exporting globals, or use the
older convention of prefixing such globals with an underscore (which
you might want to do to indicate these globals are "module
non-public").

Function and Variable Names
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Function names should be lowercase, with words separated by
underscores as necessary to improve readability.

Variable names follow the same convention as function names.

mixedCase is allowed only in contexts where that's already the
prevailing style (e.g. threading.py), to retain backwards
compatibility.

Function and Method Arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Always use ``self`` for the first argument to instance methods.

Always use ``cls`` for the first argument to class methods.

If a function argument's name clashes with a reserved keyword, it is
generally better to append a single trailing underscore rather than
use an abbreviation or spelling corruption.  Thus ``class_`` is better
than ``clss``.  (Perhaps better is to avoid such clashes by using a
synonym.)

Method Names and Instance Variables
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the function naming rules: lowercase with words separated by
underscores as necessary to improve readability.

Use one leading underscore only for non-public methods and instance
variables.

To avoid name clashes with subclasses, use two leading underscores to
invoke Python's name mangling rules.

Python mangles these names with the class name: if class Foo has an
attribute named ``__a``, it cannot be accessed by ``Foo.__a``.  (An
insistent user could still gain access by calling ``Foo._Foo__a``.)
Generally, double leading underscores should be used only to avoid
name conflicts with attributes in classes designed to be subclassed.

Note: there is some controversy about the use of __names (see below).

Constants
~~~~~~~~~

Constants are usually defined on a module level and written in all
capital letters with underscores separating words.  Examples include
``MAX_OVERFLOW`` and ``TOTAL``.

Designing for Inheritance
~~~~~~~~~~~~~~~~~~~~~~~~~

Always decide whether a class's methods and instance variables
(collectively: "attributes") should be public or non-public.  If in
doubt, choose non-public; it's easier to make it public later than to
make a public attribute non-public.

Public attributes are those that you expect unrelated clients of your
class to use, with your commitment to avoid backwards incompatible
changes.  Non-public attributes are those that are not intended to be
used by third parties; you make no guarantees that non-public
attributes won't change or even be removed.

We don't use the term "private" here, since no attribute is really
private in Python (without a generally unnecessary amount of work).

Another category of attributes are those that are part of the
"subclass API" (often called "protected" in other languages).  Some
classes are designed to be inherited from, either to extend or modify
aspects of the class's behavior.  When designing such a class, take
care to make explicit decisions about which attributes are public,
which are part of the subclass API, and which are truly only to be
used by your base class.

With this in mind, here are the Pythonic guidelines:

- Public attributes should have no leading underscores.

- If your public attribute name collides with a reserved keyword,
  append a single trailing underscore to your attribute name.  This is
  preferable to an abbreviation or corrupted spelling.  (However,
  notwithstanding this rule, 'cls' is the preferred spelling for any
  variable or argument which is known to be a class, especially the
  first argument to a class method.)

  Note 1: See the argument name recommendation above for class methods.

- For simple public data attributes, it is best to expose just the
  attribute name, without complicated accessor/mutator methods.  Keep
  in mind that Python provides an easy path to future enhancement,
  should you find that a simple data attribute needs to grow
  functional behavior.  In that case, use properties to hide
  functional implementation behind simple data attribute access
  syntax.

  Note 1: Try to keep the functional behavior side-effect free,
  although side-effects such as caching are generally fine.

  Note 2: Avoid using properties for computationally expensive
  operations; the attribute notation makes the caller believe that
  access is (relatively) cheap.

- If your class is intended to be subclassed, and you have attributes
  that you do not want subclasses to use, consider naming them with
  double leading underscores and no trailing underscores.  This
  invokes Python's name mangling algorithm, where the name of the
  class is mangled into the attribute name.  This helps avoid
  attribute name collisions should subclasses inadvertently contain
  attributes with the same name.

  Note 1: Note that only the simple class name is used in the mangled
  name, so if a subclass chooses both the same class name and attribute
  name, you can still get name collisions.

  Note 2: Name mangling can make certain uses, such as debugging and
  ``__getattr__()``, less convenient.  However the name mangling
  algorithm is well documented and easy to perform manually.

  Note 3: Not everyone likes name mangling.  Try to balance the
  need to avoid accidental name clashes with potential use by
  advanced callers.

Public and Internal Interfaces
------------------------------

Any backwards compatibility guarantees apply only to public interfaces.
Accordingly, it is important that users be able to clearly distinguish
between public and internal interfaces.

Documented interfaces are considered public, unless the documentation
explicitly declares them to be provisional or internal interfaces exempt
from the usual backwards compatibility guarantees. All undocumented
interfaces should be assumed to be internal.

To better support introspection, modules should explicitly declare the
names in their public API using the ``__all__`` attribute. Setting
``__all__`` to an empty list indicates that the module has no public API.

Even with ``__all__`` set appropriately, internal interfaces (packages,
modules, classes, functions, attributes or other names) should still be
prefixed with a single leading underscore.

An interface is also considered internal if any containing namespace
(package, module or class) is considered internal.

Imported names should always be considered an implementation detail.
Other modules must not rely on indirect access to such imported names
unless they are an explicitly documented part of the containing module's
API, such as ``os.path`` or a package's ``__init__`` module that exposes
functionality from submodules.


Programming Recommendations
===========================

- Code should be written in a way that does not disadvantage other
  implementations of Python (PyPy, Jython, IronPython, Cython, Psyco,
  and such).

  For example, do not rely on CPython's efficient implementation of
  in-place string concatenation for statements in the form ``a += b``
  or ``a = a + b``.  This optimization is fragile even in CPython (it
  only works for some types) and isn't present at all in implementations
  that don't use refcounting.  In performance sensitive parts of the
  library, the ``''.join()`` form should be used instead.  This will
  ensure that concatenation occurs in linear time across various
  implementations.

- Comparisons to singletons like None should always be done with
  ``is`` or ``is not``, never the equality operators.

  Also, beware of writing ``if x`` when you really mean ``if x is not
  None`` -- e.g. when testing whether a variable or argument that
  defaults to None was set to some other value.  The other value might
  have a type (such as a container) that could be false in a boolean
  context!

- Use ``is not`` operator rather than ``not ... is``.  While both
  expressions are functionally identical, the former is more readable
  and preferred:

  .. code-block::
     :class: good

     # Correct:
     if foo is not None:

  .. code-block::
     :class: bad

     # Wrong:
     if not foo is None:

- When implementing ordering operations with rich comparisons, it is
  best to implement all six operations (``__eq__``, ``__ne__``,
  ``__lt__``, ``__le__``, ``__gt__``, ``__ge__``) rather than relying
  on other code to only exercise a particular comparison.

  To minimize the effort involved, the ``functools.total_ordering()``
  decorator provides a tool to generate missing comparison methods.

  :pep:`207` indicates that reflexivity rules *are* assumed by Python.
  Thus, the interpreter may swap ``y > x`` with ``x < y``, ``y >= x``
  with ``x <= y``, and may swap the arguments of ``x == y`` and ``x !=
  y``.  The ``sort()`` and ``min()`` operations are guaranteed to use
  the ``<`` operator and the ``max()`` function uses the ``>``
  operator.  However, it is best to implement all six operations so
  that confusion doesn't arise in other contexts.

- Always use a def statement instead of an assignment statement that binds
  a lambda expression directly to an identifier:

  .. code-block::
     :class: good

     # Correct:
     def f(x): return 2*x

  .. code-block::
     :class: bad

     # Wrong:
     f = lambda x: 2*x

  The first form means that the name of the resulting function object is
  specifically 'f' instead of the generic '<lambda>'. This is more
  useful for tracebacks and string representations in general. The use
  of the assignment statement eliminates the sole benefit a lambda
  expression can offer over an explicit def statement (i.e. that it can
  be embedded inside a larger expression)

- Derive exceptions from ``Exception`` rather than ``BaseException``.
  Direct inheritance from ``BaseException`` is reserved for exceptions
  where catching them is almost always the wrong thing to do.

  Design exception hierarchies based on the distinctions that code
  *catching* the exceptions is likely to need, rather than the locations
  where the exceptions are raised. Aim to answer the question
  "What went wrong?" programmatically, rather than only stating that
  "A problem occurred" (see :pep:`3151` for an example of this lesson being
  learned for the builtin exception hierarchy)

  Class naming conventions apply here, although you should add the
  suffix "Error" to your exception classes if the exception is an
  error.  Non-error exceptions that are used for non-local flow control
  or other forms of signaling need no special suffix.

- Use exception chaining appropriately. ``raise X from Y``
  should be used to indicate explicit replacement without losing the
  original traceback.

  When deliberately replacing an inner exception (using ``raise X from
  None``), ensure that relevant details are transferred to the new
  exception (such as preserving the attribute name when converting
  KeyError to AttributeError, or embedding the text of the original
  exception in the new exception message).

- When catching exceptions, mention specific exceptions whenever
  possible instead of using a bare ``except:`` clause:

  .. code-block::
     :class: good

     try:
         import platform_specific_module
     except ImportError:
         platform_specific_module = None

  A bare ``except:`` clause will catch SystemExit and
  KeyboardInterrupt exceptions, making it harder to interrupt a
  program with Control-C, and can disguise other problems.  If you
  want to catch all exceptions that signal program errors, use
  ``except Exception:`` (bare except is equivalent to ``except
  BaseException:``).

  A good rule of thumb is to limit use of bare 'except' clauses to two
  cases:

  1. If the exception handler will be printing out or logging the
     traceback; at least the user will be aware that an error has
     occurred.

  2. If the code needs to do some cleanup work, but then lets the
     exception propagate upwards with ``raise``.  ``try...finally``
     can be a better way to handle this case.

- When catching operating system errors, prefer the explicit exception
  hierarchy introduced in Python 3.3 over introspection of ``errno``
  values.

- Additionally, for all try/except clauses, limit the ``try`` clause
  to the absolute minimum amount of code necessary.  Again, this
  avoids masking bugs:

  .. code-block::
     :class: good

     # Correct:
     try:
         value = collection[key]
     except KeyError:
         return key_not_found(key)
     else:
         return handle_value(value)

  .. code-block::
     :class: bad

     # Wrong:
     try:
         # Too broad!
         return handle_value(collection[key])
     except KeyError:
         # Will also catch KeyError raised by handle_value()
         return key_not_found(key)

- When a resource is local to a particular section of code, use a
  ``with`` statement to ensure it is cleaned up promptly and reliably
  after use. A try/finally statement is also acceptable.

- Context managers should be invoked through separate functions or methods
  whenever they do something other than acquire and release resources:

  .. code-block::
     :class: good

     # Correct:
     with conn.begin_transaction():
         do_stuff_in_transaction(conn)

  .. code-block::
     :class: bad

     # Wrong:
     with conn:
         do_stuff_in_transaction(conn)

  The latter example doesn't provide any information to indicate that
  the ``__enter__`` and ``__exit__`` methods are doing something other
  than closing the connection after a transaction.  Being explicit is
  important in this case.

- Be consistent in return statements.  Either all return statements in
  a function should return an expression, or none of them should.  If
  any return statement returns an expression, any return statements
  where no value is returned should explicitly state this as ``return
  None``, and an explicit return statement should be present at the
  end of the function (if reachable):

  .. code-block::
     :class: good

     # Correct:

     def foo(x):
         if x >= 0:
             return math.sqrt(x)
         else:
             return None

     def bar(x):
         if x < 0:
             return None
         return math.sqrt(x)

  .. code-block::
     :class: bad

     # Wrong:

     def foo(x):
         if x >= 0:
             return math.sqrt(x)

     def bar(x):
         if x < 0:
             return
         return math.sqrt(x)

- Use ``''.startswith()`` and ``''.endswith()`` instead of string
  slicing to check for prefixes or suffixes.

  startswith() and endswith() are cleaner and less error prone:

  .. code-block::
     :class: good

     # Correct:
     if foo.startswith('bar'):

  .. code-block::
     :class: bad

     # Wrong:
     if foo[:3] == 'bar':

- Object type comparisons should always use isinstance() instead of
  comparing types directly:

  .. code-block::
     :class: good

     # Correct:
     if isinstance(obj, int):

  .. code-block::
     :class: bad

     # Wrong:
     if type(obj) is type(1):

- For sequences, (strings, lists, tuples), use the fact that empty
  sequences are false:

  .. code-block::
     :class: good

     # Correct:
     if not seq:
     if seq:

  .. code-block::
     :class: bad

     # Wrong:
     if len(seq):
     if not len(seq):

- Don't write string literals that rely on significant trailing
  whitespace.  Such trailing whitespace is visually indistinguishable
  and some editors (or more recently, reindent.py) will trim them.

- Don't compare boolean values to True or False using ``==``:

  .. code-block::
     :class: good

     # Correct:
     if greeting:

  .. code-block::
     :class: bad

     # Wrong:
     if greeting == True:

  Worse:

  .. code-block::
     :class: bad

     # Wrong:
     if greeting is True:

- Use of the flow control statements ``return``/``break``/``continue``
  within the finally suite of a ``try...finally``, where the flow control
  statement would jump outside the finally suite, is discouraged.  This
  is because such statements will implicitly cancel any active exception
  that is propagating through the finally suite:

  .. code-block::
     :class: bad

     # Wrong:
     def foo():
         try:
             1 / 0
         finally:
             return 42

Function Annotations
--------------------

With the acceptance of :pep:`484`, the style rules for function
annotations have changed.

- Function annotations should use :pep:`484` syntax (there are some
  formatting recommendations for annotations in the previous section).

- The experimentation with annotation styles that was recommended
  previously in this PEP is no longer encouraged.

- However, outside the stdlib, experiments within the rules of :pep:`484`
  are now encouraged.  For example, marking up a large third party
  library or application with :pep:`484` style type annotations,
  reviewing how easy it was to add those annotations, and observing
  whether their presence increases code understandability.

- The Python standard library should be conservative in adopting such
  annotations, but their use is allowed for new code and for big
  refactorings.

- For code that wants to make a different use of function annotations
  it is recommended to put a comment of the form:

  .. code-block::
     :class: good

     # type: ignore

  near the top of the file; this tells type checkers to ignore all
  annotations.  (More fine-grained ways of disabling complaints from
  type checkers can be found in :pep:`484`.)

- Like linters, type checkers are optional, separate tools.  Python
  interpreters by default should not issue any messages due to type
  checking and should not alter their behavior based on annotations.

- Users who don't want to use type checkers are free to ignore them.
  However, it is expected that users of third party library packages
  may want to run type checkers over those packages.  For this purpose
  :pep:`484` recommends the use of stub files: .pyi files that are read
  by the type checker in preference of the corresponding .py files.
  Stub files can be distributed with a library, or separately (with
  the library author's permission) through the typeshed repo [5]_.


Variable Annotations
--------------------

:pep:`526` introduced variable annotations. The style recommendations for them are
similar to those on function annotations described above:

- Annotations for module level variables, class and instance variables,
  and local variables should have a single space after the colon.

- There should be no space before the colon.

- If an assignment has a right hand side, then the equality sign should have
  exactly one space on both sides:

  .. code-block::
     :class: good

     # Correct:

     code: int

     class Point:
         coords: Tuple[int, int]
         label: str = '<unknown>'

  .. code-block::
     :class: bad

     # Wrong:

     code:int  # No space after colon
     code : int  # Space before colon

     class Test:
         result: int=0  # No spaces around equality sign

- Although the :pep:`526` is accepted for Python 3.6, the variable annotation
  syntax is the preferred syntax for stub files on all versions of Python
  (see :pep:`484` for details).

.. rubric:: Footnotes

.. [#fn-hi] *Hanging indentation* is a type-setting style where all
   the lines in a paragraph are indented except the first line.  In
   the context of Python, the term is used to describe a style where
   the opening parenthesis of a parenthesized statement is the last
   non-whitespace character of the line, with subsequent lines being
   indented until the closing parenthesis.


References
==========

.. [2] Barry's GNU Mailman style guide
       http://barry.warsaw.us/software/STYLEGUIDE.txt

.. [3] Donald Knuth's *The TeXBook*, pages 195 and 196.

.. [4] http://www.wikipedia.com/wiki/Camel_case

.. [5] Typeshed repo
   https://github.com/python/typeshed



Copyright
=========

This document has been placed in the public domain.
```

## PEP 257
```rst
PEP: 257
Title: Docstring Conventions
Author: David Goodger <goodger@python.org>,
        Guido van Rossum <guido@python.org>
Discussions-To: doc-sig@python.org
Status: Active
Type: Informational
Created: 29-May-2001
Post-History: 13-Jun-2001


Abstract
========

This PEP documents the semantics and conventions associated with
Python docstrings.


Rationale
=========

The aim of this PEP is to standardize the high-level structure of
docstrings: what they should contain, and how to say it (without
touching on any markup syntax within docstrings).  The PEP contains
conventions, not laws or syntax.

    "A universal convention supplies all of maintainability, clarity,
    consistency, and a foundation for good programming habits too.
    What it doesn't do is insist that you follow it against your will.
    That's Python!"

    -- Tim Peters on comp.lang.python, 2001-06-16

If you violate these conventions, the worst you'll get is some dirty
looks.  But some software (such as the Docutils_ docstring processing
system :pep:`256`, :pep:`258`) will be aware of the conventions, so following them
will get you the best results.


Specification
=============

What is a Docstring?
--------------------

A docstring is a string literal that occurs as the first statement in
a module, function, class, or method definition.  Such a docstring
becomes the ``__doc__`` special attribute of that object.

All modules should normally have docstrings, and all functions and
classes exported by a module should also have docstrings.  Public
methods (including the ``__init__`` constructor) should also have
docstrings.  A package may be documented in the module docstring of
the ``__init__.py`` file in the package directory.

String literals occurring elsewhere in Python code may also act as
documentation.  They are not recognized by the Python bytecode
compiler and are not accessible as runtime object attributes (i.e. not
assigned to ``__doc__``), but two types of extra docstrings may be
extracted by software tools:

1. String literals occurring immediately after a simple assignment at
   the top level of a module, class, or ``__init__`` method are called
   "attribute docstrings".

2. String literals occurring immediately after another docstring are
   called "additional docstrings".

Please see :pep:`258`, "Docutils Design Specification", for a
detailed description of attribute and additional docstrings.

For consistency, always use ``"""triple double quotes"""`` around
docstrings.  Use ``r"""raw triple double quotes"""`` if you use any
backslashes in your docstrings.

There are two forms of docstrings: one-liners and multi-line
docstrings.


One-line Docstrings
--------------------

One-liners are for really obvious cases.  They should really fit on
one line.  For example::

    def kos_root():
        """Return the pathname of the KOS root directory."""
        global _kos_root
        if _kos_root: return _kos_root
        ...

Notes:

- Triple quotes are used even though the string fits on one line.
  This makes it easy to later expand it.

- The closing quotes are on the same line as the opening quotes.  This
  looks better for one-liners.

- There's no blank line either before or after the docstring.

- The docstring is a phrase ending in a period.  It prescribes the
  function or method's effect as a command ("Do this", "Return that"),
  not as a description; e.g. don't write "Returns the pathname ...".

- The one-line docstring should NOT be a "signature" reiterating the
  function/method parameters (which can be obtained by introspection).
  Don't do::

      def function(a, b):
          """function(a, b) -> list"""

  This type of docstring is only appropriate for C functions (such as
  built-ins), where introspection is not possible.  However, the
  nature of the *return value* cannot be determined by introspection,
  so it should be mentioned.  The preferred form for such a docstring
  would be something like::

      def function(a, b):
          """Do X and return a list."""

  (Of course "Do X" should be replaced by a useful description!)


Multi-line Docstrings
----------------------

Multi-line docstrings consist of a summary line just like a one-line
docstring, followed by a blank line, followed by a more elaborate
description.  The summary line may be used by automatic indexing
tools; it is important that it fits on one line and is separated from
the rest of the docstring by a blank line.  The summary line may be on
the same line as the opening quotes or on the next line.  The entire
docstring is indented the same as the quotes at its first line (see
example below).

Insert a blank line after all docstrings (one-line or multi-line) that
document a class -- generally speaking, the class's methods are
separated from each other by a single blank line, and the docstring
needs to be offset from the first method by a blank line.

The docstring of a script (a stand-alone program) should be usable as
its "usage" message, printed when the script is invoked with incorrect
or missing arguments (or perhaps with a "-h" option, for "help").
Such a docstring should document the script's function and command
line syntax, environment variables, and files.  Usage messages can be
fairly elaborate (several screens full) and should be sufficient for a
new user to use the command properly, as well as a complete quick
reference to all options and arguments for the sophisticated user.

The docstring for a module should generally list the classes,
exceptions and functions (and any other objects) that are exported by
the module, with a one-line summary of each.  (These summaries
generally give less detail than the summary line in the object's
docstring.)  The docstring for a package (i.e., the docstring of the
package's ``__init__.py`` module) should also list the modules and
subpackages exported by the package.

The docstring for a function or method should summarize its behavior
and document its arguments, return value(s), side effects, exceptions
raised, and restrictions on when it can be called (all if applicable).
Optional arguments should be indicated.  It should be documented
whether keyword arguments are part of the interface.

The docstring for a class should summarize its behavior and list the
public methods and instance variables.  If the class is intended to be
subclassed, and has an additional interface for subclasses, this
interface should be listed separately (in the docstring).  The class
constructor should be documented in the docstring for its ``__init__``
method.  Individual methods should be documented by their own
docstring.

If a class subclasses another class and its behavior is mostly
inherited from that class, its docstring should mention this and
summarize the differences.  Use the verb "override" to indicate that a
subclass method replaces a superclass method and does not call the
superclass method; use the verb "extend" to indicate that a subclass
method calls the superclass method (in addition to its own behavior).

*Do not* use the Emacs convention of mentioning the arguments of
functions or methods in upper case in running text.  Python is case
sensitive and the argument names can be used for keyword arguments, so
the docstring should document the correct argument names.  It is best
to list each argument on a separate line.  For example::

    def complex(real=0.0, imag=0.0):
        """Form a complex number.

        Keyword arguments:
        real -- the real part (default 0.0)
        imag -- the imaginary part (default 0.0)
        """
        if imag == 0.0 and real == 0.0:
            return complex_zero
        ...

Unless the entire docstring fits on a line, place the closing quotes
on a line by themselves.  This way, Emacs' ``fill-paragraph`` command
can be used on it.


Handling Docstring Indentation
------------------------------

Docstring processing tools will strip a uniform amount of indentation
from the second and further lines of the docstring, equal to the
minimum indentation of all non-blank lines after the first line.  Any
indentation in the first line of the docstring (i.e., up to the first
newline) is insignificant and removed.  Relative indentation of later
lines in the docstring is retained.  Blank lines should be removed
from the beginning and end of the docstring.

Since code is much more precise than words, here is an implementation
of the algorithm::

    def trim(docstring):
        if not docstring:
            return ''
        # Convert tabs to spaces (following the normal Python rules)
        # and split into a list of lines:
        lines = docstring.expandtabs().splitlines()
        # Determine minimum indentation (first line doesn't count):
        indent = sys.maxsize
        for line in lines[1:]:
            stripped = line.lstrip()
            if stripped:
                indent = min(indent, len(line) - len(stripped))
        # Remove indentation (first line is special):
        trimmed = [lines[0].strip()]
        if indent < sys.maxsize:
            for line in lines[1:]:
                trimmed.append(line[indent:].rstrip())
        # Strip off trailing and leading blank lines:
        while trimmed and not trimmed[-1]:
            trimmed.pop()
        while trimmed and not trimmed[0]:
            trimmed.pop(0)
        # Return a single string:
        return '\n'.join(trimmed)

The docstring in this example contains two newline characters and is
therefore 3 lines long.  The first and last lines are blank::

    def foo():
        """
        This is the second line of the docstring.
        """

To illustrate::

    >>> print repr(foo.__doc__)
    '\n    This is the second line of the docstring.\n    '
    >>> foo.__doc__.splitlines()
    ['', '    This is the second line of the docstring.', '    ']
    >>> trim(foo.__doc__)
    'This is the second line of the docstring.'

Once trimmed, these docstrings are equivalent::

    def foo():
        """A multi-line
        docstring.
        """

    def bar():
        """
        A multi-line
        docstring.
        """


References and Footnotes
========================

.. _Docutils: https://docutils.sourceforge.io/

.. _Doc-SIG: https://www.python.org/community/sigs/current/doc-sig/


Copyright
=========

This document has been placed in the public domain.


Acknowledgements
================

The "Specification" text comes mostly verbatim from :pep:`8`
by Guido van Rossum.

This document borrows ideas from the archives of the Python Doc-SIG_.
Thanks to all members past and present.
```


## PEP 484
```rst
PEP: 484
Title: Type Hints
Author: Guido van Rossum <guido@python.org>, Jukka Lehtosalo <jukka.lehtosalo@iki.fi>, Łukasz Langa <lukasz@python.org>
BDFL-Delegate: Mark Shannon
Discussions-To: python-dev@python.org
Status: Final
Type: Standards Track
Topic: Typing
Created: 29-Sep-2014
Python-Version: 3.5
Post-History: 16-Jan-2015, 20-Mar-2015, 17-Apr-2015, 20-May-2015, 22-May-2015
Resolution: https://mail.python.org/pipermail/python-dev/2015-May/140104.html


Abstract
========

:pep:`3107` introduced syntax for function annotations, but the semantics
were deliberately left undefined.  There has now been enough 3rd party
usage for static type analysis that the community would benefit from
a standard vocabulary and baseline tools within the standard library.

This PEP introduces a provisional module to provide these standard
definitions and tools, along with some conventions for situations
where annotations are not available.

Note that this PEP still explicitly does NOT prevent other uses of
annotations, nor does it require (or forbid) any particular processing
of annotations, even when they conform to this specification.  It
simply enables better coordination, as :pep:`333` did for web frameworks.

For example, here is a simple function whose argument and return type
are declared in the annotations::

  def greeting(name: str) -> str:
      return 'Hello ' + name

While these annotations are available at runtime through the usual
``__annotations__`` attribute, *no type checking happens at runtime*.
Instead, the proposal assumes the existence of a separate off-line
type checker which users can run over their source code voluntarily.
Essentially, such a type checker acts as a very powerful linter.
(While it would of course be possible for individual users to employ
a similar checker at run time for Design By Contract enforcement or
JIT optimization, those tools are not yet as mature.)

The proposal is strongly inspired by `mypy <mypy_>`_.  For example, the
type "sequence of integers" can be written as ``Sequence[int]``.  The
square brackets mean that no new syntax needs to be added to the
language.  The example here uses a custom type ``Sequence``, imported
from a pure-Python module ``typing``.  The ``Sequence[int]`` notation
works at runtime by implementing ``__getitem__()`` in the metaclass
(but its significance is primarily to an offline type checker).

The type system supports unions, generic types, and a special type
named ``Any`` which is consistent with (i.e. assignable to and from) all
types.  This latter feature is taken from the idea of gradual typing.
Gradual typing and the full type system are explained in :pep:`483`.

Other approaches from which we have borrowed or to which ours can be
compared and contrasted are described in :pep:`482`.


Rationale and Goals
===================

:pep:`3107` added support for arbitrary annotations on parts of a
function definition.  Although no meaning was assigned to annotations
then, there has always been an `implicit goal to use them for type
hinting <gvr-artima_>`_, which is listed as the first possible use case
in said PEP.

This PEP aims to provide a standard syntax for type annotations,
opening up Python code to easier static analysis and refactoring,
potential runtime type checking, and (perhaps, in some contexts)
code generation utilizing type information.

Of these goals, static analysis is the most important.  This includes
support for off-line type checkers such as mypy, as well as providing
a standard notation that can be used by IDEs for code completion and
refactoring.

Non-goals
---------

While the proposed typing module will contain some building blocks for
runtime type checking -- in particular the ``get_type_hints()``
function -- third party packages would have to be developed to
implement specific runtime type checking functionality, for example
using decorators or metaclasses.  Using type hints for performance
optimizations is left as an exercise for the reader.

It should also be emphasized that **Python will remain a dynamically
typed language, and the authors have no desire to ever make type hints
mandatory, even by convention.**


The meaning of annotations
==========================

Any function without annotations should be treated as having the most
general type possible, or ignored, by any type checker.  Functions
with the ``@no_type_check`` decorator should be treated as having
no annotations.

It is recommended but not required that checked functions have
annotations for all arguments and the return type.  For a checked
function, the default annotation for arguments and for the return type
is ``Any``.  An exception is the first argument of instance and
class methods. If it is not annotated, then it is assumed to have the
type of the containing class for instance methods, and a type object
type corresponding to the containing class object for class methods.
For example, in class ``A`` the first argument of an instance method
has the implicit type ``A``. In a class method, the precise type of
the first argument cannot be represented using the available type
notation.

(Note that the return type of ``__init__`` ought to be annotated with
``-> None``.  The reason for this is subtle.  If ``__init__`` assumed
a return annotation of ``-> None``, would that mean that an
argument-less, un-annotated ``__init__`` method should still be
type-checked?  Rather than leaving this ambiguous or introducing an
exception to the exception, we simply say that ``__init__`` ought to
have a return annotation; the default behavior is thus the same as for
other methods.)

A type checker is expected to check the body of a checked function for
consistency with the given annotations.  The annotations may also be
used to check correctness of calls appearing in other checked functions.

Type checkers are expected to attempt to infer as much information as
necessary.  The minimum requirement is to handle the builtin
decorators ``@property``, ``@staticmethod`` and ``@classmethod``.


Type Definition Syntax
======================

The syntax leverages :pep:`3107`-style annotations with a number of
extensions described in sections below.  In its basic form, type
hinting is used by filling function annotation slots with classes::

  def greeting(name: str) -> str:
      return 'Hello ' + name

This states that the expected type of the ``name`` argument is
``str``.  Analogically, the expected return type is ``str``.

Expressions whose type is a subtype of a specific argument type are
also accepted for that argument.


Acceptable type hints
---------------------

Type hints may be built-in classes (including those defined in
standard library or third-party extension modules), abstract base
classes, types available in the ``types`` module, and user-defined
classes (including those defined in the standard library or
third-party modules).

While annotations are normally the best format for type hints,
there are times when it is more appropriate to represent them
by a special comment, or in a separately distributed stub
file.  (See below for examples.)

Annotations must be valid expressions that evaluate without raising
exceptions at the time the function is defined (but see below for
forward references).

Annotations should be kept simple or static analysis tools may not be
able to interpret the values. For example, dynamically computed types
are unlikely to be understood.  (This is an
intentionally somewhat vague requirement, specific inclusions and
exclusions may be added to future versions of this PEP as warranted by
the discussion.)

In addition to the above, the following special constructs defined
below may be used: ``None``, ``Any``, ``Union``, ``Tuple``,
``Callable``, all ABCs and stand-ins for concrete classes exported
from ``typing`` (e.g. ``Sequence`` and ``Dict``), type variables, and
type aliases.

All newly introduced names used to support features described in
following sections (such as ``Any`` and ``Union``) are available in
the ``typing`` module.


Using None
----------

When used in a type hint, the expression ``None`` is considered
equivalent to ``type(None)``.


Type aliases
------------

Type aliases are defined by simple variable assignments::

  Url = str

  def retry(url: Url, retry_count: int) -> None: ...

Note that we recommend capitalizing alias names, since they represent
user-defined types, which (like user-defined classes) are typically
spelled that way.

Type aliases may be as complex as type hints in annotations --
anything that is acceptable as a type hint is acceptable in a type
alias::

    from typing import TypeVar, Iterable, Tuple

    T = TypeVar('T', int, float, complex)
    Vector = Iterable[Tuple[T, T]]

    def inproduct(v: Vector[T]) -> T:
        return sum(x*y for x, y in v)
    def dilate(v: Vector[T], scale: T) -> Vector[T]:
        return ((x * scale, y * scale) for x, y in v)
    vec = []  # type: Vector[float]


This is equivalent to::

    from typing import TypeVar, Iterable, Tuple

    T = TypeVar('T', int, float, complex)

    def inproduct(v: Iterable[Tuple[T, T]]) -> T:
        return sum(x*y for x, y in v)
    def dilate(v: Iterable[Tuple[T, T]], scale: T) -> Iterable[Tuple[T, T]]:
        return ((x * scale, y * scale) for x, y in v)
    vec = []  # type: Iterable[Tuple[float, float]]


Callable
--------

Frameworks expecting callback functions of specific signatures might be
type hinted using ``Callable[[Arg1Type, Arg2Type], ReturnType]``.
Examples::

  from typing import Callable

  def feeder(get_next_item: Callable[[], str]) -> None:
      # Body

  def async_query(on_success: Callable[[int], None],
                  on_error: Callable[[int, Exception], None]) -> None:
      # Body

It is possible to declare the return type of a callable without
specifying the call signature by substituting a literal ellipsis
(three dots) for the list of arguments::

  def partial(func: Callable[..., str], *args) -> Callable[..., str]:
      # Body

Note that there are no square brackets around the ellipsis.  The
arguments of the callback are completely unconstrained in this case
(and keyword arguments are acceptable).

Since using callbacks with keyword arguments is not perceived as a
common use case, there is currently no support for specifying keyword
arguments with ``Callable``.  Similarly, there is no support for
specifying callback signatures with a variable number of arguments of a
specific type.

Because ``typing.Callable`` does double-duty as a replacement for
``collections.abc.Callable``, ``isinstance(x, typing.Callable)`` is
implemented by deferring to ``isinstance(x, collections.abc.Callable)``.
However, ``isinstance(x, typing.Callable[...])`` is not supported.


Generics
--------

Since type information about objects kept in containers cannot be
statically inferred in a generic way, abstract base classes have been
extended to support subscription to denote expected types for container
elements.  Example::

  from typing import Mapping, Set

  def notify_by_email(employees: Set[Employee], overrides: Mapping[str, str]) -> None: ...

Generics can be parameterized by using a new factory available in
``typing`` called ``TypeVar``.  Example::

  from typing import Sequence, TypeVar

  T = TypeVar('T')      # Declare type variable

  def first(l: Sequence[T]) -> T:   # Generic function
      return l[0]

In this case the contract is that the returned value is consistent with
the elements held by the collection.

A ``TypeVar()`` expression must always directly be assigned to a
variable (it should not be used as part of a larger expression).  The
argument to ``TypeVar()`` must be a string equal to the variable name
to which it is assigned.  Type variables must not be redefined.

``TypeVar`` supports constraining parametric types to a fixed set of possible
types (note: those types cannot be parameterized by type variables). For
example, we can define a type variable that ranges over just ``str`` and
``bytes``. By default, a type variable ranges over all possible types.
Example of constraining a type variable::

  from typing import TypeVar, Text

  AnyStr = TypeVar('AnyStr', Text, bytes)

  def concat(x: AnyStr, y: AnyStr) -> AnyStr:
      return x + y

The function ``concat`` can be called with either two ``str`` arguments
or two ``bytes`` arguments, but not with a mix of ``str`` and ``bytes``
arguments.

There should be at least two constraints, if any; specifying a single
constraint is disallowed.

Subtypes of types constrained by a type variable should be treated
as their respective explicitly listed base types in the context of the
type variable.  Consider this example::

  class MyStr(str): ...

  x = concat(MyStr('apple'), MyStr('pie'))

The call is valid but the type variable ``AnyStr`` will be set to
``str`` and not ``MyStr``. In effect, the inferred type of the return
value assigned to ``x`` will also be ``str``.

Additionally, ``Any`` is a valid value for every type variable.
Consider the following::

  def count_truthy(elements: List[Any]) -> int:
      return sum(1 for elem in elements if elem)

This is equivalent to omitting the generic notation and just saying
``elements: List``.


User-defined generic types
--------------------------

You can include a ``Generic`` base class to define a user-defined class
as generic.  Example::

  from typing import TypeVar, Generic
  from logging import Logger

  T = TypeVar('T')

  class LoggedVar(Generic[T]):
      def __init__(self, value: T, name: str, logger: Logger) -> None:
          self.name = name
          self.logger = logger
          self.value = value

      def set(self, new: T) -> None:
          self.log('Set ' + repr(self.value))
          self.value = new

      def get(self) -> T:
          self.log('Get ' + repr(self.value))
          return self.value

      def log(self, message: str) -> None:
          self.logger.info('{}: {}'.format(self.name, message))

``Generic[T]`` as a base class defines that the class ``LoggedVar``
takes a single type parameter ``T``. This also makes ``T`` valid as
a type within the class body.

The ``Generic`` base class uses a metaclass that defines ``__getitem__``
so that ``LoggedVar[t]`` is valid as a type::

  from typing import Iterable

  def zero_all_vars(vars: Iterable[LoggedVar[int]]) -> None:
      for var in vars:
          var.set(0)

A generic type can have any number of type variables, and type variables
may be constrained. This is valid::

  from typing import TypeVar, Generic
  ...

  T = TypeVar('T')
  S = TypeVar('S')

  class Pair(Generic[T, S]):
      ...

Each type variable argument to ``Generic`` must be distinct. This is
thus invalid::

  from typing import TypeVar, Generic
  ...

  T = TypeVar('T')

  class Pair(Generic[T, T]):   # INVALID
      ...

The ``Generic[T]`` base class is redundant in simple cases where you
subclass some other generic class and specify type variables for its
parameters::

  from typing import TypeVar, Iterator

  T = TypeVar('T')

  class MyIter(Iterator[T]):
      ...

That class definition is equivalent to::

  class MyIter(Iterator[T], Generic[T]):
      ...

You can use multiple inheritance with ``Generic``::

  from typing import TypeVar, Generic, Sized, Iterable, Container, Tuple

  T = TypeVar('T')

  class LinkedList(Sized, Generic[T]):
      ...

  K = TypeVar('K')
  V = TypeVar('V')

  class MyMapping(Iterable[Tuple[K, V]],
                  Container[Tuple[K, V]],
                  Generic[K, V]):
      ...

Subclassing a generic class without specifying type parameters assumes
``Any`` for each position.  In the following example, ``MyIterable``
is not generic but implicitly inherits from ``Iterable[Any]``::

  from typing import Iterable

  class MyIterable(Iterable):  # Same as Iterable[Any]
      ...

Generic metaclasses are not supported.


Scoping rules for type variables
--------------------------------

Type variables follow normal name resolution rules.
However, there are some special cases in the static typechecking context:

* A type variable used in a generic function could be inferred to represent
  different types in the same code block. Example::

    from typing import TypeVar, Generic

    T = TypeVar('T')

    def fun_1(x: T) -> T: ...  # T here
    def fun_2(x: T) -> T: ...  # and here could be different

    fun_1(1)                   # This is OK, T is inferred to be int
    fun_2('a')                 # This is also OK, now T is str

* A type variable used in a method of a generic class that coincides
  with one of the variables that parameterize this class is always bound
  to that variable. Example::

    from typing import TypeVar, Generic

    T = TypeVar('T')

    class MyClass(Generic[T]):
        def meth_1(self, x: T) -> T: ...  # T here
        def meth_2(self, x: T) -> T: ...  # and here are always the same

    a = MyClass()  # type: MyClass[int]
    a.meth_1(1)    # OK
    a.meth_2('a')  # This is an error!

* A type variable used in a method that does not match any of the variables
  that parameterize the class makes this method a generic function in that
  variable::

    T = TypeVar('T')
    S = TypeVar('S')
    class Foo(Generic[T]):
        def method(self, x: T, y: S) -> S:
            ...

    x = Foo()               # type: Foo[int]
    y = x.method(0, "abc")  # inferred type of y is str

* Unbound type variables should not appear in the bodies of generic functions,
  or in the class bodies apart from method definitions::

    T = TypeVar('T')
    S = TypeVar('S')

    def a_fun(x: T) -> None:
        # this is OK
        y = []  # type: List[T]
        # but below is an error!
        y = []  # type: List[S]

    class Bar(Generic[T]):
        # this is also an error
        an_attr = []  # type: List[S]

        def do_something(x: S) -> S:  # this is OK though
            ...

* A generic class definition that appears inside a generic function
  should not use type variables that parameterize the generic function::

    from typing import List

    def a_fun(x: T) -> None:

        # This is OK
        a_list = []  # type: List[T]
        ...

        # This is however illegal
        class MyGeneric(Generic[T]):
            ...

* A generic class nested in another generic class cannot use same type
  variables. The scope of the type variables of the outer class
  doesn't cover the inner one::

    T = TypeVar('T')
    S = TypeVar('S')

    class Outer(Generic[T]):
        class Bad(Iterable[T]):       # Error
            ...
        class AlsoBad:
            x = None  # type: List[T] # Also an error

        class Inner(Iterable[S]):     # OK
            ...
        attr = None  # type: Inner[T] # Also OK


Instantiating generic classes and type erasure
----------------------------------------------

User-defined generic classes can be instantiated. Suppose we write
a ``Node`` class inheriting from ``Generic[T]``::

  from typing import TypeVar, Generic

  T = TypeVar('T')

  class Node(Generic[T]):
      ...

To create ``Node`` instances you call ``Node()`` just as for a regular
class.  At runtime the type (class) of the instance will be ``Node``.
But what type does it have to the type checker?  The answer depends on
how much information is available in the call.  If the constructor
(``__init__`` or ``__new__``) uses ``T`` in its signature, and a
corresponding argument value is passed, the type of the corresponding
argument(s) is substituted.  Otherwise, ``Any`` is assumed.  Example::

  from typing import TypeVar, Generic

  T = TypeVar('T')

  class Node(Generic[T]):
      x = None  # type: T # Instance attribute (see below)
      def __init__(self, label: T = None) -> None:
          ...

  x = Node('')  # Inferred type is Node[str]
  y = Node(0)   # Inferred type is Node[int]
  z = Node()    # Inferred type is Node[Any]

In case the inferred type uses ``[Any]`` but the intended type is more
specific, you can use a type comment (see below) to force the type of
the variable, e.g.::

  # (continued from previous example)
  a = Node()  # type: Node[int]
  b = Node()  # type: Node[str]

Alternatively, you can instantiate a specific concrete type, e.g.::

  # (continued from previous example)
  p = Node[int]()
  q = Node[str]()
  r = Node[int]('')  # Error
  s = Node[str](0)   # Error

Note that the runtime type (class) of ``p`` and ``q`` is still just ``Node``
-- ``Node[int]`` and ``Node[str]`` are distinguishable class objects, but
the runtime class of the objects created by instantiating them doesn't
record the distinction. This behavior is called "type erasure"; it is
common practice in languages with generics (e.g. Java, TypeScript).

Using generic classes (parameterized or not) to access attributes will result
in type check failure. Outside the class definition body, a class attribute
cannot be assigned, and can only be looked up by accessing it through a
class instance that does not have an instance attribute with the same name::

  # (continued from previous example)
  Node[int].x = 1  # Error
  Node[int].x      # Error
  Node.x = 1       # Error
  Node.x           # Error
  type(p).x        # Error
  p.x              # Ok (evaluates to None)
  Node[int]().x    # Ok (evaluates to None)
  p.x = 1          # Ok, but assigning to instance attribute

Generic versions of abstract collections like ``Mapping`` or ``Sequence``
and generic versions of built-in classes -- ``List``, ``Dict``, ``Set``,
and ``FrozenSet`` -- cannot be instantiated. However, concrete user-defined
subclasses thereof and generic versions of concrete collections can be
instantiated::

  data = DefaultDict[int, bytes]()

Note that one should not confuse static types and runtime classes.
The type is still erased in this case and the above expression is
just a shorthand for::

  data = collections.defaultdict()  # type: DefaultDict[int, bytes]

It is not recommended to use the subscripted class (e.g. ``Node[int]``)
directly in an expression -- using a type alias (e.g. ``IntNode = Node[int]``)
instead is preferred. (First, creating the subscripted class,
e.g. ``Node[int]``, has a runtime cost. Second, using a type alias
is more readable.)


Arbitrary generic types as base classes
---------------------------------------

``Generic[T]`` is only valid as a base class -- it's not a proper type.
However, user-defined generic types such as ``LinkedList[T]`` from the
above example and built-in generic types and ABCs such as ``List[T]``
and ``Iterable[T]`` are valid both as types and as base classes. For
example, we can define a subclass of ``Dict`` that specializes type
arguments::

  from typing import Dict, List, Optional

  class Node:
      ...

  class SymbolTable(Dict[str, List[Node]]):
      def push(self, name: str, node: Node) -> None:
          self.setdefault(name, []).append(node)

      def pop(self, name: str) -> Node:
          return self[name].pop()

      def lookup(self, name: str) -> Optional[Node]:
          nodes = self.get(name)
          if nodes:
              return nodes[-1]
          return None

``SymbolTable`` is a subclass of ``dict`` and a subtype of ``Dict[str,
List[Node]]``.

If a generic base class has a type variable as a type argument, this
makes the defined class generic. For example, we can define a generic
``LinkedList`` class that is iterable and a container::

  from typing import TypeVar, Iterable, Container

  T = TypeVar('T')

  class LinkedList(Iterable[T], Container[T]):
      ...

Now ``LinkedList[int]`` is a valid type. Note that we can use ``T``
multiple times in the base class list, as long as we don't use the
same type variable ``T`` multiple times within ``Generic[...]``.

Also consider the following example::

  from typing import TypeVar, Mapping

  T = TypeVar('T')

  class MyDict(Mapping[str, T]):
      ...

In this case MyDict has a single parameter, T.


Abstract generic types
----------------------

The metaclass used by ``Generic`` is a subclass of ``abc.ABCMeta``.
A generic class can be an ABC by including abstract methods
or properties, and generic classes can also have ABCs as base
classes without a metaclass conflict.


Type variables with an upper bound
----------------------------------

A type variable may specify an upper bound using ``bound=<type>`` (note:
<type> itself cannot be parameterized by type variables). This means that an
actual type substituted (explicitly or implicitly) for the type variable must
be a subtype of the boundary type. Example::

  from typing import TypeVar, Sized

  ST = TypeVar('ST', bound=Sized)

  def longer(x: ST, y: ST) -> ST:
      if len(x) > len(y):
          return x
      else:
          return y

  longer([1], [1, 2])  # ok, return type List[int]
  longer({1}, {1, 2})  # ok, return type Set[int]
  longer([1], {1, 2})  # ok, return type Collection[int]

An upper bound cannot be combined with type constraints (as in used
``AnyStr``, see the example earlier); type constraints cause the
inferred type to be _exactly_ one of the constraint types, while an
upper bound just requires that the actual type is a subtype of the
boundary type.


Covariance and contravariance
-----------------------------

Consider a class ``Employee`` with a subclass ``Manager``.  Now
suppose we have a function with an argument annotated with
``List[Employee]``.  Should we be allowed to call this function with a
variable of type ``List[Manager]`` as its argument?  Many people would
answer "yes, of course" without even considering the consequences.
But unless we know more about the function, a type checker should
reject such a call: the function might append an ``Employee`` instance
to the list, which would violate the variable's type in the caller.

It turns out such an argument acts *contravariantly*, whereas the
intuitive answer (which is correct in case the function doesn't mutate
its argument!) requires the argument to act *covariantly*.  A longer
introduction to these concepts can be found on `Wikipedia
<wiki-variance_>`_ and in :pep:`483`; here we just show how to control
a type checker's behavior.

By default generic types are considered *invariant* in all type variables,
which means that values for variables annotated with types like
``List[Employee]`` must exactly match the type annotation -- no subclasses or
superclasses of the type parameter (in this example ``Employee``) are
allowed.

To facilitate the declaration of container types where covariant or
contravariant type checking is acceptable, type variables accept keyword
arguments ``covariant=True`` or ``contravariant=True``. At most one of these
may be passed. Generic types defined with such variables are considered
covariant or contravariant in the corresponding variable. By convention,
it is recommended to use names ending in ``_co`` for type variables
defined with ``covariant=True`` and names ending in ``_contra`` for that
defined with ``contravariant=True``.

A typical example involves defining an immutable (or read-only)
container class::

  from typing import TypeVar, Generic, Iterable, Iterator

  T_co = TypeVar('T_co', covariant=True)

  class ImmutableList(Generic[T_co]):
      def __init__(self, items: Iterable[T_co]) -> None: ...
      def __iter__(self) -> Iterator[T_co]: ...
      ...

  class Employee: ...

  class Manager(Employee): ...

  def dump_employees(emps: ImmutableList[Employee]) -> None:
      for emp in emps:
          ...

  mgrs = ImmutableList([Manager()])  # type: ImmutableList[Manager]
  dump_employees(mgrs)  # OK

The read-only collection classes in ``typing`` are all declared
covariant in their type variable (e.g. ``Mapping`` and ``Sequence``). The
mutable collection classes (e.g. ``MutableMapping`` and
``MutableSequence``) are declared invariant. The one example of
a contravariant type is the ``Generator`` type, which is contravariant
in the ``send()`` argument type (see below).

Note: Covariance or contravariance is *not* a property of a type variable,
but a property of a generic class defined using this variable.
Variance is only applicable to generic types; generic functions
do not have this property. The latter should be defined using only
type variables without ``covariant`` or ``contravariant`` keyword arguments.
For example, the following example is
fine::

  from typing import TypeVar

  class Employee: ...

  class Manager(Employee): ...

  E = TypeVar('E', bound=Employee)

  def dump_employee(e: E) -> None: ...

  dump_employee(Manager())  # OK

while the following is prohibited::

  B_co = TypeVar('B_co', covariant=True)

  def bad_func(x: B_co) -> B_co:  # Flagged as error by a type checker
      ...


The numeric tower
-----------------

:pep:`3141` defines Python's numeric tower, and the stdlib module
``numbers`` implements the corresponding ABCs (``Number``,
``Complex``, ``Real``, ``Rational`` and ``Integral``).  There are some
issues with these ABCs, but the built-in concrete numeric classes
``complex``, ``float`` and ``int`` are ubiquitous (especially the
latter two :-).

Rather than requiring that users write ``import numbers`` and then use
``numbers.Float`` etc., this PEP proposes a straightforward shortcut
that is almost as effective: when an argument is annotated as having
type ``float``, an argument of type ``int`` is acceptable; similar,
for an argument annotated as having type ``complex``, arguments of
type ``float`` or ``int`` are acceptable.  This does not handle
classes implementing the corresponding ABCs or the
``fractions.Fraction`` class, but we believe those use cases are
exceedingly rare.


Forward references
------------------

When a type hint contains names that have not been defined yet, that
definition may be expressed as a string literal, to be resolved later.

A situation where this occurs commonly is the definition of a
container class, where the class being defined occurs in the signature
of some of the methods.  For example, the following code (the start of
a simple binary tree implementation) does not work::

  class Tree:
      def __init__(self, left: Tree, right: Tree):
          self.left = left
          self.right = right

To address this, we write::

  class Tree:
      def __init__(self, left: 'Tree', right: 'Tree'):
          self.left = left
          self.right = right

The string literal should contain a valid Python expression (i.e.,
``compile(lit, '', 'eval')`` should be a valid code object) and it
should evaluate without errors once the module has been fully loaded.
The local and global namespace in which it is evaluated should be the
same namespaces in which default arguments to the same function would
be evaluated.

Moreover, the expression should be parseable as a valid type hint, i.e.,
it is constrained by the rules from the section `Acceptable type hints`_
above.

It is allowable to use string literals as *part* of a type hint, for
example::

    class Tree:
        ...
        def leaves(self) -> List['Tree']:
            ...

A common use for forward references is when e.g. Django models are
needed in the signatures.  Typically, each model is in a separate
file, and has methods taking arguments whose type involves other models.
Because of the way circular imports work in Python, it is often not
possible to import all the needed models directly::

    # File models/a.py
    from models.b import B
    class A(Model):
        def foo(self, b: B): ...

    # File models/b.py
    from models.a import A
    class B(Model):
        def bar(self, a: A): ...

    # File main.py
    from models.a import A
    from models.b import B

Assuming main is imported first, this will fail with an ImportError at
the line ``from models.a import A`` in models/b.py, which is being
imported from models/a.py before a has defined class A.  The solution
is to switch to module-only imports and reference the models by their
_module_._class_ name::

    # File models/a.py
    from models import b
    class A(Model):
        def foo(self, b: 'b.B'): ...

    # File models/b.py
    from models import a
    class B(Model):
        def bar(self, a: 'a.A'): ...

    # File main.py
    from models.a import A
    from models.b import B


Union types
-----------

Since accepting a small, limited set of expected types for a single
argument is common, there is a new special factory called ``Union``.
Example::

  from typing import Union

  def handle_employees(e: Union[Employee, Sequence[Employee]]) -> None:
      if isinstance(e, Employee):
          e = [e]
      ...

A type factored by ``Union[T1, T2, ...]`` is a supertype
of all types ``T1``, ``T2``, etc., so that a value that
is a member of one of these types is acceptable for an argument
annotated by ``Union[T1, T2, ...]``.

One common case of union types are *optional* types.  By default,
``None`` is an invalid value for any type, unless a default value of
``None`` has been provided in the function definition.  Examples::

  def handle_employee(e: Union[Employee, None]) -> None: ...

As a shorthand for ``Union[T1, None]`` you can write ``Optional[T1]``;
for example, the above is equivalent to::

  from typing import Optional

  def handle_employee(e: Optional[Employee]) -> None: ...

A past version of this PEP allowed type checkers to assume an optional
type when the default value is ``None``, as in this code::

  def handle_employee(e: Employee = None): ...

This would have been treated as equivalent to::

  def handle_employee(e: Optional[Employee] = None) -> None: ...

This is no longer the recommended behavior. Type checkers should move
towards requiring the optional type to be made explicit.

Support for singleton types in unions
-------------------------------------

A singleton instance is frequently used to mark some special condition,
in particular in situations where ``None`` is also a valid value
for a variable. Example::

  _empty = object()

  def func(x=_empty):
      if x is _empty:  # default argument value
          return 0
      elif x is None:  # argument was provided and it's None
          return 1
      else:
          return x * 2

To allow precise typing in such situations, the user should use
the ``Union`` type in conjunction with the ``enum.Enum`` class provided
by the standard library, so that type errors can be caught statically::

  from typing import Union
  from enum import Enum

  class Empty(Enum):
      token = 0
  _empty = Empty.token

  def func(x: Union[int, None, Empty] = _empty) -> int:

      boom = x * 42  # This fails type check

      if x is _empty:
          return 0
      elif x is None:
          return 1
      else:  # At this point typechecker knows that x can only have type int
          return x * 2

Since the subclasses of ``Enum`` cannot be further subclassed,
the type of variable ``x`` can be statically inferred in all branches
of the above example. The same approach is applicable if more than one
singleton object is needed: one can use an enumeration that has more than
one value::

  class Reason(Enum):
      timeout = 1
      error = 2

  def process(response: Union[str, Reason] = '') -> str:
      if response is Reason.timeout:
          return 'TIMEOUT'
      elif response is Reason.error:
          return 'ERROR'
      else:
          # response can be only str, all other possible values exhausted
          return 'PROCESSED: ' + response


The ``Any`` type
----------------

A special kind of type is ``Any``.  Every type is consistent with
``Any``.  It can be considered a type that has all values and all methods.
Note that ``Any`` and builtin type ``object`` are completely different.

When the type of a value is ``object``, the type checker will reject
almost all operations on it, and assigning it to a variable (or using
it as a return value) of a more specialized type is a type error.  On
the other hand, when a value has type ``Any``, the type checker will
allow all operations on it, and a value of type ``Any`` can be assigned
to a variable (or used as a return value) of a more constrained type.

A function parameter without an annotation is assumed to be annotated with
``Any``. If a generic type is used without specifying type parameters,
they are assumed to be ``Any``::

  from typing import Mapping

  def use_map(m: Mapping) -> None:  # Same as Mapping[Any, Any]
      ...

This rule also applies to ``Tuple``, in annotation context it is equivalent
to ``Tuple[Any, ...]`` and, in turn, to ``tuple``. As well, a bare
``Callable`` in an annotation is equivalent to ``Callable[..., Any]`` and,
in turn, to ``collections.abc.Callable``::

  from typing import Tuple, List, Callable

  def check_args(args: Tuple) -> bool:
      ...

  check_args(())           # OK
  check_args((42, 'abc'))  # Also OK
  check_args(3.14)         # Flagged as error by a type checker

  # A list of arbitrary callables is accepted by this function
  def apply_callbacks(cbs: List[Callable]) -> None:
      ...


The ``NoReturn`` type
---------------------

The ``typing`` module provides a special type ``NoReturn`` to annotate functions
that never return normally. For example, a function that unconditionally
raises an exception::

  from typing import NoReturn

  def stop() -> NoReturn:
      raise RuntimeError('no way')

The ``NoReturn`` annotation is used for functions such as ``sys.exit``.
Static type checkers will ensure that functions annotated as returning
``NoReturn`` truly never return, either implicitly or explicitly::

  import sys
  from typing import NoReturn

    def f(x: int) -> NoReturn:  # Error, f(0) implicitly returns None
        if x != 0:
            sys.exit(1)

The checkers will also recognize that the code after calls to such functions
is unreachable and will behave accordingly::

  # continue from first example
  def g(x: int) -> int:
      if x > 0:
          return x
      stop()
      return 'whatever works'  # Error might be not reported by some checkers
                               # that ignore errors in unreachable blocks

The ``NoReturn`` type is only valid as a return annotation of functions,
and considered an error if it appears in other positions::

  from typing import List, NoReturn

  # All of the following are errors
  def bad1(x: NoReturn) -> int:
      ...
  bad2 = None  # type: NoReturn
  def bad3() -> List[NoReturn]:
      ...


The type of class objects
-------------------------

Sometimes you want to talk about class objects, in particular class
objects that inherit from a given class.  This can be spelled as
``Type[C]`` where ``C`` is a class.  To clarify: while ``C`` (when
used as an annotation) refers to instances of class ``C``, ``Type[C]``
refers to *subclasses* of ``C``.  (This is a similar distinction as
between ``object`` and ``type``.)

For example, suppose we have the following classes::

  class User: ...  # Abstract base for User classes
  class BasicUser(User): ...
  class ProUser(User): ...
  class TeamUser(User): ...

And suppose we have a function that creates an instance of one of
these classes if you pass it a class object::

  def new_user(user_class):
      user = user_class()
      # (Here we could write the user object to a database)
      return user

Without ``Type[]`` the best we could do to annotate ``new_user()``
would be::

  def new_user(user_class: type) -> User:
      ...

However using ``Type[]`` and a type variable with an upper bound we
can do much better::

  U = TypeVar('U', bound=User)
  def new_user(user_class: Type[U]) -> U:
      ...

Now when we call ``new_user()`` with a specific subclass of ``User`` a
type checker will infer the correct type of the result::

  joe = new_user(BasicUser)  # Inferred type is BasicUser

The value corresponding to ``Type[C]`` must be an actual class object
that's a subtype of ``C``, not a special form.  In other words, in the
above example calling e.g. ``new_user(Union[BasicUser, ProUser])`` is
rejected by the type checker (in addition to failing at runtime
because you can't instantiate a union).

Note that it is legal to use a union of classes as the parameter for
``Type[]``, as in::

  def new_non_team_user(user_class: Type[Union[BasicUser, ProUser]]):
      user = new_user(user_class)
      ...

However the actual argument passed in at runtime must still be a
concrete class object, e.g. in the above example::

  new_non_team_user(ProUser)  # OK
  new_non_team_user(TeamUser)  # Disallowed by type checker

``Type[Any]`` is also supported (see below for its meaning).

``Type[T]`` where ``T`` is a type variable is allowed when annotating the
first argument of a class method (see the relevant section).

Any other special constructs like ``Tuple`` or ``Callable`` are not allowed
as an argument to ``Type``.

There are some concerns with this feature: for example when
``new_user()`` calls ``user_class()`` this implies that all subclasses
of ``User`` must support this in their constructor signature.  However
this is not unique to ``Type[]``: class methods have similar concerns.
A type checker ought to flag violations of such assumptions, but by
default constructor calls that match the constructor signature in the
indicated base class (``User`` in the example above) should be
allowed.  A program containing a complex or extensible class hierarchy
might also handle this by using a factory class method.  A future
revision of this PEP may introduce better ways of dealing with these
concerns.

When ``Type`` is parameterized it requires exactly one parameter.
Plain ``Type`` without brackets is equivalent to ``Type[Any]`` and
this in turn is equivalent to ``type`` (the root of Python's metaclass
hierarchy).  This equivalence also motivates the name, ``Type``, as
opposed to alternatives like ``Class`` or ``SubType``, which were
proposed while this feature was under discussion; this is similar to
the relationship between e.g. ``List`` and ``list``.

Regarding the behavior of ``Type[Any]`` (or ``Type`` or ``type``),
accessing attributes of a variable with this type only provides
attributes and methods defined by ``type`` (for example,
``__repr__()`` and ``__mro__``).  Such a variable can be called with
arbitrary arguments, and the return type is ``Any``.

``Type`` is covariant in its parameter, because ``Type[Derived]`` is a
subtype of ``Type[Base]``::

  def new_pro_user(pro_user_class: Type[ProUser]):
      user = new_user(pro_user_class)  # OK
      ...


Annotating instance and class methods
-------------------------------------

In most cases the first argument of class and instance methods
does not need to be annotated, and it is assumed to have the
type of the containing class for instance methods, and a type object
type corresponding to the containing class object for class methods.
In addition, the first argument in an instance method can be annotated
with a type variable. In this case the return type may use the same
type variable, thus making that method a generic function. For example::

  T = TypeVar('T', bound='Copyable')
  class Copyable:
      def copy(self: T) -> T:
          # return a copy of self

  class C(Copyable): ...
  c = C()
  c2 = c.copy()  # type here should be C

The same applies to class methods using ``Type[]`` in an annotation
of the first argument::

  T = TypeVar('T', bound='C')
  class C:
      @classmethod
      def factory(cls: Type[T]) -> T:
          # make a new instance of cls

  class D(C): ...
  d = D.factory()  # type here should be D

Note that some type checkers may apply restrictions on this use, such as
requiring an appropriate upper bound for the type variable used
(see examples).


Version and platform checking
-----------------------------

Type checkers are expected to understand simple version and platform
checks, e.g.::

  import sys

  if sys.version_info[0] >= 3:
      # Python 3 specific definitions
  else:
      # Python 2 specific definitions

  if sys.platform == 'win32':
      # Windows specific definitions
  else:
      # Posix specific definitions

Don't expect a checker to understand obfuscations like
``"".join(reversed(sys.platform)) == "xunil"``.


Runtime or type checking?
-------------------------

Sometimes there's code that must be seen by a type checker (or other
static analysis tools) but should not be executed.  For such
situations the ``typing`` module defines a constant,
``TYPE_CHECKING``, that is considered ``True`` during type checking
(or other static analysis) but ``False`` at runtime.  Example::

  import typing

  if typing.TYPE_CHECKING:
      import expensive_mod

  def a_func(arg: 'expensive_mod.SomeClass') -> None:
      a_var = arg  # type: expensive_mod.SomeClass
      ...

(Note that the type annotation must be enclosed in quotes, making it a
"forward reference", to hide the ``expensive_mod`` reference from the
interpreter runtime.  In the ``# type`` comment no quotes are needed.)

This approach may also be useful to handle import cycles.


Arbitrary argument lists and default argument values
----------------------------------------------------

Arbitrary argument lists can as well be type annotated,
so that the definition::

  def foo(*args: str, **kwds: int): ...

is acceptable and it means that, e.g., all of the following
represent function calls with valid types of arguments::

  foo('a', 'b', 'c')
  foo(x=1, y=2)
  foo('', z=0)

In the body of function ``foo``, the type of variable ``args`` is
deduced as ``Tuple[str, ...]`` and the type of variable ``kwds``
is ``Dict[str, int]``.

In stubs it may be useful to declare an argument as having a default
without specifying the actual default value.  For example::

  def foo(x: AnyStr, y: AnyStr = ...) -> AnyStr: ...

What should the default value look like?  Any of the options ``""``,
``b""`` or ``None`` fails to satisfy the type constraint.

In such cases the default value may be specified as a literal
ellipsis, i.e. the above example is literally what you would write.


Positional-only arguments
-------------------------

Some functions are designed to take their arguments only positionally,
and expect their callers never to use the argument's name to provide
that argument by keyword. All arguments with names beginning with
``__`` are assumed to be positional-only, except if their names also
end with ``__``::

  def quux(__x: int, __y__: int = 0) -> None: ...

  quux(3, __y__=1)  # This call is fine.

  quux(__x=3)  # This call is an error.


Annotating generator functions and coroutines
---------------------------------------------

The return type of generator functions can be annotated by
the generic type ``Generator[yield_type, send_type,
return_type]`` provided by ``typing.py`` module::

  def echo_round() -> Generator[int, float, str]:
      res = yield
      while res:
          res = yield round(res)
      return 'OK'

Coroutines introduced in :pep:`492` are annotated with the same syntax as
ordinary functions. However, the return type annotation corresponds to the
type of ``await`` expression, not to the coroutine type::

  async def spam(ignored: int) -> str:
      return 'spam'

  async def foo() -> None:
      bar = await spam(42)  # type: str

The ``typing.py`` module provides a generic version of ABC
``collections.abc.Coroutine`` to specify awaitables that also support
``send()`` and ``throw()`` methods. The variance and order of type variables
correspond to those of ``Generator``, namely ``Coroutine[T_co, T_contra, V_co]``,
for example::

  from typing import List, Coroutine
  c = None  # type: Coroutine[List[str], str, int]
  ...
  x = c.send('hi')  # type: List[str]
  async def bar() -> None:
      x = await c  # type: int

The module also provides generic ABCs ``Awaitable``,
``AsyncIterable``, and ``AsyncIterator`` for situations where more precise
types cannot be specified::

  def op() -> typing.Awaitable[str]:
      if cond:
          return spam(42)
      else:
          return asyncio.Future(...)


Compatibility with other uses of function annotations
=====================================================

A number of existing or potential use cases for function annotations
exist, which are incompatible with type hinting.  These may confuse
a static type checker.  However, since type hinting annotations have no
runtime behavior (other than evaluation of the annotation expression and
storing annotations in the ``__annotations__`` attribute of the function
object), this does not make the program incorrect -- it just may cause
a type checker to emit spurious warnings or errors.

To mark portions of the program that should not be covered by type
hinting, you can use one or more of the following:

* a ``# type: ignore`` comment;

* a ``@no_type_check`` decorator on a class or function;

* a custom class or function decorator marked with
  ``@no_type_check_decorator``.

For more details see later sections.

In order for maximal compatibility with offline type checking it may
eventually be a good idea to change interfaces that rely on annotations
to switch to a different mechanism, for example a decorator.  In Python
3.5 there is no pressure to do this, however.  See also the longer
discussion under `Rejected alternatives`_ below.


Type comments
=============

No first-class syntax support for explicitly marking variables as being
of a specific type is added by this PEP.  To help with type inference in
complex cases, a comment of the following format may be used::

  x = []                # type: List[Employee]
  x, y, z = [], [], []  # type: List[int], List[int], List[str]
  x, y, z = [], [], []  # type: (List[int], List[int], List[str])
  a, b, *c = range(5)   # type: float, float, List[float]
  x = [1, 2]            # type: List[int]

Type comments should be put on the last line of the statement that
contains the variable definition. They can also be placed on
``with`` statements and ``for`` statements, right after the colon.

Examples of type comments on ``with`` and ``for`` statements::

  with frobnicate() as foo:  # type: int
      # Here foo is an int
      ...

  for x, y in points:  # type: float, float
      # Here x and y are floats
      ...

In stubs it may be useful to declare the existence of a variable
without giving it an initial value.  This can be done using :pep:`526`
variable annotation syntax::

  from typing import IO

  stream: IO[str]

The above syntax is acceptable in stubs for all versions of Python.
However, in non-stub code for versions of Python 3.5 and earlier
there is a special case::

  from typing import IO

  stream = None  # type: IO[str]

Type checkers should not complain about this (despite the value
``None`` not matching the given type), nor should they change the
inferred type to ``Optional[...]`` (despite the rule that does this
for annotated arguments with a default value of ``None``).  The
assumption here is that other code will ensure that the variable is
given a value of the proper type, and all uses can assume that the
variable has the given type.

The ``# type: ignore`` comment should be put on the line that the
error refers to::

  import http.client
  errors = {
      'not_found': http.client.NOT_FOUND  # type: ignore
  }

A ``# type: ignore`` comment on a line by itself at the top of a file,
before any docstrings, imports, or other executable code, silences all
errors in the file. Blank lines and other comments, such as shebang
lines and coding cookies, may precede the ``# type: ignore`` comment.

In some cases, linting tools or other comments may be needed on the same
line as a type comment. In these cases, the type comment should be before
other comments and linting markers:

  # type: ignore # <comment or other marker>

If type hinting proves useful in general, a syntax for typing variables
may be provided in a future Python version. (**UPDATE**: This syntax
was added in Python 3.6 through :pep:`526`.)

Casts
=====

Occasionally the type checker may need a different kind of hint: the
programmer may know that an expression is of a more constrained type
than a type checker may be able to infer.  For example::

  from typing import List, cast

  def find_first_str(a: List[object]) -> str:
      index = next(i for i, x in enumerate(a) if isinstance(x, str))
      # We only get here if there's at least one string in a
      return cast(str, a[index])

Some type checkers may not be able to infer that the type of
``a[index]`` is ``str`` and only infer ``object`` or ``Any``, but we
know that (if the code gets to that point) it must be a string.  The
``cast(t, x)`` call tells the type checker that we are confident that
the type of ``x`` is ``t``.  At runtime a cast always returns the
expression unchanged -- it does not check the type, and it does not
convert or coerce the value.

Casts differ from type comments (see the previous section).  When using
a type comment, the type checker should still verify that the inferred
type is consistent with the stated type.  When using a cast, the type
checker should blindly believe the programmer.  Also, casts can be used
in expressions, while type comments only apply to assignments.


NewType helper function
=======================

There are also situations where a programmer might want to avoid logical
errors by creating simple classes. For example::

  class UserId(int):
      pass

  def get_by_user_id(user_id: UserId):
      ...

However, this approach introduces a runtime overhead. To avoid this,
``typing.py`` provides a helper function ``NewType`` that creates
simple unique types with almost zero runtime overhead. For a static type
checker ``Derived = NewType('Derived', Base)`` is roughly equivalent
to a definition::

  class Derived(Base):
      def __init__(self, _x: Base) -> None:
          ...

While at runtime, ``NewType('Derived', Base)`` returns a dummy function
that simply returns its argument. Type checkers require explicit casts
from ``int`` where ``UserId`` is expected, while implicitly casting
from ``UserId`` where ``int`` is expected. Examples::

        UserId = NewType('UserId', int)

        def name_by_id(user_id: UserId) -> str:
            ...

        UserId('user')          # Fails type check

        name_by_id(42)          # Fails type check
        name_by_id(UserId(42))  # OK

        num = UserId(5) + 1     # type: int

``NewType`` accepts exactly two arguments: a name for the new unique type,
and a base class. The latter should be a proper class (i.e.,
not a type construct like ``Union``, etc.), or another unique type created
by calling ``NewType``. The function returned by ``NewType``
accepts only one argument; this is equivalent to supporting only one
constructor accepting an instance of the base class (see above). Example::

  class PacketId:
      def __init__(self, major: int, minor: int) -> None:
          self._major = major
          self._minor = minor

  TcpPacketId = NewType('TcpPacketId', PacketId)

  packet = PacketId(100, 100)
  tcp_packet = TcpPacketId(packet)  # OK

  tcp_packet = TcpPacketId(127, 0)  # Fails in type checker and at runtime

Both ``isinstance`` and ``issubclass``, as well as subclassing will fail
for ``NewType('Derived', Base)`` since function objects don't support
these operations.


Stub Files
==========

Stub files are files containing type hints that are only for use by
the type checker, not at runtime.  There are several use cases for
stub files:

* Extension modules

* Third-party modules whose authors have not yet added type hints

* Standard library modules for which type hints have not yet been
  written

* Modules that must be compatible with Python 2 and 3

* Modules that use annotations for other purposes

Stub files have the same syntax as regular Python modules.  There is one
feature of the ``typing`` module that is different in stub files:
the ``@overload`` decorator described below.

The type checker should only check function signatures in stub files;
It is recommended that function bodies in stub files just be a single
ellipsis (``...``).

The type checker should have a configurable search path for stub files.
If a stub file is found the type checker should not read the
corresponding "real" module.

While stub files are syntactically valid Python modules, they use the
``.pyi`` extension to make it possible to maintain stub files in the
same directory as the corresponding real module.  This also reinforces
the notion that no runtime behavior should be expected of stub files.

Additional notes on stub files:

* Modules and variables imported into the stub are not considered
  exported from the stub unless the import uses the ``import ... as
  ...`` form or the equivalent ``from ... import ... as ...`` form.
  (*UPDATE:* To clarify, the intention here is that only names
  imported using the form ``X as X`` will be exported, i.e. the name
  before and after ``as`` must be the same.)

* However, as an exception to the previous bullet, all objects
  imported into a stub using ``from ... import *`` are considered
  exported.  (This makes it easier to re-export all objects from a
  given module that may vary by Python version.)

* Just like in `normal Python files <importdocs_>`_, submodules
  automatically become exported attributes of their parent module
  when imported. For example, if the ``spam`` package has the
  following directory structure::

      spam/
          __init__.pyi
          ham.pyi

  where ``__init__.pyi`` contains a line such as ``from . import ham``
  or ``from .ham import Ham``, then ``ham`` is an exported attribute
  of ``spam``.

* Stub files may be incomplete. To make type checkers aware of this, the file
  can contain the following code::

    def __getattr__(name) -> Any: ...

  Any identifier not defined in the stub is therefore assumed to be of type
  ``Any``.

Function/method overloading
---------------------------

The ``@overload`` decorator allows describing functions and methods
that support multiple different combinations of argument types.  This
pattern is used frequently in builtin modules and types.  For example,
the ``__getitem__()`` method of the ``bytes`` type can be described as
follows::

  from typing import overload

  class bytes:
      ...
      @overload
      def __getitem__(self, i: int) -> int: ...
      @overload
      def __getitem__(self, s: slice) -> bytes: ...

This description is more precise than would be possible using unions
(which cannot express the relationship between the argument and return
types)::

  from typing import Union

  class bytes:
      ...
      def __getitem__(self, a: Union[int, slice]) -> Union[int, bytes]: ...

Another example where ``@overload`` comes in handy is the type of the
builtin ``map()`` function, which takes a different number of
arguments depending on the type of the callable::

  from typing import Callable, Iterable, Iterator, Tuple, TypeVar, overload

  T1 = TypeVar('T1')
  T2 = TypeVar('T2')
  S = TypeVar('S')

  @overload
  def map(func: Callable[[T1], S], iter1: Iterable[T1]) -> Iterator[S]: ...
  @overload
  def map(func: Callable[[T1, T2], S],
          iter1: Iterable[T1], iter2: Iterable[T2]) -> Iterator[S]: ...
  # ... and we could add more items to support more than two iterables

Note that we could also easily add items to support ``map(None, ...)``::

  @overload
  def map(func: None, iter1: Iterable[T1]) -> Iterable[T1]: ...
  @overload
  def map(func: None,
          iter1: Iterable[T1],
          iter2: Iterable[T2]) -> Iterable[Tuple[T1, T2]]: ...

Uses of the ``@overload`` decorator as shown above are suitable for
stub files.  In regular modules, a series of ``@overload``-decorated
definitions must be followed by exactly one
non-``@overload``-decorated definition (for the same function/method).
The ``@overload``-decorated definitions are for the benefit of the
type checker only, since they will be overwritten by the
non-``@overload``-decorated definition, while the latter is used at
runtime but should be ignored by a type checker.  At runtime, calling
a ``@overload``-decorated function directly will raise
``NotImplementedError``.  Here's an example of a non-stub overload
that can't easily be expressed using a union or a type variable::

  @overload
  def utf8(value: None) -> None:
      pass
  @overload
  def utf8(value: bytes) -> bytes:
      pass
  @overload
  def utf8(value: unicode) -> bytes:
      pass
  def utf8(value):
      <actual implementation>

NOTE: While it would be possible to provide a multiple dispatch
implementation using this syntax, its implementation would require
using ``sys._getframe()``, which is frowned upon.  Also, designing and
implementing an efficient multiple dispatch mechanism is hard, which
is why previous attempts were abandoned in favor of
``functools.singledispatch()``.  (See :pep:`443`, especially its section
"Alternative approaches".)  In the future we may come up with a
satisfactory multiple dispatch design, but we don't want such a design
to be constrained by the overloading syntax defined for type hints in
stub files.  It is also possible that both features will develop
independent from each other (since overloading in the type checker
has different use cases and requirements than multiple dispatch
at runtime -- e.g. the latter is unlikely to support generic types).

A constrained ``TypeVar`` type can often be used instead of using the
``@overload`` decorator.  For example, the definitions of ``concat1``
and ``concat2`` in this stub file are equivalent::

  from typing import TypeVar, Text

  AnyStr = TypeVar('AnyStr', Text, bytes)

  def concat1(x: AnyStr, y: AnyStr) -> AnyStr: ...

  @overload
  def concat2(x: str, y: str) -> str: ...
  @overload
  def concat2(x: bytes, y: bytes) -> bytes: ...

Some functions, such as ``map`` or ``bytes.__getitem__`` above, can't
be represented precisely using type variables.  However, unlike
``@overload``, type variables can also be used outside stub files.  We
recommend that ``@overload`` is only used in cases where a type
variable is not sufficient, due to its special stub-only status.

Another important difference between type variables such as ``AnyStr``
and using ``@overload`` is that the prior can also be used to define
constraints for generic class type parameters.  For example, the type
parameter of the generic class ``typing.IO`` is constrained (only
``IO[str]``, ``IO[bytes]`` and ``IO[Any]`` are valid)::

  class IO(Generic[AnyStr]): ...

Storing and distributing stub files
-----------------------------------

The easiest form of stub file storage and distribution is to put them
alongside Python modules in the same directory.  This makes them easy to
find by both programmers and the tools.  However, since package
maintainers are free not to add type hinting to their packages,
third-party stubs installable by ``pip`` from PyPI are also supported.
In this case we have to consider three issues: naming, versioning,
installation path.

This PEP does not provide a recommendation on a naming scheme that
should be used for third-party stub file packages.  Discoverability will
hopefully be based on package popularity, like with Django packages for
example.

Third-party stubs have to be versioned using the lowest version of the
source package that is compatible.  Example: FooPackage has versions
1.0, 1.1, 1.2, 1.3, 2.0, 2.1, 2.2.  There are API changes in versions
1.1, 2.0 and 2.2.  The stub file package maintainer is free to release
stubs for all versions but at least 1.0, 1.1, 2.0 and 2.2 are needed
to enable the end user type check all versions.  This is because the
user knows that the closest *lower or equal* version of stubs is
compatible.  In the provided example, for FooPackage 1.3 the user would
choose stubs version 1.1.

Note that if the user decides to use the "latest" available source
package, using the "latest" stub files should generally also work if
they're updated often.

Third-party stub packages can use any location for stub storage.  Type
checkers should search for them using PYTHONPATH.  A default fallback
directory that is always checked is ``shared/typehints/pythonX.Y/`` (for
some PythonX.Y as determined by the type checker, not just the installed
version).  Since there can only be one package installed for a given Python
version per environment, no additional versioning is performed under that
directory (just like bare directory installs by ``pip`` in site-packages).
Stub file package authors might use the following snippet in ``setup.py``::

  ...
  data_files=[
      (
          'shared/typehints/python{}.{}'.format(*sys.version_info[:2]),
          pathlib.Path(SRC_PATH).glob('**/*.pyi'),
      ),
  ],
  ...

(*UPDATE:* As of June 2018 the recommended way to distribute type
hints for third-party packages has changed -- in addition to typeshed
(see the next section) there is now a standard for distributing type
hints, :pep:`561`. It supports separately installable packages containing
stubs, stub files included in the same distribution as the executable
code of a package, and inline type hints, the latter two options
enabled by including a file named ``py.typed`` in the package.)

The Typeshed Repo
-----------------

There is a `shared repository <typeshed_>`_ where useful stubs are being
collected.  Policies regarding the stubs collected here will be
decided separately and reported in the repo's documentation.
Note that stubs for a given package will not be included here
if the package owners have specifically requested that they be omitted.


Exceptions
==========

No syntax for listing explicitly raised exceptions is proposed.
Currently the only known use case for this feature is documentational,
in which case the recommendation is to put this information in a
docstring.


The ``typing`` Module
=====================

To open the usage of static type checking to Python 3.5 as well as older
versions, a uniform namespace is required.  For this purpose, a new
module in the standard library is introduced called ``typing``.

It defines the fundamental building blocks for constructing types
(e.g. ``Any``), types representing generic variants of builtin
collections (e.g. ``List``), types representing generic
collection ABCs (e.g. ``Sequence``), and a small collection of
convenience definitions.

Note that special type constructs, such as ``Any``, ``Union``,
and type variables defined using ``TypeVar`` are only supported
in the type annotation context, and ``Generic`` may only be used
as a base class. All of these (except for unparameterized generics)
will raise ``TypeError`` if appear in ``isinstance`` or ``issubclass``.

Fundamental building blocks:

* Any, used as ``def get(key: str) -> Any: ...``

* Union, used as ``Union[Type1, Type2, Type3]``

* Callable, used as ``Callable[[Arg1Type, Arg2Type], ReturnType]``

* Tuple, used by listing the element types, for example
  ``Tuple[int, int, str]``.
  The empty tuple can be typed as ``Tuple[()]``.
  Arbitrary-length homogeneous tuples can be expressed
  using one type and ellipsis, for example ``Tuple[int, ...]``.
  (The ``...`` here are part of the syntax, a literal ellipsis.)

* TypeVar, used as ``X = TypeVar('X', Type1, Type2, Type3)`` or simply
  ``Y = TypeVar('Y')`` (see above for more details)

* Generic, used to create user-defined generic classes

* Type, used to annotate class objects

Generic variants of builtin collections:

* Dict, used as ``Dict[key_type, value_type]``

* DefaultDict, used as ``DefaultDict[key_type, value_type]``,
  a generic variant of ``collections.defaultdict``

* List, used as ``List[element_type]``

* Set, used as ``Set[element_type]``. See remark for ``AbstractSet``
  below.

* FrozenSet, used as ``FrozenSet[element_type]``

Note: ``Dict``, ``DefaultDict``, ``List``, ``Set`` and ``FrozenSet``
are mainly useful for annotating return values.
For arguments, prefer the abstract collection types defined below,
e.g.  ``Mapping``, ``Sequence`` or ``AbstractSet``.

Generic variants of container ABCs (and a few non-containers):

* Awaitable

* AsyncIterable

* AsyncIterator

* ByteString

* Callable (see above, listed here for completeness)

* Collection

* Container

* ContextManager

* Coroutine

* Generator, used as ``Generator[yield_type, send_type,
  return_type]``.  This represents the return value of generator
  functions.  It is a subtype of ``Iterable`` and it has additional
  type variables for the type accepted by the ``send()`` method (it
  is contravariant in this variable -- a generator that accepts sending it
  ``Employee`` instance is valid in a context where a generator is required
  that accepts sending it ``Manager`` instances) and the return type of the
  generator.

* Hashable (not generic, but present for completeness)

* ItemsView

* Iterable

* Iterator

* KeysView

* Mapping

* MappingView

* MutableMapping

* MutableSequence

* MutableSet

* Sequence

* Set, renamed to ``AbstractSet``. This name change was required
  because ``Set`` in the ``typing`` module means ``set()`` with
  generics.

* Sized (not generic, but present for completeness)

* ValuesView

A few one-off types are defined that test for single special methods
(similar to ``Hashable`` or ``Sized``):

* Reversible, to test for ``__reversed__``

* SupportsAbs, to test for ``__abs__``

* SupportsComplex, to test for ``__complex__``

* SupportsFloat, to test for ``__float__``

* SupportsInt, to test for ``__int__``

* SupportsRound, to test for ``__round__``

* SupportsBytes, to test for ``__bytes__``

Convenience definitions:

* Optional, defined by ``Optional[t] == Union[t, None]``

* Text, a simple alias for ``str`` in Python 3, for ``unicode`` in Python 2

* AnyStr, defined as ``TypeVar('AnyStr', Text, bytes)``

* NamedTuple, used as
  ``NamedTuple(type_name, [(field_name, field_type), ...])``
  and equivalent to
  ``collections.namedtuple(type_name, [field_name, ...])``.
  This is useful to declare the types of the fields of a named tuple
  type.

* NewType, used to create unique types with little runtime overhead
  ``UserId = NewType('UserId', int)``

* cast(), described earlier

* @no_type_check, a decorator to disable type checking per class or
  function (see below)

* @no_type_check_decorator, a decorator to create your own decorators
  with the same meaning as ``@no_type_check`` (see below)

* @type_check_only, a decorator only available during type checking
  for use in stub files (see above); marks a class or function as
  unavailable during runtime

* @overload, described earlier

* get_type_hints(), a utility function to retrieve the type hints from a
  function or method.  Given a function or method object, it returns
  a dict with the same format as ``__annotations__``, but evaluating
  forward references (which are given as string literals) as expressions
  in the context of the original function or method definition.

* TYPE_CHECKING, ``False`` at runtime but ``True`` to  type checkers

I/O related types:

* IO (generic over ``AnyStr``)

* BinaryIO (a simple subtype of ``IO[bytes]``)

* TextIO (a simple subtype of ``IO[str]``)

Types related to regular expressions and the ``re`` module:

* Match and Pattern, types of ``re.match()`` and ``re.compile()``
  results (generic over ``AnyStr``)


Suggested syntax for Python 2.7 and straddling code
===================================================

Some tools may want to support type annotations in code that must be
compatible with Python 2.7.  For this purpose this PEP has a suggested
(but not mandatory) extension where function annotations are placed in
a ``# type:`` comment.  Such a comment must be placed immediately
following the function header (before the docstring).  An example: the
following Python 3 code::

  def embezzle(self, account: str, funds: int = 1000000, *fake_receipts: str) -> None:
      """Embezzle funds from account using fake receipts."""
      <code goes here>

is equivalent to the following::

  def embezzle(self, account, funds=1000000, *fake_receipts):
      # type: (str, int, *str) -> None
      """Embezzle funds from account using fake receipts."""
      <code goes here>

Note that for methods, no type is needed for ``self``.

For an argument-less method it would look like this::

  def load_cache(self):
      # type: () -> bool
      <code>

Sometimes you want to specify the return type for a function or method
without (yet) specifying the argument types.  To support this
explicitly, the argument list may be replaced with an ellipsis.
Example::

  def send_email(address, sender, cc, bcc, subject, body):
      # type: (...) -> bool
      """Send an email message.  Return True if successful."""
      <code>

Sometimes you have a long list of parameters and specifying their
types in a single ``# type:`` comment would be awkward.  To this end
you may list the arguments one per line and add a ``# type:`` comment
per line after an argument's associated comma, if any.
To specify the return type use the ellipsis syntax. Specifying the return
type is not mandatory and not every argument needs to be given a type.
A line with a ``# type:`` comment should contain exactly one argument.
The type comment for the last argument (if any) should precede the close
parenthesis. Example::

  def send_email(address,     # type: Union[str, List[str]]
                 sender,      # type: str
                 cc,          # type: Optional[List[str]]
                 bcc,         # type: Optional[List[str]]
                 subject='',
                 body=None    # type: List[str]
                 ):
      # type: (...) -> bool
      """Send an email message.  Return True if successful."""
      <code>

Notes:

- Tools that support this syntax should support it regardless of the
  Python version being checked.  This is necessary in order to support
  code that straddles Python 2 and Python 3.

- It is not allowed for an argument or return value to have both
  a type annotation and a type comment.

- When using the short form (e.g. ``# type: (str, int) -> None``)
  every argument must be accounted for, except the first argument of
  instance and class methods (those are usually omitted, but it's
  allowed to include them).

- The return type is mandatory for the short form.  If in Python 3 you
  would omit some argument or the return type, the Python 2 notation
  should use ``Any``.

- When using the short form, for ``*args`` and ``**kwds``, put 1 or 2
  stars in front of the corresponding type annotation.  (As with
  Python 3 annotations, the annotation here denotes the type of the
  individual argument values, not of the tuple/dict that you receive
  as the special argument value ``args`` or ``kwds``.)

- Like other type comments, any names used in the annotations must be
  imported or defined by the module containing the annotation.

- When using the short form, the entire annotation must be one line.

- The short form may also occur on the same line as the close
  parenthesis, e.g.::

    def add(a, b):  # type: (int, int) -> int
        return a + b

- Misplaced type comments will be flagged as errors by a type checker.
  If necessary, such comments could be commented twice. For example::

    def f():
        '''Docstring'''
        # type: () -> None  # Error!

    def g():
        '''Docstring'''
        # # type: () -> None  # This is OK

When checking Python 2.7 code, type checkers should treat the ``int`` and
``long`` types as equivalent. For parameters typed as ``Text``, arguments of
type ``str`` as well as ``unicode`` should be acceptable.

Rejected Alternatives
=====================

During discussion of earlier drafts of this PEP, various objections
were raised and alternatives were proposed.  We discuss some of these
here and explain why we reject them.

Several main objections were raised.

Which brackets for generic type parameters?
-------------------------------------------

Most people are familiar with the use of angular brackets
(e.g. ``List<int>``) in languages like C++, Java, C# and Swift to
express the parameterization of generic types.  The problem with these
is that they are really hard to parse, especially for a simple-minded
parser like Python.  In most languages the ambiguities are usually
dealt with by only allowing angular brackets in specific syntactic
positions, where general expressions aren't allowed.  (And also by
using very powerful parsing techniques that can backtrack over an
arbitrary section of code.)

But in Python, we'd like type expressions to be (syntactically) the
same as other expressions, so that we can use e.g. variable assignment
to create type aliases.  Consider this simple type expression::

    List<int>

From the Python parser's perspective, the expression begins with the
same four tokens (NAME, LESS, NAME, GREATER) as a chained comparison::

    a < b > c  # I.e., (a < b) and (b > c)

We can even make up an example that could be parsed both ways::

    a < b > [ c ]

Assuming we had angular brackets in the language, this could be
interpreted as either of the following two::

    (a<b>)[c]      # I.e., (a<b>).__getitem__(c)
    a < b > ([c])  # I.e., (a < b) and (b > [c])

It would surely be possible to come up with a rule to disambiguate
such cases, but to most users the rules would feel arbitrary and
complex.  It would also require us to dramatically change the CPython
parser (and every other parser for Python).  It should be noted that
Python's current parser is intentionally "dumb" -- a simple grammar is
easier for users to reason about.

For all these reasons, square brackets (e.g. ``List[int]``) are (and
have long been) the preferred syntax for generic type parameters.
They can be implemented by defining the ``__getitem__()`` method on
the metaclass, and no new syntax is required at all.  This option
works in all recent versions of Python (starting with Python 2.2).
Python is not alone in this syntactic choice -- generic classes in
Scala also use square brackets.

What about existing uses of annotations?
----------------------------------------

One line of argument points out that :pep:`3107` explicitly supports
the use of arbitrary expressions in function annotations.  The new
proposal is then considered incompatible with the specification of PEP
3107.

Our response to this is that, first of all, the current proposal does
not introduce any direct incompatibilities, so programs using
annotations in Python 3.4 will still work correctly and without
prejudice in Python 3.5.

We do hope that type hints will eventually become the sole use for
annotations, but this will require additional discussion and a
deprecation period after the initial roll-out of the typing module
with Python 3.5.  The current PEP will have provisional status (see
:pep:`411`) until Python 3.6 is released.  The fastest conceivable scheme
would introduce silent deprecation of non-type-hint annotations in
3.6, full deprecation in 3.7, and declare type hints as the only
allowed use of annotations in Python 3.8.  This should give authors of
packages that use annotations plenty of time to devise another
approach, even if type hints become an overnight success.

(*UPDATE:* As of fall 2017, the timeline for the end of provisional
status for this PEP and for the ``typing.py`` module has changed, and
so has the deprecation schedule for other uses of annotations.  For
the updated schedule see :pep:`563`.)

Another possible outcome would be that type hints will eventually
become the default meaning for annotations, but that there will always
remain an option to disable them.  For this purpose the current
proposal defines a decorator ``@no_type_check`` which disables the
default interpretation of annotations as type hints in a given class
or function.  It also defines a meta-decorator
``@no_type_check_decorator`` which can be used to decorate a decorator
(!), causing annotations in any function or class decorated with the
latter to be ignored by the type checker.

There are also ``# type: ignore`` comments, and static checkers should
support configuration options to disable type checking in selected
packages.

Despite all these options, proposals have been circulated to allow
type hints and other forms of annotations to coexist for individual
arguments.  One proposal suggests that if an annotation for a given
argument is a dictionary literal, each key represents a different form
of annotation, and the key ``'type'`` would be use for type hints.
The problem with this idea and its variants is that the notation
becomes very "noisy" and hard to read.  Also, in most cases where
existing libraries use annotations, there would be little need to
combine them with type hints.  So the simpler approach of selectively
disabling type hints appears sufficient.

The problem of forward declarations
-----------------------------------

The current proposal is admittedly sub-optimal when type hints must
contain forward references.  Python requires all names to be defined
by the time they are used.  Apart from circular imports this is rarely
a problem: "use" here means "look up at runtime", and with most
"forward" references there is no problem in ensuring that a name is
defined before the function using it is called.

The problem with type hints is that annotations (per :pep:`3107`, and
similar to default values) are evaluated at the time a function is
defined, and thus any names used in an annotation must be already
defined when the function is being defined.  A common scenario is a
class definition whose methods need to reference the class itself in
their annotations.  (More general, it can also occur with mutually
recursive classes.)  This is natural for container types, for
example::

  class Node:
      """Binary tree node."""

      def __init__(self, left: Node, right: Node):
          self.left = left
          self.right = right

As written this will not work, because of the peculiarity in Python
that class names become defined once the entire body of the class has
been executed.  Our solution, which isn't particularly elegant, but
gets the job done, is to allow using string literals in annotations.
Most of the time you won't have to use this though -- most *uses* of
type hints are expected to reference builtin types or types defined in
other modules.

A counterproposal would change the semantics of type hints so they
aren't evaluated at runtime at all (after all, type checking happens
off-line, so why would type hints need to be evaluated at runtime at
all).  This of course would run afoul of backwards compatibility,
since the Python interpreter doesn't actually know whether a
particular annotation is meant to be a type hint or something else.

A compromise is possible where a ``__future__`` import could enable
turning *all* annotations in a given module into string literals, as
follows::

  from __future__ import annotations

  class ImSet:
      def add(self, a: ImSet) -> List[ImSet]: ...

  assert ImSet.add.__annotations__ == {'a': 'ImSet', 'return': 'List[ImSet]'}

Such a ``__future__`` import statement may be proposed in a separate
PEP.

(*UPDATE:* That ``__future__`` import statement and its consequences
are discussed in :pep:`563`.)


The double colon
----------------

A few creative souls have tried to invent solutions for this problem.
For example, it was proposed to use a double colon (``::``) for type
hints, solving two problems at once: disambiguating between type hints
and other annotations, and changing the semantics to preclude runtime
evaluation.  There are several things wrong with this idea, however.

* It's ugly.  The single colon in Python has many uses, and all of
  them look familiar because they resemble the use of the colon in
  English text.  This is a general rule of thumb by which Python
  abides for most forms of punctuation; the exceptions are typically
  well known from other programming languages.  But this use of ``::``
  is unheard of in English, and in other languages (e.g. C++) it is
  used as a scoping operator, which is a very different beast.  In
  contrast, the single colon for type hints reads naturally -- and no
  wonder, since it was carefully designed for this purpose
  (`the idea <gvr-artima_>`_
  long predates :pep:`3107`).  It is also used in the same
  fashion in other languages from Pascal to Swift.

* What would you do for return type annotations?

* It's actually a feature that type hints are evaluated at runtime.

  * Making type hints available at runtime allows runtime type
    checkers to be built on top of type hints.

  * It catches mistakes even when the type checker is not run.  Since
    it is a separate program, users may choose not to run it (or even
    install it), but might still want to use type hints as a concise
    form of documentation.  Broken type hints are no use even for
    documentation.

* Because it's new syntax, using the double colon for type hints would
  limit them to code that works with Python 3.5 only.  By using
  existing syntax, the current proposal can easily work for older
  versions of Python 3.  (And in fact mypy supports Python 3.2 and
  newer.)

* If type hints become successful we may well decide to add new syntax
  in the future to declare the type for variables, for example
  ``var age: int = 42``.  If we were to use a double colon for
  argument type hints, for consistency we'd have to use the same
  convention for future syntax, perpetuating the ugliness.

Other forms of new syntax
-------------------------

A few other forms of alternative syntax have been proposed, e.g. `the
introduction <roberge_>`_ of a ``where`` keyword, and Cobra-inspired
``requires`` clauses.  But these all share a problem with the double
colon: they won't work for earlier versions of Python 3.  The same
would apply to a new ``__future__`` import.

Other backwards compatible conventions
--------------------------------------

The ideas put forward include:

* A decorator, e.g. ``@typehints(name=str, returns=str)``.  This could
  work, but it's pretty verbose (an extra line, and the argument names
  must be repeated), and a far cry in elegance from the :pep:`3107`
  notation.

* Stub files.  We do want stub files, but they are primarily useful
  for adding type hints to existing code that doesn't lend itself to
  adding type hints, e.g. 3rd party packages, code that needs to
  support both Python 2 and Python 3, and especially extension
  modules.  For most situations, having the annotations in line with
  the function definitions makes them much more useful.

* Docstrings.  There is an existing convention for docstrings, based
  on the Sphinx notation (``:type arg1: description``).  This is
  pretty verbose (an extra line per parameter), and not very elegant.
  We could also make up something new, but the annotation syntax is
  hard to beat (because it was designed for this very purpose).

It's also been proposed to simply wait another release.  But what
problem would that solve?  It would just be procrastination.


PEP Development Process
=======================

A live draft for this PEP lives on `GitHub <github_>`_.  There is also an
`issue tracker <issues_>`_, where much of the technical discussion takes
place.

The draft on GitHub is updated regularly in small increments.  The
`official PEPS repo <peps_>`_ is (usually) only updated when a new draft
is posted to python-dev.


Acknowledgements
================

This document could not be completed without valuable input,
encouragement and advice from Jim Baker, Jeremy Siek, Michael Matson
Vitousek, Andrey Vlasovskikh, Radomir Dopieralski, Peter Ludemann,
and the BDFL-Delegate, Mark Shannon.

Influences include existing languages, libraries and frameworks
mentioned in :pep:`482`.  Many thanks to their creators, in alphabetical
order: Stefan Behnel, William Edwards, Greg Ewing, Larry Hastings,
Anders Hejlsberg, Alok Menghrajani, Travis E. Oliphant, Joe Pamer,
Raoul-Gabriel Urma, and Julien Verlaguet.


.. _mypy:
   http://mypy-lang.org

.. _gvr-artima:
   https://www.artima.com/weblogs/viewpost.jsp?thread=85551

.. _wiki-variance:
   https://en.wikipedia.org/wiki/Covariance_and_contravariance_%28computer_science%29

.. _typeshed:
   https://github.com/python/typeshed

.. _roberge:
   https://aroberge.blogspot.com/2015/01/type-hinting-in-python-focus-on.html

.. _github:
   https://github.com/python/typing

.. _issues:
   https://github.com/python/typing/issues

.. _peps:
   https://hg.python.org/peps/file/tip/pep-0484.txt

.. _importdocs:
   https://docs.python.org/3/reference/import.html#submodules


Copyright
=========

This document has been placed in the public domain.
```

## Google Python Style Guide
```md
<!--
AUTHORS:
Prefer only GitHub-flavored Markdown in external text.
See README.md for details.
-->

# Google Python Style Guide

<!-- markdown="1" is required for GitHub Pages to render the TOC properly. -->

<details markdown="1">
  <summary>Table of Contents</summary>

-   [1 Background](#s1-background)
-   [2 Python Language Rules](#s2-python-language-rules)
    *   [2.1 Lint](#s2.1-lint)
    *   [2.2 Imports](#s2.2-imports)
    *   [2.3 Packages](#s2.3-packages)
    *   [2.4 Exceptions](#s2.4-exceptions)
    *   [2.5 Mutable Global State](#s2.5-global-variables)
    *   [2.6 Nested/Local/Inner Classes and Functions](#s2.6-nested)
    *   [2.7 Comprehensions & Generator Expressions](#s2.7-comprehensions)
    *   [2.8 Default Iterators and Operators](#s2.8-default-iterators-and-operators)
    *   [2.9 Generators](#s2.9-generators)
    *   [2.10 Lambda Functions](#s2.10-lambda-functions)
    *   [2.11 Conditional Expressions](#s2.11-conditional-expressions)
    *   [2.12 Default Argument Values](#s2.12-default-argument-values)
    *   [2.13 Properties](#s2.13-properties)
    *   [2.14 True/False Evaluations](#s2.14-truefalse-evaluations)
    *   [2.16 Lexical Scoping](#s2.16-lexical-scoping)
    *   [2.17 Function and Method Decorators](#s2.17-function-and-method-decorators)
    *   [2.18 Threading](#s2.18-threading)
    *   [2.19 Power Features](#s2.19-power-features)
    *   [2.20 Modern Python: from \_\_future\_\_ imports](#s2.20-modern-python)
    *   [2.21 Type Annotated Code](#s2.21-type-annotated-code)
-   [3 Python Style Rules](#s3-python-style-rules)
    *   [3.1 Semicolons](#s3.1-semicolons)
    *   [3.2 Line length](#s3.2-line-length)
    *   [3.3 Parentheses](#s3.3-parentheses)
    *   [3.4 Indentation](#s3.4-indentation)
        +   [3.4.1 Trailing commas in sequences of items?](#s3.4.1-trailing-commas)
    *   [3.5 Blank Lines](#s3.5-blank-lines)
    *   [3.6 Whitespace](#s3.6-whitespace)
    *   [3.7 Shebang Line](#s3.7-shebang-line)
    *   [3.8 Comments and Docstrings](#s3.8-comments-and-docstrings)
        +   [3.8.1 Docstrings](#s3.8.1-comments-in-doc-strings)
        +   [3.8.2 Modules](#s3.8.2-comments-in-modules)
        +   [3.8.2.1 Test modules](#s3.8.2.1-test-modules)
        +   [3.8.3 Functions and Methods](#s3.8.3-functions-and-methods)
        +   [3.8.3.1 Overridden Methods](#s3.8.3.1-overridden-methods)
        +   [3.8.4 Classes](#s3.8.4-comments-in-classes)
        +   [3.8.5 Block and Inline Comments](#s3.8.5-block-and-inline-comments)
        +   [3.8.6 Punctuation, Spelling, and Grammar](#s3.8.6-punctuation-spelling-and-grammar)
    *   [3.10 Strings](#s3.10-strings)
        +   [3.10.1 Logging](#s3.10.1-logging)
        +   [3.10.2 Error Messages](#s3.10.2-error-messages)
    *   [3.11 Files, Sockets, and similar Stateful Resources](#s3.11-files-sockets-closeables)
    *   [3.12 TODO Comments](#s3.12-todo-comments)
    *   [3.13 Imports formatting](#s3.13-imports-formatting)
    *   [3.14 Statements](#s3.14-statements)
    *   [3.15 Accessors](#s3.15-accessors)
    *   [3.16 Naming](#s3.16-naming)
        +   [3.16.1 Names to Avoid](#s3.16.1-names-to-avoid)
        +   [3.16.2 Naming Conventions](#s3.16.2-naming-conventions)
        +   [3.16.3 File Naming](#s3.16.3-file-naming)
        +   [3.16.4 Guidelines derived from Guido's Recommendations](#s3.16.4-guidelines-derived-from-guidos-recommendations)
    *   [3.17 Main](#s3.17-main)
    *   [3.18 Function length](#s3.18-function-length)
    *   [3.19 Type Annotations](#s3.19-type-annotations)
        +   [3.19.1 General Rules](#s3.19.1-general-rules)
        +   [3.19.2 Line Breaking](#s3.19.2-line-breaking)
        +   [3.19.3 Forward Declarations](#s3.19.3-forward-declarations)
        +   [3.19.4 Default Values](#s3.19.4-default-values)
        +   [3.19.5 NoneType](#s3.19.5-nonetype)
        +   [3.19.6 Type Aliases](#s3.19.6-type-aliases)
        +   [3.19.7 Ignoring Types](#s3.19.7-ignoring-types)
        +   [3.19.8 Typing Variables](#s3.19.8-typing-variables)
        +   [3.19.9 Tuples vs Lists](#s3.19.9-tuples-vs-lists)
        +   [3.19.10 Type variables](#s3.19.10-typevars)
        +   [3.19.11 String types](#s3.19.11-string-types)
        +   [3.19.12 Imports For Typing](#s3.19.12-imports-for-typing)
        +   [3.19.13 Conditional Imports](#s3.19.13-conditional-imports)
        +   [3.19.14 Circular Dependencies](#s3.19.14-circular-dependencies)
        +   [3.19.15 Generics](#s3.19.15-generics)
        +   [3.19.16 Build Dependencies](#s3.19.16-build-dependencies)
-   [4 Parting Words](#4-parting-words)

</details>

<a id="s1-background"></a>
<a id="1-background"></a>

<a id="background"></a>
## 1 Background 

Python is the main dynamic language used at Google. This style guide is a list
of *dos and don'ts* for Python programs.

To help you format code correctly, we've created a [settings file for Vim](google_python_style.vim). For Emacs, the default settings should be fine.

Many teams use the [Black](https://github.com/psf/black) or [Pyink](https://github.com/google/pyink)
auto-formatter to avoid arguing over formatting.


<a id="s2-python-language-rules"></a>
<a id="2-python-language-rules"></a>

<a id="python-language-rules"></a>
## 2 Python Language Rules 

<a id="s2.1-lint"></a>
<a id="21-lint"></a>

<a id="lint"></a>
### 2.1 Lint 

Run `pylint` over your code using this [pylintrc](https://google.github.io/styleguide/pylintrc).

<a id="s2.1.1-definition"></a>
<a id="211-definition"></a>

<a id="lint-definition"></a>
#### 2.1.1 Definition 

`pylint`
is a tool for finding bugs and style problems in Python source code. It finds
problems that are typically caught by a compiler for less dynamic languages like
C and C++. Because of the dynamic nature of Python, some
warnings may be incorrect; however, spurious warnings should be fairly
infrequent.

<a id="s2.1.2-pros"></a>
<a id="212-pros"></a>

<a id="lint-pros"></a>
#### 2.1.2 Pros 

Catches easy-to-miss errors like typos, using-vars-before-assignment, etc.

<a id="s2.1.3-cons"></a>
<a id="213-cons"></a>

<a id="lint-cons"></a>
#### 2.1.3 Cons 

`pylint`
isn't perfect. To take advantage of it, sometimes we'll need to write around it,
suppress its warnings or fix it.

<a id="s2.1.4-decision"></a>
<a id="214-decision"></a>

<a id="lint-decision"></a>
#### 2.1.4 Decision 

Make sure you run
`pylint`
on your code.


Suppress warnings if they are inappropriate so that other issues are not hidden.
To suppress warnings, you can set a line-level comment:

```python
def do_PUT(self):  # WSGI name, so pylint: disable=invalid-name
  ...
```

`pylint`
warnings are each identified by symbolic name (`empty-docstring`)
Google-specific warnings start with `g-`.

If the reason for the suppression is not clear from the symbolic name, add an
explanation.

Suppressing in this way has the advantage that we can easily search for
suppressions and revisit them.

You can get a list of
`pylint`
warnings by doing:

```shell
pylint --list-msgs
```

To get more information on a particular message, use:

```shell
pylint --help-msg=invalid-name
```

Prefer `pylint: disable` to the deprecated older form `pylint: disable-msg`.

Unused argument warnings can be suppressed by deleting the variables at the
beginning of the function. Always include a comment explaining why you are
deleting it. "Unused." is sufficient. For example:

```python
def viking_cafe_order(spam: str, beans: str, eggs: str | None = None) -> str:
    del beans, eggs  # Unused by vikings.
    return spam + spam + spam
```

Other common forms of suppressing this warning include using '`_`' as the
identifier for the unused argument or prefixing the argument name with
'`unused_`', or assigning them to '`_`'. These forms are allowed but no longer
encouraged. These break callers that pass arguments by name and do not enforce
that the arguments are actually unused.

<a id="s2.2-imports"></a>
<a id="22-imports"></a>

<a id="imports"></a>
### 2.2 Imports 

Use `import` statements for packages and modules only, not for individual types,
classes, or functions.

<a id="s2.2.1-definition"></a>
<a id="221-definition"></a>

<a id="imports-definition"></a>
#### 2.2.1 Definition 

Reusability mechanism for sharing code from one module to another.

<a id="s2.2.2-pros"></a>
<a id="222-pros"></a>

<a id="imports-pros"></a>
#### 2.2.2 Pros 

The namespace management convention is simple. The source of each identifier is
indicated in a consistent way; `x.Obj` says that object `Obj` is defined in
module `x`.

<a id="s2.2.3-cons"></a>
<a id="223-cons"></a>

<a id="imports-cons"></a>
#### 2.2.3 Cons 

Module names can still collide. Some module names are inconveniently long.

<a id="s2.2.4-decision"></a>
<a id="224-decision"></a>

<a id="imports-decision"></a>
#### 2.2.4 Decision 

*   Use `import x` for importing packages and modules.
*   Use `from x import y` where `x` is the package prefix and `y` is the module
    name with no prefix.
*   Use `from x import y as z` in any of the following circumstances:
    -   Two modules named `y` are to be imported.
    -   `y` conflicts with a top-level name defined in the current module.
    -   `y` conflicts with a common parameter name that is part of the public
        API (e.g., `features`).
    -   `y` is an inconveniently long name.
    -   `y` is too generic in the context of your code (e.g., `from
        storage.file_system import options as fs_options`).
*   Use `import y as z` only when `z` is a standard abbreviation (e.g., `import
    numpy as np`).

For example the module `sound.effects.echo` may be imported as follows:

```python
from sound.effects import echo
...
echo.EchoFilter(input, output, delay=0.7, atten=4)
```

Do not use relative names in imports. Even if the module is in the same package,
use the full package name. This helps prevent unintentionally importing a
package twice.

<a id="imports-exemptions"></a>
##### 2.2.4.1 Exemptions 

Exemptions from this rule:

*   Symbols from the following modules are used to support static analysis and
    type checking:
    *   [`typing` module](#typing-imports)
    *   [`collections.abc` module](#typing-imports)
    *   [`typing_extensions` module](https://github.com/python/typing_extensions/blob/main/README.md)
*   Redirects from the
    [six.moves module](https://six.readthedocs.io/#module-six.moves).

<a id="s2.3-packages"></a>
<a id="23-packages"></a>

<a id="packages"></a>
### 2.3 Packages 

Import each module using the full pathname location of the module.

<a id="s2.3.1-pros"></a>
<a id="231-pros"></a>

<a id="packages-pros"></a>
#### 2.3.1 Pros 

Avoids conflicts in module names or incorrect imports due to the module search
path not being what the author expected. Makes it easier to find modules.

<a id="s2.3.2-cons"></a>
<a id="232-cons"></a>

<a id="packages-cons"></a>
#### 2.3.2 Cons 

Makes it harder to deploy code because you have to replicate the package
hierarchy. Not really a problem with modern deployment mechanisms.

<a id="s2.3.3-decision"></a>
<a id="233-decision"></a>

<a id="packages-decision"></a>
#### 2.3.3 Decision 

All new code should import each module by its full package name.

Imports should be as follows:

```python
Yes:
  # Reference absl.flags in code with the complete name (verbose).
  import absl.flags
  from doctor.who import jodie

  _FOO = absl.flags.DEFINE_string(...)
```

```python
Yes:
  # Reference flags in code with just the module name (common).
  from absl import flags
  from doctor.who import jodie

  _FOO = flags.DEFINE_string(...)
```

*(assume this file lives in `doctor/who/` where `jodie.py` also exists)*

```python
No:
  # Unclear what module the author wanted and what will be imported.  The actual
  # import behavior depends on external factors controlling sys.path.
  # Which possible jodie module did the author intend to import?
  import jodie
```

The directory the main binary is located in should not be assumed to be in
`sys.path` despite that happening in some environments. This being the case,
code should assume that `import jodie` refers to a third-party or top-level
package named `jodie`, not a local `jodie.py`.


<a id="s2.4-exceptions"></a>
<a id="24-exceptions"></a>

<a id="exceptions"></a>
### 2.4 Exceptions 

Exceptions are allowed but must be used carefully.

<a id="s2.4.1-definition"></a>
<a id="241-definition"></a>

<a id="exceptions-definition"></a>
#### 2.4.1 Definition 

Exceptions are a means of breaking out of normal control flow to handle errors
or other exceptional conditions.

<a id="s2.4.2-pros"></a>
<a id="242-pros"></a>

<a id="exceptions-pros"></a>
#### 2.4.2 Pros 

The control flow of normal operation code is not cluttered by error-handling
code. It also allows the control flow to skip multiple frames when a certain
condition occurs, e.g., returning from N nested functions in one step instead of
having to plumb error codes through.

<a id="s2.4.3-cons"></a>
<a id="243-cons"></a>

<a id="exceptions-cons"></a>
#### 2.4.3 Cons 

May cause the control flow to be confusing. Easy to miss error cases when making
library calls.

<a id="s2.4.4-decision"></a>
<a id="244-decision"></a>

<a id="exceptions-decision"></a>
#### 2.4.4 Decision 

Exceptions must follow certain conditions:

-   Make use of built-in exception classes when it makes sense. For example,
    raise a `ValueError` to indicate a programming mistake like a violated
    precondition, such as may happen when validating function arguments.

-   Do not use `assert` statements in place of conditionals or validating
    preconditions. They must not be critical to the application logic. A litmus
    test would be that the `assert` could be removed without breaking the code.
    `assert` conditionals are
    [not guaranteed](https://docs.python.org/3/reference/simple_stmts.html#the-assert-statement)
    to be evaluated. For [pytest](https://pytest.org) based tests, `assert` is
    okay and expected to verify expectations. For
    example:

    
    ```python
    Yes:
      def connect_to_next_port(self, minimum: int) -> int:
        """Connects to the next available port.

        Args:
          minimum: A port value greater or equal to 1024.

        Returns:
          The new minimum port.

        Raises:
          ConnectionError: If no available port is found.
        """
        if minimum < 1024:
          # Note that this raising of ValueError is not mentioned in the doc
          # string's "Raises:" section because it is not appropriate to
          # guarantee this specific behavioral reaction to API misuse.
          raise ValueError(f'Min. port must be at least 1024, not {minimum}.')
        port = self._find_next_open_port(minimum)
        if port is None:
          raise ConnectionError(
              f'Could not connect to service on port {minimum} or higher.')
        # The code does not depend on the result of this assert.
        assert port >= minimum, (
            f'Unexpected port {port} when minimum was {minimum}.')
        return port
    ```

    ```python
    No:
      def connect_to_next_port(self, minimum: int) -> int:
        """Connects to the next available port.

        Args:
          minimum: A port value greater or equal to 1024.

        Returns:
          The new minimum port.
        """
        assert minimum >= 1024, 'Minimum port must be at least 1024.'
        # The following code depends on the previous assert.
        port = self._find_next_open_port(minimum)
        assert port is not None
        # The type checking of the return statement relies on the assert.
        return port
    ```


-   Libraries or packages may define their own exceptions. When doing so they
    must inherit from an existing exception class. Exception names should end in
    `Error` and should not introduce repetition (`foo.FooError`).

-   Never use catch-all `except:` statements, or catch `Exception` or
    `StandardError`, unless you are

    -   re-raising the exception, or
    -   creating an isolation point in the program where exceptions are not
        propagated but are recorded and suppressed instead, such as protecting a
        thread from crashing by guarding its outermost block.

    Python is very tolerant in this regard and `except:` will really catch
    everything including misspelled names, sys.exit() calls, Ctrl+C interrupts,
    unittest failures and all kinds of other exceptions that you simply don't
    want to catch.

-   Minimize the amount of code in a `try`/`except` block. The larger the body
    of the `try`, the more likely that an exception will be raised by a line of
    code that you didn't expect to raise an exception. In those cases, the
    `try`/`except` block hides a real error.

-   Use the `finally` clause to execute code whether or not an exception is
    raised in the `try` block. This is often useful for cleanup, i.e., closing a
    file.

<a id="s2.5-global-variables"></a>
<a id="25-global-variables"></a>
<a id="s2.5-global-state"></a>
<a id="25-global-state"></a>

<a id="global-variables"></a>
### 2.5 Mutable Global State 

Avoid mutable global state.

<a id="s2.5.1-definition"></a>
<a id="251-definition"></a>

<a id="global-variables-definition"></a>
#### 2.5.1 Definition 

Module-level values or class attributes that can get mutated during program
execution.

<a id="s2.5.2-pros"></a>
<a id="252-pros"></a>

<a id="global-variables-pros"></a>
#### 2.5.2 Pros 

Occasionally useful.

<a id="s2.5.3-cons"></a>
<a id="253-cons"></a>

<a id="global-variables-cons"></a>
#### 2.5.3 Cons 

*   Breaks encapsulation: Such design can make it hard to achieve valid
    objectives. For example, if global state is used to manage a database
    connection, then connecting to two different databases at the same time
    (such as for computing differences during a migration) becomes difficult.
    Similar problems easily arise with global registries.

*   Has the potential to change module behavior during the import, because
    assignments to global variables are done when the module is first imported.

<a id="s2.5.4-decision"></a>
<a id="254-decision"></a>

<a id="global-variables-decision"></a>
#### 2.5.4 Decision 

Avoid mutable global state.

In those rare cases where using global state is warranted, mutable global
entities should be declared at the module level or as a class attribute and made
internal by prepending an `_` to the name. If necessary, external access to
mutable global state must be done through public functions or class methods. See
[Naming](#s3.16-naming) below. Please explain the design reasons why mutable
global state is being used in a comment or a doc linked to from a comment.

Module-level constants are permitted and encouraged. For example:
`_MAX_HOLY_HANDGRENADE_COUNT = 3` for an internal use constant or
`SIR_LANCELOTS_FAVORITE_COLOR = "blue"` for a public API constant. Constants
must be named using all caps with underscores. See [Naming](#s3.16-naming)
below.

<a id="s2.6-nested"></a>
<a id="26-nested"></a>

<a id="nested-classes-functions"></a>
### 2.6 Nested/Local/Inner Classes and Functions 

Nested local functions or classes are fine when used to close over a local
variable. Inner classes are fine.

<a id="s2.6.1-definition"></a>
<a id="261-definition"></a>

<a id="nested-classes-functions-definition"></a>
#### 2.6.1 Definition 

A class can be defined inside of a method, function, or class. A function can be
defined inside a method or function. Nested functions have read-only access to
variables defined in enclosing scopes.

<a id="s2.6.2-pros"></a>
<a id="262-pros"></a>

<a id="nested-classes-functions-pros"></a>
#### 2.6.2 Pros 

Allows definition of utility classes and functions that are only used inside of
a very limited scope. Very
[ADT](https://en.wikipedia.org/wiki/Abstract_data_type)-y. Commonly used for
implementing decorators.

<a id="s2.6.3-cons"></a>
<a id="263-cons"></a>

<a id="nested-classes-functions-cons"></a>
#### 2.6.3 Cons 

Nested functions and classes cannot be directly tested. Nesting can make the
outer function longer and less readable.

<a id="s2.6.4-decision"></a>
<a id="264-decision"></a>

<a id="nested-classes-functions-decision"></a>
#### 2.6.4 Decision 

They are fine with some caveats. Avoid nested functions or classes except when
closing over a local value other than `self` or `cls`. Do not nest a function
just to hide it from users of a module. Instead, prefix its name with an \_ at
the module level so that it can still be accessed by tests.

<a id="s2.7-comprehensions"></a>
<a id="s2.7-list_comprehensions"></a>
<a id="27-list_comprehensions"></a>
<a id="list_comprehensions"></a>
<a id="list-comprehensions"></a>

<a id="comprehensions"></a>
### 2.7 Comprehensions & Generator Expressions 

Okay to use for simple cases.

<a id="s2.7.1-definition"></a>
<a id="271-definition"></a>

<a id="comprehensions-definition"></a>
#### 2.7.1 Definition 

List, Dict, and Set comprehensions as well as generator expressions provide a
concise and efficient way to create container types and iterators without
resorting to the use of traditional loops, `map()`, `filter()`, or `lambda`.

<a id="s2.7.2-pros"></a>
<a id="272-pros"></a>

<a id="comprehensions-pros"></a>
#### 2.7.2 Pros 

Simple comprehensions can be clearer and simpler than other dict, list, or set
creation techniques. Generator expressions can be very efficient, since they
avoid the creation of a list entirely.

<a id="s2.7.3-cons"></a>
<a id="273-cons"></a>

<a id="comprehensions-cons"></a>
#### 2.7.3 Cons 

Complicated comprehensions or generator expressions can be hard to read.

<a id="s2.7.4-decision"></a>
<a id="274-decision"></a>

<a id="comprehensions-decision"></a>
#### 2.7.4 Decision 

Comprehensions are allowed, however multiple `for` clauses or filter expressions
are not permitted. Optimize for readability, not conciseness.

```python
Yes:
  result = [mapping_expr for value in iterable if filter_expr]

  result = [
      is_valid(metric={'key': value})
      for value in interesting_iterable
      if a_longer_filter_expression(value)
  ]

  descriptive_name = [
      transform({'key': key, 'value': value}, color='black')
      for key, value in generate_iterable(some_input)
      if complicated_condition_is_met(key, value)
  ]

  result = []
  for x in range(10):
    for y in range(5):
      if x * y > 10:
        result.append((x, y))

  return {
      x: complicated_transform(x)
      for x in long_generator_function(parameter)
      if x is not None
  }

  return (x**2 for x in range(10))

  unique_names = {user.name for user in users if user is not None}
```

```python
No:
  result = [(x, y) for x in range(10) for y in range(5) if x * y > 10]

  return (
      (x, y, z)
      for x in range(5)
      for y in range(5)
      if x != y
      for z in range(5)
      if y != z
  )
```

<a id="s2.8-default-iterators-and-operators"></a>

<a id="default-iterators-operators"></a>
### 2.8 Default Iterators and Operators 

Use default iterators and operators for types that support them, like lists,
dictionaries, and files.

<a id="s2.8.1-definition"></a>
<a id="281-definition"></a>

<a id="default-iterators-operators-definition"></a>
#### 2.8.1 Definition 

Container types, like dictionaries and lists, define default iterators and
membership test operators ("in" and "not in").

<a id="s2.8.2-pros"></a>
<a id="282-pros"></a>

<a id="default-iterators-operators-pros"></a>
#### 2.8.2 Pros 

The default iterators and operators are simple and efficient. They express the
operation directly, without extra method calls. A function that uses default
operators is generic. It can be used with any type that supports the operation.

<a id="s2.8.3-cons"></a>
<a id="283-cons"></a>

<a id="default-iterators-operators-cons"></a>
#### 2.8.3 Cons 

You can't tell the type of objects by reading the method names (unless the
variable has type annotations). This is also an advantage.

<a id="s2.8.4-decision"></a>
<a id="284-decision"></a>

<a id="default-iterators-operators-decision"></a>
#### 2.8.4 Decision 

Use default iterators and operators for types that support them, like lists,
dictionaries, and files. The built-in types define iterator methods, too. Prefer
these methods to methods that return lists, except that you should not mutate a
container while iterating over it.

```python
Yes:  for key in adict: ...
      if obj in alist: ...
      for line in afile: ...
      for k, v in adict.items(): ...
```

```python
No:   for key in adict.keys(): ...
      for line in afile.readlines(): ...
```

<a id="s2.9-generators"></a>
<a id="29-generators"></a>

<a id="generators"></a>
### 2.9 Generators 

Use generators as needed.

<a id="s2.9.1-definition"></a>
<a id="291-definition"></a>

<a id="generators-definition"></a>
#### 2.9.1 Definition 

A generator function returns an iterator that yields a value each time it
executes a yield statement. After it yields a value, the runtime state of the
generator function is suspended until the next value is needed.

<a id="s2.9.2-pros"></a>
<a id="292-pros"></a>

<a id="generators-pros"></a>
#### 2.9.2 Pros 

Simpler code, because the state of local variables and control flow are
preserved for each call. A generator uses less memory than a function that
creates an entire list of values at once.

<a id="s2.9.3-cons"></a>
<a id="293-cons"></a>

<a id="generators-cons"></a>
#### 2.9.3 Cons 

Local variables in the generator will not be garbage collected until the
generator is either consumed to exhaustion or itself garbage collected.

<a id="s2.9.4-decision"></a>
<a id="294-decision"></a>

<a id="generators-decision"></a>
#### 2.9.4 Decision 

Fine. Use "Yields:" rather than "Returns:" in the docstring for generator
functions.

If the generator manages an expensive resource, make sure to force the clean up.

A good way to do the clean up is by wrapping the generator with a context
manager [PEP-0533](https://peps.python.org/pep-0533/).

<a id="s2.10-lambda-functions"></a>
<a id="210-lambda-functions"></a>

<a id="lambdas"></a>
### 2.10 Lambda Functions 

Okay for one-liners. Prefer generator expressions over `map()` or `filter()`
with a `lambda`.

<a id="s2.10.1-definition"></a>
<a id="2101-definition"></a>

<a id="lambdas-definition"></a>
#### 2.10.1 Definition 

Lambdas define anonymous functions in an expression, as opposed to a statement.

<a id="s2.10.2-pros"></a>
<a id="2102-pros"></a>

<a id="lambdas-pros"></a>
#### 2.10.2 Pros 

Convenient.

<a id="s2.10.3-cons"></a>
<a id="2103-cons"></a>

<a id="lambdas-cons"></a>
#### 2.10.3 Cons 

Harder to read and debug than local functions. The lack of names means stack
traces are more difficult to understand. Expressiveness is limited because the
function may only contain an expression.

<a id="s2.10.4-decision"></a>
<a id="2104-decision"></a>

<a id="lambdas-decision"></a>
#### 2.10.4 Decision 

Lambdas are allowed. If the code inside the lambda function spans multiple lines
or is longer than 60-80 chars, it might be better to define it as a regular
[nested function](#lexical-scoping).

For common operations like multiplication, use the functions from the `operator`
module instead of lambda functions. For example, prefer `operator.mul` to
`lambda x, y: x * y`.

<a id="s2.11-conditional-expressions"></a>
<a id="211-conditional-expressions"></a>

<a id="conditional-expressions"></a>
### 2.11 Conditional Expressions 

Okay for simple cases.

<a id="s2.11.1-definition"></a>
<a id="2111-definition"></a>

<a id="conditional-expressions-definition"></a>
#### 2.11.1 Definition 

Conditional expressions (sometimes called a “ternary operator”) are mechanisms
that provide a shorter syntax for if statements. For example: `x = 1 if cond
else 2`.

<a id="s2.11.2-pros"></a>
<a id="2112-pros"></a>

<a id="conditional-expressions-pros"></a>
#### 2.11.2 Pros 

Shorter and more convenient than an if statement.

<a id="s2.11.3-cons"></a>
<a id="2113-cons"></a>

<a id="conditional-expressions-cons"></a>
#### 2.11.3 Cons 

May be harder to read than an if statement. The condition may be difficult to
locate if the expression is long.

<a id="s2.11.4-decision"></a>
<a id="2114-decision"></a>

<a id="conditional-expressions-decision"></a>
#### 2.11.4 Decision 

Okay to use for simple cases. Each portion must fit on one line:
true-expression, if-expression, else-expression. Use a complete if statement
when things get more complicated.

```python
Yes:
    one_line = 'yes' if predicate(value) else 'no'
    slightly_split = ('yes' if predicate(value)
                      else 'no, nein, nyet')
    the_longest_ternary_style_that_can_be_done = (
        'yes, true, affirmative, confirmed, correct'
        if predicate(value)
        else 'no, false, negative, nay')
```

```python
No:
    bad_line_breaking = ('yes' if predicate(value) else
                         'no')
    portion_too_long = ('yes'
                        if some_long_module.some_long_predicate_function(
                            really_long_variable_name)
                        else 'no, false, negative, nay')
```

<a id="s2.12-default-argument-values"></a>
<a id="212-default-argument-values"></a>

<a id="default-arguments"></a>
### 2.12 Default Argument Values 

Okay in most cases.

<a id="s2.12.1-definition"></a>
<a id="2121-definition"></a>

<a id="default-arguments-definition"></a>
#### 2.12.1 Definition 

You can specify values for variables at the end of a function's parameter list,
e.g., `def foo(a, b=0):`. If `foo` is called with only one argument, `b` is set
to 0. If it is called with two arguments, `b` has the value of the second
argument.

<a id="s2.12.2-pros"></a>
<a id="2122-pros"></a>

<a id="default-arguments-pros"></a>
#### 2.12.2 Pros 

Often you have a function that uses lots of default values, but on rare
occasions you want to override the defaults. Default argument values provide an
easy way to do this, without having to define lots of functions for the rare
exceptions. As Python does not support overloaded methods/functions, default
arguments are an easy way of "faking" the overloading behavior.

<a id="s2.12.3-cons"></a>
<a id="2123-cons"></a>

<a id="default-arguments-cons"></a>
#### 2.12.3 Cons 

Default arguments are evaluated once at module load time. This may cause
problems if the argument is a mutable object such as a list or a dictionary. If
the function modifies the object (e.g., by appending an item to a list), the
default value is modified.

<a id="s2.12.4-decision"></a>
<a id="2124-decision"></a>

<a id="default-arguments-decision"></a>
#### 2.12.4 Decision 

Okay to use with the following caveat:

Do not use mutable objects as default values in the function or method
definition.

```python
Yes: def foo(a, b=None):
         if b is None:
             b = []
Yes: def foo(a, b: Sequence | None = None):
         if b is None:
             b = []
Yes: def foo(a, b: Sequence = ()):  # Empty tuple OK since tuples are immutable.
         ...
```

```python
from absl import flags
_FOO = flags.DEFINE_string(...)

No:  def foo(a, b=[]):
         ...
No:  def foo(a, b=time.time()):  # Is `b` supposed to represent when this module was loaded?
         ...
No:  def foo(a, b=_FOO.value):  # sys.argv has not yet been parsed...
         ...
No:  def foo(a, b: Mapping = {}):  # Could still get passed to unchecked code.
         ...
```

<a id="s2.13-properties"></a>
<a id="213-properties"></a>

<a id="properties"></a>
### 2.13 Properties 

Properties may be used to control getting or setting attributes that require
trivial computations or logic. Property implementations must match the general
expectations of regular attribute access: that they are cheap, straightforward,
and unsurprising.

<a id="s2.13.1-definition"></a>
<a id="2131-definition"></a>

<a id="properties-definition"></a>
#### 2.13.1 Definition 

A way to wrap method calls for getting and setting an attribute as a standard
attribute access.

<a id="s2.13.2-pros"></a>
<a id="2132-pros"></a>

<a id="properties-pros"></a>
#### 2.13.2 Pros 

*   Allows for an attribute access and assignment API rather than
    [getter and setter](#getters-and-setters) method calls.
*   Can be used to make an attribute read-only.
*   Allows calculations to be lazy.
*   Provides a way to maintain the public interface of a class when the
    internals evolve independently of class users.

<a id="s2.13.3-cons"></a>
<a id="2133-cons"></a>

<a id="properties-cons"></a>
#### 2.13.3 Cons 

*   Can hide side-effects much like operator overloading.
*   Can be confusing for subclasses.

<a id="s2.13.4-decision"></a>
<a id="2134-decision"></a>

<a id="properties-decision"></a>
#### 2.13.4 Decision 

Properties are allowed, but, like operator overloading, should only be used when
necessary and match the expectations of typical attribute access; follow the
[getters and setters](#getters-and-setters) rules otherwise.

For example, using a property to simply both get and set an internal attribute
isn't allowed: there is no computation occurring, so the property is unnecessary
([make the attribute public instead](#getters-and-setters)). In comparison,
using a property to control attribute access or to calculate a *trivially*
derived value is allowed: the logic is simple and unsurprising.

Properties should be created with the `@property`
[decorator](#s2.17-function-and-method-decorators). Manually implementing a
property descriptor is considered a [power feature](#power-features).

Inheritance with properties can be non-obvious. Do not use properties to
implement computations a subclass may ever want to override and extend.

<a id="s2.14-truefalse-evaluations"></a>
<a id="214-truefalse-evaluations"></a>

<a id="truefalse-evaluations"></a>
### 2.14 True/False Evaluations 

Use the "implicit" false if at all possible (with a few caveats).

<a id="s2.14.1-definition"></a>
<a id="2141-definition"></a>

<a id="truefalse-evaluations-definition"></a>
#### 2.14.1 Definition 

Python evaluates certain values as `False` when in a boolean context. A quick
"rule of thumb" is that all "empty" values are considered false, so `0, None,
[], {}, ''` all evaluate as false in a boolean context.

<a id="s2.14.2-pros"></a>
<a id="2142-pros"></a>

<a id="truefalse-evaluations-pros"></a>
#### 2.14.2 Pros 

Conditions using Python booleans are easier to read and less error-prone. In
most cases, they're also faster.

<a id="s2.14.3-cons"></a>
<a id="2143-cons"></a>

<a id="truefalse-evaluations-cons"></a>
#### 2.14.3 Cons 

May look strange to C/C++ developers.

<a id="s2.14.4-decision"></a>
<a id="2144-decision"></a>

<a id="truefalse-evaluations-decision"></a>
#### 2.14.4 Decision 

Use the "implicit" false if possible, e.g., `if foo:` rather than `if foo !=
[]:`. There are a few caveats that you should keep in mind though:

-   Always use `if foo is None:` (or `is not None`) to check for a `None` value.
    E.g., when testing whether a variable or argument that defaults to `None`
    was set to some other value. The other value might be a value that's false
    in a boolean context!

-   Never compare a boolean variable to `False` using `==`. Use `if not x:`
    instead. If you need to distinguish `False` from `None` then chain the
    expressions, such as `if not x and x is not None:`.

-   For sequences (strings, lists, tuples), use the fact that empty sequences
    are false, so `if seq:` and `if not seq:` are preferable to `if len(seq):`
    and `if not len(seq):` respectively.

-   When handling integers, implicit false may involve more risk than benefit
    (i.e., accidentally handling `None` as 0). You may compare a value which is
    known to be an integer (and is not the result of `len()`) against the
    integer 0.

    ```python
    Yes: if not users:
             print('no users')

         if i % 10 == 0:
             self.handle_multiple_of_ten()

         def f(x=None):
             if x is None:
                 x = []
    ```

    ```python
    No:  if len(users) == 0:
             print('no users')

         if not i % 10:
             self.handle_multiple_of_ten()

         def f(x=None):
             x = x or []
    ```

-   Note that `'0'` (i.e., `0` as string) evaluates to true.

-   Note that Numpy arrays may raise an exception in an implicit boolean
    context. Prefer the `.size` attribute when testing emptiness of a `np.array`
    (e.g. `if not users.size`).

<a id="s2.16-lexical-scoping"></a>
<a id="216-lexical-scoping"></a>

<a id="lexical-scoping"></a>
### 2.16 Lexical Scoping 

Okay to use.

<a id="s2.16.1-definition"></a>
<a id="2161-definition"></a>

<a id="lexical-scoping-definition"></a>
#### 2.16.1 Definition 

A nested Python function can refer to variables defined in enclosing functions,
but cannot assign to them. Variable bindings are resolved using lexical scoping,
that is, based on the static program text. Any assignment to a name in a block
will cause Python to treat all references to that name as a local variable, even
if the use precedes the assignment. If a global declaration occurs, the name is
treated as a global variable.

An example of the use of this feature is:

```python
def get_adder(summand1: float) -> Callable[[float], float]:
    """Returns a function that adds numbers to a given number."""
    def adder(summand2: float) -> float:
        return summand1 + summand2

    return adder
```

<a id="s2.16.2-pros"></a>
<a id="2162-pros"></a>

<a id="lexical-scoping-pros"></a>
#### 2.16.2 Pros 

Often results in clearer, more elegant code. Especially comforting to
experienced Lisp and Scheme (and Haskell and ML and ...) programmers.

<a id="s2.16.3-cons"></a>
<a id="2163-cons"></a>

<a id="lexical-scoping-cons"></a>
#### 2.16.3 Cons 

Can lead to confusing bugs, such as this example based on
[PEP-0227](https://peps.python.org/pep-0227/):

```python
i = 4
def foo(x: Iterable[int]):
    def bar():
        print(i, end='')
    # ...
    # A bunch of code here
    # ...
    for i in x:  # Ah, i *is* local to foo, so this is what bar sees
        print(i, end='')
    bar()
```

So `foo([1, 2, 3])` will print `1 2 3 3`,
not `1 2 3 4`.

<a id="s2.16.4-decision"></a>
<a id="2164-decision"></a>

<a id="lexical-scoping-decision"></a>
#### 2.16.4 Decision 

Okay to use.

<a id="s2.17-function-and-method-decorators"></a>
<a id="217-function-and-method-decorators"></a>
<a id="function-and-method-decorators"></a>

<a id="decorators"></a>
### 2.17 Function and Method Decorators 

Use decorators judiciously when there is a clear advantage. Avoid `staticmethod`
and limit use of `classmethod`.

<a id="s2.17.1-definition"></a>
<a id="2171-definition"></a>

<a id="decorators-definition"></a>
#### 2.17.1 Definition 

[Decorators for Functions and Methods](https://docs.python.org/3/glossary.html#term-decorator)
(a.k.a "the `@` notation"). One common decorator is `@property`, used for
converting ordinary methods into dynamically computed attributes. However, the
decorator syntax allows for user-defined decorators as well. Specifically, for
some function `my_decorator`, this:

```python
class C:
    @my_decorator
    def method(self):
        # method body ...
```

is equivalent to:

```python
class C:
    def method(self):
        # method body ...
    method = my_decorator(method)
```

<a id="s2.17.2-pros"></a>
<a id="2172-pros"></a>

<a id="decorators-pros"></a>
#### 2.17.2 Pros 

Elegantly specifies some transformation on a method; the transformation might
eliminate some repetitive code, enforce invariants, etc.

<a id="s2.17.3-cons"></a>
<a id="2173-cons"></a>

<a id="decorators-cons"></a>
#### 2.17.3 Cons 

Decorators can perform arbitrary operations on a function's arguments or return
values, resulting in surprising implicit behavior. Additionally, decorators
execute at object definition time. For module-level objects (classes, module
functions, ...) this happens at import time. Failures in decorator code are
pretty much impossible to recover from.

<a id="s2.17.4-decision"></a>
<a id="2174-decision"></a>

<a id="decorators-decision"></a>
#### 2.17.4 Decision 

Use decorators judiciously when there is a clear advantage. Decorators should
follow the same import and naming guidelines as functions. A decorator docstring
should clearly state that the function is a decorator. Write unit tests for
decorators.

Avoid external dependencies in the decorator itself (e.g. don't rely on files,
sockets, database connections, etc.), since they might not be available when the
decorator runs (at import time, perhaps from `pydoc` or other tools). A
decorator that is called with valid parameters should (as much as possible) be
guaranteed to succeed in all cases.

Decorators are a special case of "top-level code" - see [main](#s3.17-main) for
more discussion.

Never use `staticmethod` unless forced to in order to integrate with an API
defined in an existing library. Write a module-level function instead.

Use `classmethod` only when writing a named constructor, or a class-specific
routine that modifies necessary global state such as a process-wide cache.

<a id="s2.18-threading"></a>
<a id="218-threading"></a>

<a id="threading"></a>
### 2.18 Threading 

Do not rely on the atomicity of built-in types.

While Python's built-in data types such as dictionaries appear to have atomic
operations, there are corner cases where they aren't atomic (e.g. if `__hash__`
or `__eq__` are implemented as Python methods) and their atomicity should not be
relied upon. Neither should you rely on atomic variable assignment (since this
in turn depends on dictionaries).

Use the `queue` module's `Queue` data type as the preferred way to communicate
data between threads. Otherwise, use the `threading` module and its locking
primitives. Prefer condition variables and `threading.Condition` instead of
using lower-level locks.

<a id="s2.19-power-features"></a>
<a id="219-power-features"></a>

<a id="power-features"></a>
### 2.19 Power Features 

Avoid these features.

<a id="s2.19.1-definition"></a>
<a id="2191-definition"></a>

<a id="power-features-definition"></a>
#### 2.19.1 Definition 

Python is an extremely flexible language and gives you many fancy features such
as custom metaclasses, access to bytecode, on-the-fly compilation, dynamic
inheritance, object reparenting, import hacks, reflection (e.g. some uses of
`getattr()`), modification of system internals, `__del__` methods implementing
customized cleanup, etc.

<a id="s2.19.2-pros"></a>
<a id="2192-pros"></a>

<a id="power-features-pros"></a>
#### 2.19.2 Pros 

These are powerful language features. They can make your code more compact.

<a id="s2.19.3-cons"></a>
<a id="2193-cons"></a>

<a id="power-features-cons"></a>
#### 2.19.3 Cons 

It's very tempting to use these "cool" features when they're not absolutely
necessary. It's harder to read, understand, and debug code that's using unusual
features underneath. It doesn't seem that way at first (to the original author),
but when revisiting the code, it tends to be more difficult than code that is
longer but is straightforward.

<a id="s2.19.4-decision"></a>
<a id="2194-decision"></a>

<a id="power-features-decision"></a>
#### 2.19.4 Decision 

Avoid these features in your code.

Standard library modules and classes that internally use these features are okay
to use (for example, `abc.ABCMeta`, `dataclasses`, and `enum`).

<a id="s2.20-modern-python"></a>
<a id="220-modern-python"></a>

<a id="modern-python"></a>
### 2.20 Modern Python: from \_\_future\_\_ imports 

New language version semantic changes may be gated behind a special future
import to enable them on a per-file basis within earlier runtimes.

<a id="s2.20.1-definition"></a>
<a id="2201-definition"></a>

<a id="modern-python-definition"></a>
#### 2.20.1 Definition 

Being able to turn on some of the more modern features via `from __future__
import` statements allows early use of features from expected future Python
versions.

<a id="s2.20.2-pros"></a>
<a id="2202-pros"></a>

<a id="modern-python-pros"></a>
#### 2.20.2 Pros 

This has proven to make runtime version upgrades smoother as changes can be made
on a per-file basis while declaring compatibility and preventing regressions
within those files. Modern code is more maintainable as it is less likely to
accumulate technical debt that will be problematic during future runtime
upgrades.

<a id="s2.20.3-cons"></a>
<a id="2203-cons"></a>

<a id="modern-python-cons"></a>
#### 2.20.3 Cons 

Such code may not work on very old interpreter versions prior to the
introduction of the needed future statement. The need for this is more common in
projects supporting an extremely wide variety of environments.

<a id="s2.20.4-decision"></a>
<a id="2204-decision"></a>

<a id="modern-python-decision"></a>
#### 2.20.4 Decision 

##### from \_\_future\_\_ imports

Use of `from __future__ import` statements is encouraged. It allows a given
source file to start using more modern Python syntax features today. Once you no
longer need to run on a version where the features are hidden behind a
`__future__` import, feel free to remove those lines.

In code that may execute on versions as old as 3.5 rather than >= 3.7, import:

```python
from __future__ import generator_stop
```

For more information read the
[Python future statement definitions](https://docs.python.org/3/library/__future__.html)
documentation.

Please don't remove these imports until you are confident the code is only ever
used in a sufficiently modern environment. Even if you do not currently use the
feature a specific future import enables in your code today, keeping it in place
in the file prevents later modifications of the code from inadvertently
depending on the older behavior.

Use other `from __future__` import statements as you see fit.

<a id="s2.21-type-annotated-code"></a>
<a id="s2.21-typed-code"></a>
<a id="221-type-annotated-code"></a>
<a id="typed-code"></a>

<a id="typed-code"></a>
### 2.21 Type Annotated Code 

You can annotate Python code with
[type hints](https://docs.python.org/3/library/typing.html). Type-check the code
at build time with a type checking tool like [pytype](https://github.com/google/pytype).
In most cases, when feasible, type annotations are in source files. For
third-party or extension modules, annotations can be in
[stub `.pyi` files](https://peps.python.org/pep-0484/#stub-files).


<a id="s2.21.1-definition"></a>
<a id="2211-definition"></a>

<a id="typed-code-definition"></a>
#### 2.21.1 Definition 

Type annotations (or "type hints") are for function or method arguments and
return values:

```python
def func(a: int) -> list[int]:
```

You can also declare the type of a variable using similar syntax:

```python
a: SomeType = some_func()
```

<a id="s2.21.2-pros"></a>
<a id="2212-pros"></a>

<a id="typed-code-pros"></a>
#### 2.21.2 Pros 

Type annotations improve the readability and maintainability of your code. The
type checker will convert many runtime errors to build-time errors, and reduce
your ability to use [Power Features](#power-features).

<a id="s2.21.3-cons"></a>
<a id="2213-cons"></a>

<a id="typed-code-cons"></a>
#### 2.21.3 Cons 

You will have to keep the type declarations up to date.
You might see type errors that you think are
valid code. Use of a
[type checker](https://github.com/google/pytype)
may reduce your ability to use [Power Features](#power-features).

<a id="s2.21.4-decision"></a>
<a id="2214-decision"></a>

<a id="typed-code-decision"></a>
#### 2.21.4 Decision 

You are strongly encouraged to enable Python type analysis when updating code.
When adding or modifying public APIs, include type annotations and enable
checking via pytype in the build system. As static analysis is relatively new to
Python, we acknowledge that undesired side-effects (such as
wrongly
inferred types) may prevent adoption by some projects. In those situations,
authors are encouraged to add a comment with a TODO or link to a bug describing
the issue(s) currently preventing type annotation adoption in the BUILD file or
in the code itself as appropriate.

<a id="s3-python-style-rules"></a>
<a id="3-python-style-rules"></a>

<a id="python-style-rules"></a>
## 3 Python Style Rules 

<a id="s3.1-semicolons"></a>
<a id="31-semicolons"></a>

<a id="semicolons"></a>
### 3.1 Semicolons 

Do not terminate your lines with semicolons, and do not use semicolons to put
two statements on the same line.

<a id="s3.2-line-length"></a>
<a id="32-line-length"></a>

<a id="line-length"></a>
### 3.2 Line length 

Maximum line length is *80 characters*.

Explicit exceptions to the 80 character limit:

-   Long import statements.
-   URLs, pathnames, or long flags in comments.
-   Long string module-level constants not containing whitespace that would be
    inconvenient to split across lines such as URLs or pathnames.
    -   Pylint disable comments. (e.g.: `# pylint: disable=invalid-name`)

Do not use a backslash for
[explicit line continuation](https://docs.python.org/3/reference/lexical_analysis.html#explicit-line-joining).

Instead, make use of Python's
[implicit line joining inside parentheses, brackets and braces](http://docs.python.org/reference/lexical_analysis.html#implicit-line-joining).
If necessary, you can add an extra pair of parentheses around an expression.

Note that this rule doesn't prohibit backslash-escaped newlines within strings
(see [below](#strings)).

```python
Yes: foo_bar(self, width, height, color='black', design=None, x='foo',
             emphasis=None, highlight=0)
```

```python

Yes: if (width == 0 and height == 0 and
         color == 'red' and emphasis == 'strong'):

     (bridge_questions.clarification_on
      .average_airspeed_of.unladen_swallow) = 'African or European?'

     with (
         very_long_first_expression_function() as spam,
         very_long_second_expression_function() as beans,
         third_thing() as eggs,
     ):
       place_order(eggs, beans, spam, beans)
```

```python

No:  if width == 0 and height == 0 and \
         color == 'red' and emphasis == 'strong':

     bridge_questions.clarification_on \
         .average_airspeed_of.unladen_swallow = 'African or European?'

     with very_long_first_expression_function() as spam, \
           very_long_second_expression_function() as beans, \
           third_thing() as eggs:
       place_order(eggs, beans, spam, beans)
```

When a literal string won't fit on a single line, use parentheses for implicit
line joining.

```python
x = ('This will build a very long long '
     'long long long long long long string')
```

Prefer to break lines at the highest possible syntactic level. If you must break
a line twice, break it at the same syntactic level both times.

```python
Yes: bridgekeeper.answer(
         name="Arthur", quest=questlib.find(owner="Arthur", perilous=True))

     answer = (a_long_line().of_chained_methods()
               .that_eventually_provides().an_answer())

     if (
         config is None
         or 'editor.language' not in config
         or config['editor.language'].use_spaces is False
     ):
       use_tabs()
```

```python
No: bridgekeeper.answer(name="Arthur", quest=questlib.find(
        owner="Arthur", perilous=True))

    answer = a_long_line().of_chained_methods().that_eventually_provides(
        ).an_answer()

    if (config is None or 'editor.language' not in config or config[
        'editor.language'].use_spaces is False):
      use_tabs()

```

Within comments, put long URLs on their own line if necessary.

```python
Yes:  # See details at
      # http://www.example.com/us/developer/documentation/api/content/v2.0/csv_file_name_extension_full_specification.html
```

```python
No:  # See details at
     # http://www.example.com/us/developer/documentation/api/content/\
     # v2.0/csv_file_name_extension_full_specification.html
```

Make note of the indentation of the elements in the line continuation examples
above; see the [indentation](#s3.4-indentation) section for explanation.

[Docstring](#docstrings) summary lines must remain within the 80 character
limit.

In all other cases where a line exceeds 80 characters, and the
[Black](https://github.com/psf/black) or [Pyink](https://github.com/google/pyink)
auto-formatter does not help bring the line below the limit, the line is allowed
to exceed this maximum. Authors are encouraged to manually break the line up per
the notes above when it is sensible.

<a id="s3.3-parentheses"></a>
<a id="33-parentheses"></a>

<a id="parentheses"></a>
### 3.3 Parentheses 

Use parentheses sparingly.

It is fine, though not required, to use parentheses around tuples. Do not use
them in return statements or conditional statements unless using parentheses for
implied line continuation or to indicate a tuple.

```python
Yes: if foo:
         bar()
     while x:
         x = bar()
     if x and y:
         bar()
     if not x:
         bar()
     # For a 1 item tuple the ()s are more visually obvious than the comma.
     onesie = (foo,)
     return foo
     return spam, beans
     return (spam, beans)
     for (x, y) in dict.items(): ...
```

```python
No:  if (x):
         bar()
     if not(x):
         bar()
     return (foo)
```

<a id="s3.4-indentation"></a>
<a id="34-indentation"></a>

<a id="indentation"></a>
### 3.4 Indentation 

Indent your code blocks with *4 spaces*.

Never use tabs. Implied line continuation should align wrapped elements
vertically (see [line length examples](#s3.2-line-length)), or use a hanging
4-space indent. Closing (round, square or curly) brackets can be placed at the
end of the expression, or on separate lines, but then should be indented the
same as the line with the corresponding opening bracket.

```python
Yes:   # Aligned with opening delimiter.
       foo = long_function_name(var_one, var_two,
                                var_three, var_four)
       meal = (spam,
               beans)

       # Aligned with opening delimiter in a dictionary.
       foo = {
           'long_dictionary_key': value1 +
                                  value2,
           ...
       }

       # 4-space hanging indent; nothing on first line.
       foo = long_function_name(
           var_one, var_two, var_three,
           var_four)
       meal = (
           spam,
           beans)

       # 4-space hanging indent; nothing on first line,
       # closing parenthesis on a new line.
       foo = long_function_name(
           var_one, var_two, var_three,
           var_four
       )
       meal = (
           spam,
           beans,
       )

       # 4-space hanging indent in a dictionary.
       foo = {
           'long_dictionary_key':
               long_dictionary_value,
           ...
       }
```

```python
No:    # Stuff on first line forbidden.
       foo = long_function_name(var_one, var_two,
           var_three, var_four)
       meal = (spam,
           beans)

       # 2-space hanging indent forbidden.
       foo = long_function_name(
         var_one, var_two, var_three,
         var_four)

       # No hanging indent in a dictionary.
       foo = {
           'long_dictionary_key':
           long_dictionary_value,
           ...
       }
```

<a id="s3.4.1-trailing-comma"></a>
<a id="s3.4.1-trailing-commas"></a>
<a id="s3.4.1-trailing_comma"></a>
<a id="s3.4.1-trailing_commas"></a>
<a id="341-trailing_comma"></a>
<a id="341-trailing_commas"></a>
<a id="trailing_comma"></a>
<a id="trailing_commas"></a>

<a id="trailing-comma"></a>
#### 3.4.1 Trailing commas in sequences of items? 

Trailing commas in sequences of items are recommended only when the closing
container token `]`, `)`, or `}` does not appear on the same line as the final
element, as well as for tuples with a single element. The presence of a trailing
comma is also used as a hint to our Python code auto-formatter
[Black](https://github.com/psf/black) or [Pyink](https://github.com/google/pyink)
to direct it to auto-format the container of items to one item per line when the
`,` after the final element is present.

```python
Yes:   golomb3 = [0, 1, 3]
       golomb4 = [
           0,
           1,
           4,
           6,
       ]
```

```python
No:    golomb4 = [
           0,
           1,
           4,
           6,]
```

<a id="s3.5-blank-lines"></a>
<a id="35-blank-lines"></a>

<a id="blank-lines"></a>
### 3.5 Blank Lines 

Two blank lines between top-level definitions, be they function or class
definitions. One blank line between method definitions and between the docstring
of a `class` and the first method. No blank line following a `def` line. Use
single blank lines as you judge appropriate within functions or methods.

Blank lines need not be anchored to the definition. For example, related
comments immediately preceding function, class, and method definitions can make
sense. Consider if your comment might be more useful as part of the docstring.

<a id="s3.6-whitespace"></a>
<a id="36-whitespace"></a>

<a id="whitespace"></a>
### 3.6 Whitespace 

Follow standard typographic rules for the use of spaces around punctuation.

No whitespace inside parentheses, brackets or braces.

```python
Yes: spam(ham[1], {'eggs': 2}, [])
```

```python
No:  spam( ham[ 1 ], { 'eggs': 2 }, [ ] )
```

No whitespace before a comma, semicolon, or colon. Do use whitespace after a
comma, semicolon, or colon, except at the end of the line.

```python
Yes: if x == 4:
         print(x, y)
     x, y = y, x
```

```python
No:  if x == 4 :
         print(x , y)
     x , y = y , x
```

No whitespace before the open paren/bracket that starts an argument list,
indexing or slicing.

```python
Yes: spam(1)
```

```python
No:  spam (1)
```

```python
Yes: dict['key'] = list[index]
```

```python
No:  dict ['key'] = list [index]
```

No trailing whitespace.

Surround binary operators with a single space on either side for assignment
(`=`), comparisons (`==, <, >, !=, <>, <=, >=, in, not in, is, is not`), and
Booleans (`and, or, not`). Use your better judgment for the insertion of spaces
around arithmetic operators (`+`, `-`, `*`, `/`, `//`, `%`, `**`, `@`).

```python
Yes: x == 1
```

```python
No:  x<1
```

Never use spaces around `=` when passing keyword arguments or defining a default
parameter value, with one exception:
[when a type annotation is present](#typing-default-values), *do* use spaces
around the `=` for the default parameter value.

```python
Yes: def complex(real, imag=0.0): return Magic(r=real, i=imag)
Yes: def complex(real, imag: float = 0.0): return Magic(r=real, i=imag)
```

```python
No:  def complex(real, imag = 0.0): return Magic(r = real, i = imag)
No:  def complex(real, imag: float=0.0): return Magic(r = real, i = imag)
```

Don't use spaces to vertically align tokens on consecutive lines, since it
becomes a maintenance burden (applies to `:`, `#`, `=`, etc.):

```python
Yes:
  foo = 1000  # comment
  long_name = 2  # comment that should not be aligned

  dictionary = {
      'foo': 1,
      'long_name': 2,
  }
```

```python
No:
  foo       = 1000  # comment
  long_name = 2     # comment that should not be aligned

  dictionary = {
      'foo'      : 1,
      'long_name': 2,
  }
```


<a id="Python_Interpreter"></a>
<a id="s3.7-shebang-line"></a>
<a id="37-shebang-line"></a>

<a id="shebang-line"></a>
### 3.7 Shebang Line 

Most `.py` files do not need to start with a `#!` line. Start the main file of a
program with
`#!/usr/bin/env python3` (to support virtualenvs) or `#!/usr/bin/python3` per
[PEP-394](https://peps.python.org/pep-0394/).

This line is used by the kernel to find the Python interpreter, but is ignored by Python when importing modules. It is only necessary on a file intended to be executed directly.

<a id="s3.8-comments-and-docstrings"></a>
<a id="s3.8-comments"></a>
<a id="38-comments-and-docstrings"></a>

<a id="documentation"></a>
### 3.8 Comments and Docstrings 

Be sure to use the right style for module, function, method docstrings and
inline comments.

<a id="s3.8.1-comments-in-doc-strings"></a>
<a id="381-docstrings"></a>
<a id="comments-in-doc-strings"></a>

<a id="docstrings"></a>
#### 3.8.1 Docstrings 

Python uses *docstrings* to document code. A docstring is a string that is the
first statement in a package, module, class or function. These strings can be
extracted automatically through the `__doc__` member of the object and are used
by `pydoc`.
(Try running `pydoc` on your module to see how it looks.) Always use the
three-double-quote `"""` format for docstrings (per
[PEP 257](https://peps.python.org/pep-0257/)). A docstring should be organized
as a summary line (one physical line not exceeding 80 characters) terminated by
a period, question mark, or exclamation point. When writing more (encouraged),
this must be followed by a blank line, followed by the rest of the docstring
starting at the same cursor position as the first quote of the first line. There
are more formatting guidelines for docstrings below.

<a id="s3.8.2-comments-in-modules"></a>
<a id="382-modules"></a>
<a id="comments-in-modules"></a>

<a id="module-docs"></a>
#### 3.8.2 Modules 

Every file should contain license boilerplate. Choose the appropriate boilerplate for the license used by the project (for example, Apache 2.0, BSD, LGPL, GPL).

Files should start with a docstring describing the contents and usage of the
module.
```python
"""A one-line summary of the module or program, terminated by a period.

Leave one blank line.  The rest of this docstring should contain an
overall description of the module or program.  Optionally, it may also
contain a brief description of exported classes and functions and/or usage
examples.

Typical usage example:

  foo = ClassFoo()
  bar = foo.function_bar()
"""
```


<a id="s3.8.2.1-test-modules"></a>

<a id="test-docs"></a>
##### 3.8.2.1 Test modules 

Module-level docstrings for test files are not required. They should be included
only when there is additional information that can be provided.

Examples include some specifics on how the test should be run, an explanation of
an unusual setup pattern, dependency on the external environment, and so on.

```python
"""This blaze test uses golden files.

You can update those files by running
`blaze run //foo/bar:foo_test -- --update_golden_files` from the `google3`
directory.
"""
```

Docstrings that do not provide any new information should not be used.

```python
"""Tests for foo.bar."""
```

<a id="s3.8.3-functions-and-methods"></a>
<a id="383-functions-and-methods"></a>
<a id="functions-and-methods"></a>

<a id="function-docs"></a>
#### 3.8.3 Functions and Methods 

In this section, "function" means a method, function, generator, or property.

A docstring is mandatory for every function that has one or more of the
following properties:

-   being part of the public API
-   nontrivial size
-   non-obvious logic

A docstring should give enough information to write a call to the function
without reading the function's code. The docstring should describe the
function's calling syntax and its semantics, but generally not its
implementation details, unless those details are relevant to how the function is
to be used. For example, a function that mutates one of its arguments as a side
effect should note that in its docstring. Otherwise, subtle but important
details of a function's implementation that are not relevant to the caller are
better expressed as comments alongside the code than within the function's
docstring.

The docstring may be descriptive-style (`"""Fetches rows from a Bigtable."""`)
or imperative-style (`"""Fetch rows from a Bigtable."""`), but the style should
be consistent within a file. The docstring for a `@property` data descriptor
should use the same style as the docstring for an attribute or a
<a href="#doc-function-args">function argument</a> (`"""The Bigtable path."""`,
rather than `"""Returns the Bigtable path."""`).

Certain aspects of a function should be documented in special sections, listed
below. Each section begins with a heading line, which ends with a colon. All
sections other than the heading should maintain a hanging indent of two or four
spaces (be consistent within a file). These sections can be omitted in cases
where the function's name and signature are informative enough that it can be
aptly described using a one-line docstring.

<a id="doc-function-args"></a>
[*Args:*](#doc-function-args)
:   List each parameter by name. A description should follow the name, and be
    separated by a colon followed by either a space or newline. If the
    description is too long to fit on a single 80-character line, use a hanging
    indent of 2 or 4 spaces more than the parameter name (be consistent with the
    rest of the docstrings in the file). The description should include required
    type(s) if the code does not contain a corresponding type annotation. If a
    function accepts `*foo` (variable length argument lists) and/or `**bar`
    (arbitrary keyword arguments), they should be listed as `*foo` and `**bar`.

<a id="doc-function-returns"></a>
[*Returns:* (or *Yields:* for generators)](#doc-function-returns)
:   Describe the semantics of the return value, including any type information
    that the type annotation does not provide. If the function only returns
    None, this section is not required. It may also be omitted if the docstring
    starts with "Return", "Returns", "Yield", or "Yields" (e.g. `"""Returns row
    from Bigtable as a tuple of strings."""`) *and* the opening sentence is
    sufficient to describe the return value. Do not imitate older 'NumPy style'
    ([example](https://numpy.org/doc/1.24/reference/generated/numpy.linalg.qr.html)),
    which frequently documented a tuple return value as if it were multiple
    return values with individual names (never mentioning the tuple). Instead,
    describe such a return value as: "Returns: A tuple (mat_a, mat_b), where
    mat_a is ..., and ...". The auxiliary names in the docstring need not
    necessarily correspond to any internal names used in the function body (as
    those are not part of the API). If the function uses `yield` (is a
    generator), the `Yields:` section should document the object returned by
    `next()`, instead of the generator object itself that the call evaluates to.

<a id="doc-function-raises"></a>
[*Raises:*](#doc-function-raises)
:   List all exceptions that are relevant to the interface followed by a
    description. Use a similar exception name + colon + space or newline and
    hanging indent style as described in *Args:*. You should not document
    exceptions that get raised if the API specified in the docstring is violated
    (because this would paradoxically make behavior under violation of the API
    part of the API).

```python
def fetch_smalltable_rows(
    table_handle: smalltable.Table,
    keys: Sequence[bytes | str],
    require_all_keys: bool = False,
) -> Mapping[bytes, tuple[str, ...]]:
    """Fetches rows from a Smalltable.

    Retrieves rows pertaining to the given keys from the Table instance
    represented by table_handle.  String keys will be UTF-8 encoded.

    Args:
        table_handle: An open smalltable.Table instance.
        keys: A sequence of strings representing the key of each table
          row to fetch.  String keys will be UTF-8 encoded.
        require_all_keys: If True only rows with values set for all keys will be
          returned.

    Returns:
        A dict mapping keys to the corresponding table row data
        fetched. Each row is represented as a tuple of strings. For
        example:

        {b'Serak': ('Rigel VII', 'Preparer'),
         b'Zim': ('Irk', 'Invader'),
         b'Lrrr': ('Omicron Persei 8', 'Emperor')}

        Returned keys are always bytes.  If a key from the keys argument is
        missing from the dictionary, then that row was not found in the
        table (and require_all_keys must have been False).

    Raises:
        IOError: An error occurred accessing the smalltable.
    """
```

Similarly, this variation on `Args:` with a line break is also allowed:

```python
def fetch_smalltable_rows(
    table_handle: smalltable.Table,
    keys: Sequence[bytes | str],
    require_all_keys: bool = False,
) -> Mapping[bytes, tuple[str, ...]]:
    """Fetches rows from a Smalltable.

    Retrieves rows pertaining to the given keys from the Table instance
    represented by table_handle.  String keys will be UTF-8 encoded.

    Args:
      table_handle:
        An open smalltable.Table instance.
      keys:
        A sequence of strings representing the key of each table row to
        fetch.  String keys will be UTF-8 encoded.
      require_all_keys:
        If True only rows with values set for all keys will be returned.

    Returns:
      A dict mapping keys to the corresponding table row data
      fetched. Each row is represented as a tuple of strings. For
      example:

      {b'Serak': ('Rigel VII', 'Preparer'),
       b'Zim': ('Irk', 'Invader'),
       b'Lrrr': ('Omicron Persei 8', 'Emperor')}

      Returned keys are always bytes.  If a key from the keys argument is
      missing from the dictionary, then that row was not found in the
      table (and require_all_keys must have been False).

    Raises:
      IOError: An error occurred accessing the smalltable.
    """
```

<a id="s3.8.3.1-overridden-methods"></a>

<a id="overridden-method-docs"></a>
##### 3.8.3.1 Overridden Methods 

A method that overrides a method from a base class does not need a docstring if
it is explicitly decorated with
[`@override`](https://typing-extensions.readthedocs.io/en/latest/#override)
(from `typing_extensions` or `typing` modules), unless the overriding method's
behavior materially refines the base method's contract, or details need to be
provided (e.g., documenting additional side effects), in which case a docstring
with at least those differences is required on the overriding method.

```python
from typing_extensions import override

class Parent:
  def do_something(self):
    """Parent method, includes docstring."""

# Child class, method annotated with override.
class Child(Parent):
  @override
  def do_something(self):
    pass
```

```python
# Child class, but without @override decorator, a docstring is required.
class Child(Parent):
  def do_something(self):
    pass

# Docstring is trivial, @override is sufficient to indicate that docs can be
# found in the base class.
class Child(Parent):
  @override
  def do_something(self):
    """See base class."""
```

<a id="s3.8.4-comments-in-classes"></a>
<a id="384-classes"></a>
<a id="comments-in-classes"></a>

<a id="class-docs"></a>
#### 3.8.4 Classes 

Classes should have a docstring below the class definition describing the class.
Public attributes, excluding [properties](#properties), should be documented
here in an `Attributes` section and follow the same formatting as a
[function's `Args`](#doc-function-args) section.

```python
class SampleClass:
    """Summary of class here.

    Longer class information...
    Longer class information...

    Attributes:
        likes_spam: A boolean indicating if we like SPAM or not.
        eggs: An integer count of the eggs we have laid.
    """

    def __init__(self, likes_spam: bool = False):
        """Initializes the instance based on spam preference.

        Args:
          likes_spam: Defines if instance exhibits this preference.
        """
        self.likes_spam = likes_spam
        self.eggs = 0

    @property
    def butter_sticks(self) -> int:
        """The number of butter sticks we have."""
```

All class docstrings should start with a one-line summary that describes what
the class instance represents. This implies that subclasses of `Exception`
should also describe what the exception represents, and not the context in which
it might occur. The class docstring should not repeat unnecessary information,
such as that the class is a class.

```python
# Yes:
class CheeseShopAddress:
  """The address of a cheese shop.

  ...
  """

class OutOfCheeseError(Exception):
  """No more cheese is available."""
```

```python
# No:
class CheeseShopAddress:
  """Class that describes the address of a cheese shop.

  ...
  """

class OutOfCheeseError(Exception):
  """Raised when no more cheese is available."""
```

<a id="s3.8.5-block-and-inline-comments"></a>
<a id="comments-in-block-and-inline"></a>
<a id="s3.8.5-comments-in-block-and-inline"></a>
<a id="385-block-and-inline-comments"></a>

<a id="comments"></a>
#### 3.8.5 Block and Inline Comments 

The final place to have comments is in tricky parts of the code. If you're going
to have to explain it at the next [code review](http://en.wikipedia.org/wiki/Code_review),
you should comment it now. Complicated operations get a few lines of comments
before the operations commence. Non-obvious ones get comments at the end of the
line.

```python
# We use a weighted dictionary search to find out where i is in
# the array.  We extrapolate position based on the largest num
# in the array and the array size and then do binary search to
# get the exact number.

if i & (i-1) == 0:  # True if i is 0 or a power of 2.
```

To improve legibility, these comments should start at least 2 spaces away from
the code with the comment character `#`, followed by at least one space before
the text of the comment itself.

On the other hand, never describe the code. Assume the person reading the code
knows Python (though not what you're trying to do) better than you do.

```python
# BAD COMMENT: Now go through the b array and make sure whenever i occurs
# the next element is i+1
```

<!-- The next section is copied from the C++ style guide. -->

<a id="s3.8.6-punctuation-spelling-and-grammar"></a>
<a id="386-punctuation-spelling-and-grammar"></a>
<a id="spelling"></a>
<a id="punctuation"></a>
<a id="grammar"></a>

<a id="punctuation-spelling-grammar"></a>
#### 3.8.6 Punctuation, Spelling, and Grammar 

Pay attention to punctuation, spelling, and grammar; it is easier to read
well-written comments than badly written ones.

Comments should be as readable as narrative text, with proper capitalization and
punctuation. In many cases, complete sentences are more readable than sentence
fragments. Shorter comments, such as comments at the end of a line of code, can
sometimes be less formal, but you should be consistent with your style.

Although it can be frustrating to have a code reviewer point out that you are
using a comma when you should be using a semicolon, it is very important that
source code maintain a high level of clarity and readability. Proper
punctuation, spelling, and grammar help with that goal.

<a id="s3.10-strings"></a>
<a id="310-strings"></a>

<a id="strings"></a>
### 3.10 Strings 

Use an
[f-string](https://docs.python.org/3/reference/lexical_analysis.html#f-strings),
the `%` operator, or the `format` method for formatting strings, even when the
parameters are all strings. Use your best judgment to decide between string
formatting options. A single join with `+` is okay but do not format with `+`.

```python
Yes: x = f'name: {name}; score: {n}'
     x = '%s, %s!' % (imperative, expletive)
     x = '{}, {}'.format(first, second)
     x = 'name: %s; score: %d' % (name, n)
     x = 'name: %(name)s; score: %(score)d' % {'name':name, 'score':n}
     x = 'name: {}; score: {}'.format(name, n)
     x = a + b
```

```python
No: x = first + ', ' + second
    x = 'name: ' + name + '; score: ' + str(n)
```

Avoid using the `+` and `+=` operators to accumulate a string within a loop. In
some conditions, accumulating a string with addition can lead to quadratic
rather than linear running time. Although common accumulations of this sort may
be optimized on CPython, that is an implementation detail. The conditions under
which an optimization applies are not easy to predict and may change. Instead,
add each substring to a list and `''.join` the list after the loop terminates,
or write each substring to an `io.StringIO` buffer. These techniques
consistently have amortized-linear run-time complexity.

```python
Yes: items = ['<table>']
     for last_name, first_name in employee_list:
         items.append('<tr><td>%s, %s</td></tr>' % (last_name, first_name))
     items.append('</table>')
     employee_table = ''.join(items)
```

```python
No: employee_table = '<table>'
    for last_name, first_name in employee_list:
        employee_table += '<tr><td>%s, %s</td></tr>' % (last_name, first_name)
    employee_table += '</table>'
```

Be consistent with your choice of string quote character within a file. Pick `'`
or `"` and stick with it. It is okay to use the other quote character on a
string to avoid the need to backslash-escape quote characters within the string.

```python
Yes:
  Python('Why are you hiding your eyes?')
  Gollum("I'm scared of lint errors.")
  Narrator('"Good!" thought a happy Python reviewer.')
```

```python
No:
  Python("Why are you hiding your eyes?")
  Gollum('The lint. It burns. It burns us.')
  Gollum("Always the great lint. Watching. Watching.")
```

Prefer `"""` for multi-line strings rather than `'''`. Projects may choose to
use `'''` for all non-docstring multi-line strings if and only if they also use
`'` for regular strings. Docstrings must use `"""` regardless.

Multi-line strings do not flow with the indentation of the rest of the program.
If you need to avoid embedding extra space in the string, use either
concatenated single-line strings or a multi-line string with
[`textwrap.dedent()`](https://docs.python.org/3/library/textwrap.html#textwrap.dedent)
to remove the initial space on each line:

```python
  No:
  long_string = """This is pretty ugly.
Don't do this.
"""
```

```python
  Yes:
  long_string = """This is fine if your use case can accept
      extraneous leading spaces."""
```

```python
  Yes:
  long_string = ("And this is fine if you cannot accept\n" +
                 "extraneous leading spaces.")
```

```python
  Yes:
  long_string = ("And this too is fine if you cannot accept\n"
                 "extraneous leading spaces.")
```

```python
  Yes:
  import textwrap

  long_string = textwrap.dedent("""\
      This is also fine, because textwrap.dedent()
      will collapse common leading spaces in each line.""")
```

Note that using a backslash here does not violate the prohibition against
[explicit line continuation](#line-length); in this case, the backslash is
[escaping a newline](https://docs.python.org/3/reference/lexical_analysis.html#string-and-bytes-literals)
in a string literal.

<a id="s3.10.1-logging"></a>
<a id="3101-logging"></a>
<a id="logging"></a>

<a id="logging"></a>
#### 3.10.1 Logging 

For logging functions that expect a pattern-string (with %-placeholders) as
their first argument: Always call them with a string literal (not an f-string!)
as their first argument with pattern-parameters as subsequent arguments. Some
logging implementations collect the unexpanded pattern-string as a queryable
field. It also prevents spending time rendering a message that no logger is
configured to output.

```python
  Yes:
  import tensorflow as tf
  logger = tf.get_logger()
  logger.info('TensorFlow Version is: %s', tf.__version__)
```

```python
  Yes:
  import os
  from absl import logging

  logging.info('Current $PAGER is: %s', os.getenv('PAGER', default=''))

  homedir = os.getenv('HOME')
  if homedir is None or not os.access(homedir, os.W_OK):
    logging.error('Cannot write to home directory, $HOME=%r', homedir)
```

```python
  No:
  import os
  from absl import logging

  logging.info('Current $PAGER is:')
  logging.info(os.getenv('PAGER', default=''))

  homedir = os.getenv('HOME')
  if homedir is None or not os.access(homedir, os.W_OK):
    logging.error(f'Cannot write to home directory, $HOME={homedir!r}')
```

<a id="s3.10.2-error-messages"></a>
<a id="3102-error-messages"></a>
<a id="error-messages"></a>

<a id="error-messages"></a>
#### 3.10.2 Error Messages 

Error messages (such as: message strings on exceptions like `ValueError`, or
messages shown to the user) should follow three guidelines:

1.  The message needs to precisely match the actual error condition.

2.  Interpolated pieces need to always be clearly identifiable as such.

3.  They should allow simple automated processing (e.g. grepping).

```python
  Yes:
  if not 0 <= p <= 1:
    raise ValueError(f'Not a probability: {p=}')

  try:
    os.rmdir(workdir)
  except OSError as error:
    logging.warning('Could not remove directory (reason: %r): %r',
                    error, workdir)
```

```python
  No:
  if p < 0 or p > 1:  # PROBLEM: also false for float('nan')!
    raise ValueError(f'Not a probability: {p=}')

  try:
    os.rmdir(workdir)
  except OSError:
    # PROBLEM: Message makes an assumption that might not be true:
    # Deletion might have failed for some other reason, misleading
    # whoever has to debug this.
    logging.warning('Directory already was deleted: %s', workdir)

  try:
    os.rmdir(workdir)
  except OSError:
    # PROBLEM: The message is harder to grep for than necessary, and
    # not universally non-confusing for all possible values of `workdir`.
    # Imagine someone calling a library function with such code
    # using a name such as workdir = 'deleted'. The warning would read:
    # "The deleted directory could not be deleted."
    logging.warning('The %s directory could not be deleted.', workdir)
```

<a id="s3.11-files-sockets-closeables"></a>
<a id="s3.11-files-and-sockets"></a>
<a id="311-files-and-sockets"></a>
<a id="files-and-sockets"></a>

<a id="files"></a>
### 3.11 Files, Sockets, and similar Stateful Resources 

Explicitly close files and sockets when done with them. This rule naturally
extends to closeable resources that internally use sockets, such as database
connections, and also other resources that need to be closed down in a similar
fashion. To name only a few examples, this also includes
[mmap](https://docs.python.org/3/library/mmap.html) mappings,
[h5py File objects](https://docs.h5py.org/en/stable/high/file.html), and
[matplotlib.pyplot figure windows](https://matplotlib.org/2.1.0/api/_as_gen/matplotlib.pyplot.close.html).

Leaving files, sockets or other such stateful objects open unnecessarily has
many downsides:

-   They may consume limited system resources, such as file descriptors. Code
    that deals with many such objects may exhaust those resources unnecessarily
    if they're not returned to the system promptly after use.
-   Holding files open may prevent other actions such as moving or deleting
    them, or unmounting a filesystem.
-   Files and sockets that are shared throughout a program may inadvertently be
    read from or written to after logically being closed. If they are actually
    closed, attempts to read or write from them will raise exceptions, making
    the problem known sooner.

Furthermore, while files and sockets (and some similarly behaving resources) are
automatically closed when the object is destructed, coupling the lifetime of the
object to the state of the resource is poor practice:

-   There are no guarantees as to when the runtime will actually invoke the
    `__del__` method. Different Python implementations use different memory
    management techniques, such as delayed garbage collection, which may
    increase the object's lifetime arbitrarily and indefinitely.
-   Unexpected references to the file, e.g. in globals or exception tracebacks,
    may keep it around longer than intended.

Relying on finalizers to do automatic cleanup that has observable side effects
has been rediscovered over and over again to lead to major problems, across many
decades and multiple languages (see e.g.
[this article](https://wiki.sei.cmu.edu/confluence/display/java/MET12-J.+Do+not+use+finalizers)
for Java).

The preferred way to manage files and similar resources is using the
[`with` statement](http://docs.python.org/reference/compound_stmts.html#the-with-statement):

```python
with open("hello.txt") as hello_file:
    for line in hello_file:
        print(line)
```

For file-like objects that do not support the `with` statement, use
`contextlib.closing()`:

```python
import contextlib

with contextlib.closing(urllib.urlopen("http://www.python.org/")) as front_page:
    for line in front_page:
        print(line)
```

In rare cases where context-based resource management is infeasible, code
documentation must explain clearly how resource lifetime is managed.

<a id="s3.12-todo-comments"></a>
<a id="312-todo-comments"></a>

<a id="todo"></a>
### 3.12 TODO Comments 

Use `TODO` comments for code that is temporary, a short-term solution, or
good-enough but not perfect.

A `TODO` comment begins with the word `TODO` in all caps, a following colon, and
a link to a resource that contains the context, ideally a bug reference. A bug
reference is preferable because bugs are tracked and have follow-up comments.
Follow this piece of context with an explanatory string introduced with a hyphen
`-`. 
The purpose is to have a consistent `TODO` format that can be searched to find
out how to get more details. 

```python
# TODO: crbug.com/192795 - Investigate cpufreq optimizations.
```

Old style, formerly recommended, but discouraged for use in new code:


```python
# TODO(crbug.com/192795): Investigate cpufreq optimizations.
# TODO(yourusername): Use a "\*" here for concatenation operator.
```

Avoid adding TODOs that refer to an individual or team as the context:

```python
# TODO: @yourusername - File an issue and use a '*' for repetition.
```

If your `TODO` is of the form "At a future date do something" make sure that you
either include a very specific date ("Fix by November 2009") or a very specific
event ("Remove this code when all clients can handle XML responses.") that
future code maintainers will comprehend. Issues are ideal for tracking this.

<a id="s3.13-imports-formatting"></a>
<a id="313-imports-formatting"></a>

<a id="imports-formatting"></a>
### 3.13 Imports formatting 

Imports should be on separate lines; there are
[exceptions for `typing` and `collections.abc` imports](#typing-imports).

E.g.:

```python
Yes: from collections.abc import Mapping, Sequence
     import os
     import sys
     from typing import Any, NewType
```

```python
No:  import os, sys
```


Imports are always put at the top of the file, just after any module comments
and docstrings and before module globals and constants. Imports should be
grouped from most generic to least generic:

1.  Python future import statements. For example:

    ```python
    from __future__ import annotations
    ```

    See [above](#from-future-imports) for more information about those.

2.  Python standard library imports. For example:

    ```python
    import sys
    ```

3.  [third-party](https://pypi.org/) module
    or package imports. For example:

    
    ```python
    import tensorflow as tf
    ```

4.  Code repository
    sub-package imports. For example:

    
    ```python
    from otherproject.ai import mind
    ```

5.  **Deprecated:** application-specific imports that are part of the same
    top-level
    sub-package as this file. For example:

    
    ```python
    from myproject.backend.hgwells import time_machine
    ```

    You may find older Google Python Style code doing this, but it is no longer
    required. **New code is encouraged not to bother with this.** Simply treat
    application-specific sub-package imports the same as other sub-package
    imports.

    
Within each grouping, imports should be sorted lexicographically, ignoring case,
according to each module's full package path (the `path` in `from path import
...`). Code may optionally place a blank line between import sections.

```python
import collections
import queue
import sys

from absl import app
from absl import flags
import bs4
import cryptography
import tensorflow as tf

from book.genres import scifi
from myproject.backend import huxley
from myproject.backend.hgwells import time_machine
from myproject.backend.state_machine import main_loop
from otherproject.ai import body
from otherproject.ai import mind
from otherproject.ai import soul

# Older style code may have these imports down here instead:
#from myproject.backend.hgwells import time_machine
#from myproject.backend.state_machine import main_loop
```


<a id="s3.14-statements"></a>
<a id="314-statements"></a>

<a id="statements"></a>
### 3.14 Statements 

Generally only one statement per line.

However, you may put the result of a test on the same line as the test only if
the entire statement fits on one line. In particular, you can never do so with
`try`/`except` since the `try` and `except` can't both fit on the same line, and
you can only do so with an `if` if there is no `else`.

```python
Yes:

  if foo: bar(foo)
```

```python
No:

  if foo: bar(foo)
  else:   baz(foo)

  try:               bar(foo)
  except ValueError: baz(foo)

  try:
      bar(foo)
  except ValueError: baz(foo)
```

<a id="s3.15-accessors"></a>
<a id="s3.15-access-control"></a>
<a id="315-access-control"></a>
<a id="access-control"></a>
<a id="accessors"></a>

<a id="getters-and-setters"></a>
### 3.15 Getters and Setters 

Getter and setter functions (also called accessors and mutators) should be used
when they provide a meaningful role or behavior for getting or setting a
variable's value.

In particular, they should be used when getting or setting the variable is
complex or the cost is significant, either currently or in a reasonable future.

If, for example, a pair of getters/setters simply read and write an internal
attribute, the internal attribute should be made public instead. By comparison,
if setting a variable means some state is invalidated or rebuilt, it should be a
setter function. The function invocation hints that a potentially non-trivial
operation is occurring. Alternatively, [properties](#properties) may be an
option when simple logic is needed, or refactoring to no longer need getters and
setters.

Getters and setters should follow the [Naming](#s3.16-naming) guidelines, such
as `get_foo()` and `set_foo()`.

If the past behavior allowed access through a property, do not bind the new
getter/setter functions to the property. Any code still attempting to access the
variable by the old method should break visibly so they are made aware of the
change in complexity.

<a id="s3.16-naming"></a>
<a id="316-naming"></a>

<a id="naming"></a>
### 3.16 Naming 

`module_name`, `package_name`, `ClassName`, `method_name`, `ExceptionName`,
`function_name`, `GLOBAL_CONSTANT_NAME`, `global_var_name`, `instance_var_name`,
`function_parameter_name`, `local_var_name`, `query_proper_noun_for_thing`,
`send_acronym_via_https`.


Names should be descriptive. This includes functions, classes, variables,
attributes, files and any other type of named entities.

Avoid abbreviation. In particular, do not use abbreviations that are ambiguous
or unfamiliar to readers outside your project, and do not abbreviate by deleting
letters within a word.

Always use a `.py` filename extension. Never use dashes.

<a id="s3.16.1-names-to-avoid"></a>
<a id="3161-names-to-avoid"></a>

<a id="names-to-avoid"></a>
#### 3.16.1 Names to Avoid 

-   single character names, except for specifically allowed cases:

    -   counters or iterators (e.g. `i`, `j`, `k`, `v`, et al.)
    -   `e` as an exception identifier in `try/except` statements.
    -   `f` as a file handle in `with` statements
    -   private [type variables](#typing-type-var) with no constraints (e.g.
        `_T = TypeVar("_T")`, `_P = ParamSpec("_P")`)
    -   names that match established notation in a reference paper or algorithm
        (see [Mathematical Notation](#math-notation))

    Please be mindful not to abuse single-character naming. Generally speaking,
    descriptiveness should be proportional to the name's scope of visibility.
    For example, `i` might be a fine name for 5-line code block but within
    multiple nested scopes, it is likely too vague.

-   dashes (`-`) in any package/module name

-   `__double_leading_and_trailing_underscore__` names (reserved by Python)

-   offensive terms

-   names that needlessly include the type of the variable (for example:
    `id_to_name_dict`)

<a id="s3.16.2-naming-conventions"></a>
<a id="3162-naming-convention"></a>

<a id="naming-conventions"></a>
#### 3.16.2 Naming Conventions 

-   "Internal" means internal to a module, or protected or private within a
    class.

-   Prepending a single underscore (`_`) has some support for protecting module
    variables and functions (linters will flag protected member access). Note
    that it is okay for unit tests to access protected constants from the
    modules under test.

-   Prepending a double underscore (`__` aka "dunder") to an instance variable
    or method effectively makes the variable or method private to its class
    (using name mangling); we discourage its use as it impacts readability and
    testability, and isn't *really* private. Prefer a single underscore.

-   Place related classes and top-level functions together in a
    module.
    Unlike Java, there is no need to limit yourself to one class per module.

-   Use CapWords for class names, but lower\_with\_under.py for module names.
    Although there are some old modules named CapWords.py, this is now
    discouraged because it's confusing when the module happens to be named after
    a class. ("wait -- did I write `import StringIO` or `from StringIO import
    StringIO`?")

-   New *unit test* files follow PEP 8 compliant lower\_with\_under method
    names, for example, `test_<method_under_test>_<state>`. For consistency(\*)
    with legacy modules that follow CapWords function names, underscores may
    appear in method names starting with `test` to separate logical components
    of the name. One possible pattern is `test<MethodUnderTest>_<state>`.

<a id="s3.16.3-file-naming"></a>
<a id="3163-file-naming"></a>

<a id="file-naming"></a>
#### 3.16.3 File Naming 

Python filenames must have a `.py` extension and must not contain dashes (`-`).
This allows them to be imported and unittested. If you want an executable to be
accessible without the extension, use a symbolic link or a simple bash wrapper
containing `exec "$0.py" "$@"`.

<a id="s3.16.4-guidelines-derived-from-guidos-recommendations"></a>
<a id="3164-guidelines-derived-from-guidos-recommendations"></a>

<a id="guidelines-derived-from-guidos-recommendations"></a>
#### 3.16.4 Guidelines derived from [Guido](https://en.wikipedia.org/wiki/Guido_van_Rossum)'s Recommendations 

<table rules="all" border="1" summary="Guidelines from Guido's Recommendations"
       cellspacing="2" cellpadding="2">

  <tr>
    <th>Type</th>
    <th>Public</th>
    <th>Internal</th>
  </tr>

  <tr>
    <td>Packages</td>
    <td><code>lower_with_under</code></td>
    <td></td>
  </tr>

  <tr>
    <td>Modules</td>
    <td><code>lower_with_under</code></td>
    <td><code>_lower_with_under</code></td>
  </tr>

  <tr>
    <td>Classes</td>
    <td><code>CapWords</code></td>
    <td><code>_CapWords</code></td>
  </tr>

  <tr>
    <td>Exceptions</td>
    <td><code>CapWords</code></td>
    <td></td>
  </tr>

  <tr>
    <td>Functions</td>
    <td><code>lower_with_under()</code></td>
    <td><code>_lower_with_under()</code></td>
  </tr>

  <tr>
    <td>Global/Class Constants</td>
    <td><code>CAPS_WITH_UNDER</code></td>
    <td><code>_CAPS_WITH_UNDER</code></td>
  </tr>

  <tr>
    <td>Global/Class Variables</td>
    <td><code>lower_with_under</code></td>
    <td><code>_lower_with_under</code></td>
  </tr>

  <tr>
    <td>Instance Variables</td>
    <td><code>lower_with_under</code></td>
    <td><code>_lower_with_under</code> (protected)</td>
  </tr>

  <tr>
    <td>Method Names</td>
    <td><code>lower_with_under()</code></td>
    <td><code>_lower_with_under()</code> (protected)</td>
  </tr>

  <tr>
    <td>Function/Method Parameters</td>
    <td><code>lower_with_under</code></td>
    <td></td>
  </tr>

  <tr>
    <td>Local Variables</td>
    <td><code>lower_with_under</code></td>
    <td></td>
  </tr>

</table>


<a id="s3.17-main"></a>
<a id="317-main"></a>

<a id="math-notation"></a>
#### 3.16.5 Mathematical Notation 

For mathematically-heavy code, short variable names that would otherwise violate
the style guide are preferred when they match established notation in a
reference paper or algorithm.

When using names based on established notation:

1.  Cite the source of all naming conventions, preferably with a hyperlink to
    academic resource itself, in a comment or docstring. If the source is not
    accessible, clearly document the naming conventions.
2.  Prefer PEP8-compliant `descriptive_names` for public APIs, which are much
    more likely to be encountered out of context.
3.  Use a narrowly-scoped `pylint: disable=invalid-name` directive to silence
    warnings. For just a few variables, use the directive as an endline comment
    for each one; for more, apply the directive at the beginning of a block.

<a id="main"></a>
### 3.17 Main 

In Python, `pydoc` as well as unit tests require modules to be importable. If a
file is meant to be used as an executable, its main functionality should be in a
`main()` function, and your code should always check `if __name__ == '__main__'`
before executing your main program, so that it is not executed when the module
is imported.

When using [absl](https://github.com/abseil/abseil-py), use `app.run`:

```python
from absl import app
...

def main(argv: Sequence[str]):
    # process non-flag arguments
    ...

if __name__ == '__main__':
    app.run(main)
```

Otherwise, use:

```python
def main():
    ...

if __name__ == '__main__':
    main()
```

All code at the top level will be executed when the module is imported. Be
careful not to call functions, create objects, or perform other operations that
should not be executed when the file is being `pydoc`ed.

<a id="s3.18-function-length"></a>
<a id="318-function-length"></a>

<a id="function-length"></a>
### 3.18 Function length 

Prefer small and focused functions.

We recognize that long functions are sometimes appropriate, so no hard limit is
placed on function length. If a function exceeds about 40 lines, think about
whether it can be broken up without harming the structure of the program.

Even if your long function works perfectly now, someone modifying it in a few
months may add new behavior. This could result in bugs that are hard to find.
Keeping your functions short and simple makes it easier for other people to read
and modify your code.

You could find long and complicated functions when working with
some
code. Do not be intimidated by modifying existing code: if working with such a
function proves to be difficult, you find that errors are hard to debug, or you
want to use a piece of it in several different contexts, consider breaking up
the function into smaller and more manageable pieces.

<a id="s3.19-type-annotations"></a>
<a id="319-type-annotations"></a>

<a id="type-annotations"></a>
### 3.19 Type Annotations 

<a id="s3.19.1-general-rules"></a>
<a id="s3.19.1-general"></a>
<a id="3191-general-rules"></a>

<a id="typing-general"></a>
#### 3.19.1 General Rules 

*   Familiarize yourself with
    [type hints](https://docs.python.org/3/library/typing.html).

*   Annotating `self` or `cls` is generally not necessary.
    [`Self`](https://docs.python.org/3/library/typing.html#typing.Self) can be
    used if it is necessary for proper type information, e.g.

    ```python
    from typing import Self

    class BaseClass:
      @classmethod
      def create(cls) -> Self:
        ...

      def difference(self, other: Self) -> float:
        ...
    ```

*   Similarly, don't feel compelled to annotate the return value of `__init__`
    (where `None` is the only valid option).

*   If any other variable or a returned type should not be expressed, use `Any`.

*   You are not required to annotate all the functions in a module.

    -   At least annotate your public APIs.
    -   Use judgment to get to a good balance between safety and clarity on the
        one hand, and flexibility on the other.
    -   Annotate code that is prone to type-related errors (previous bugs or
        complexity).
    -   Annotate code that is hard to understand.
    -   Annotate code as it becomes stable from a types perspective. In many
        cases, you can annotate all the functions in mature code without losing
        too much flexibility.

<a id="s3.19.2-line-breaking"></a>
<a id="3192-line-breaking"></a>

<a id="typing-line-breaking"></a>
#### 3.19.2 Line Breaking 

Try to follow the existing [indentation](#indentation) rules.

After annotating, many function signatures will become "one parameter per line".
To ensure the return type is also given its own line, a comma can be placed
after the last parameter.

```python
def my_method(
    self,
    first_var: int,
    second_var: Foo,
    third_var: Bar | None,
) -> int:
  ...
```

Always prefer breaking between variables, and not, for example, between variable
names and type annotations. However, if everything fits on the same line, go for
it.

```python
def my_method(self, first_var: int) -> int:
  ...
```

If the combination of the function name, the last parameter, and the return type
is too long, indent by 4 in a new line. When using line breaks, prefer putting
each parameter and the return type on their own lines and aligning the closing
parenthesis with the `def`:

```python
Yes:
def my_method(
    self,
    other_arg: MyLongType | None,
) -> tuple[MyLongType1, MyLongType1]:
  ...
```

Optionally, the return type may be put on the same line as the last parameter:

```python
Okay:
def my_method(
    self,
    first_var: int,
    second_var: int) -> dict[OtherLongType, MyLongType]:
  ...
```

`pylint`
allows you to move the closing parenthesis to a new line and align with the
opening one, but this is less readable.

```python
No:
def my_method(self,
              other_arg: MyLongType | None,
             ) -> dict[OtherLongType, MyLongType]:
  ...
```

As in the examples above, prefer not to break types. However, sometimes they are
too long to be on a single line (try to keep sub-types unbroken).

```python
def my_method(
    self,
    first_var: tuple[list[MyLongType1],
                     list[MyLongType2]],
    second_var: list[dict[
        MyLongType3, MyLongType4]],
) -> None:
  ...
```

If a single name and type is too long, consider using an
[alias](#typing-aliases) for the type. The last resort is to break after the
colon and indent by 4.

```python
Yes:
def my_function(
    long_variable_name:
        long_module_name.LongTypeName,
) -> None:
  ...
```

```python
No:
def my_function(
    long_variable_name: long_module_name.
        LongTypeName,
) -> None:
  ...
```

<a id="s3.19.3-forward-declarations"></a>
<a id="3193-forward-declarations"></a>

<a id="forward-declarations"></a>
#### 3.19.3 Forward Declarations 

If you need to use a class name (from the same module) that is not yet
defined -- for example, if you need the class name inside the declaration of
that class, or if you use a class that is defined later in the code -- either
use `from __future__ import annotations` or use a string for the class name.

```python
Yes:
from __future__ import annotations

class MyClass:
  def __init__(self, stack: Sequence[MyClass], item: OtherClass) -> None:

class OtherClass:
  ...
```

```python
Yes:
class MyClass:
  def __init__(self, stack: Sequence['MyClass'], item: 'OtherClass') -> None:

class OtherClass:
  ...
```

<a id="s3.19.4-default-values"></a>
<a id="3194-default-values"></a>

<a id="typing-default-values"></a>
#### 3.19.4 Default Values 

As per [PEP-008](https://peps.python.org/pep-0008/#other-recommendations), use
spaces around the `=` *only* for arguments that have both a type annotation and
a default value.

```python
Yes:
def func(a: int = 0) -> int:
  ...
```

```python
No:
def func(a:int=0) -> int:
  ...
```

<a id="s3.19.5-nonetype"></a>
<a id="s3.19.5-none-type"></a>
<a id="3195-nonetype"></a>

<a id="none-type"></a>
#### 3.19.5 NoneType 

In the Python type system, `NoneType` is a "first class" type, and for typing
purposes, `None` is an alias for `NoneType`. If an argument can be `None`, it
has to be declared! You can use `|` union type expressions (recommended in new
Python 3.10+ code), or the older `Optional` and `Union` syntaxes.

Use explicit `X | None` instead of implicit. Earlier versions of type checkers
allowed `a: str = None` to be interpreted as `a: str | None = None`, but that is
no longer the preferred behavior.

```python
Yes:
def modern_or_union(a: str | int | None, b: str | None = None) -> str:
  ...
def union_optional(a: Union[str, int, None], b: Optional[str] = None) -> str:
  ...
```

```python
No:
def nullable_union(a: Union[None, str]) -> str:
  ...
def implicit_optional(a: str = None) -> str:
  ...
```

<a id="s3.19.6-type-aliases"></a>
<a id="s3.19.6-aliases"></a>
<a id="3196-type-aliases"></a>
<a id="typing-aliases"></a>

<a id="type-aliases"></a>
#### 3.19.6 Type Aliases 

You can declare aliases of complex types. The name of an alias should be
CapWorded. If the alias is used only in this module, it should be \_Private.

Note that the `: TypeAlias` annotation is only supported in versions 3.10+.

```python
from typing import TypeAlias

_LossAndGradient: TypeAlias = tuple[tf.Tensor, tf.Tensor]
ComplexTFMap: TypeAlias = Mapping[str, _LossAndGradient]
```

<a id="s3.19.7-ignoring-types"></a>
<a id="s3.19.7-ignore"></a>
<a id="3197-ignoring-types"></a>

<a id="typing-ignore"></a>
#### 3.19.7 Ignoring Types 

You can disable type checking on a line with the special comment `# type:
ignore`.

`pytype` has a disable option for specific errors (similar to lint):

```python
# pytype: disable=attribute-error
```

<a id="s3.19.8-typing-variables"></a>
<a id="s3.19.8-comments"></a>
<a id="3198-typing-internal-variables"></a>

<a id="typing-variables"></a>
#### 3.19.8 Typing Variables 

<a id="annotated-assignments"></a>
[*Annotated Assignments*](#annotated-assignments)
:   If an internal variable has a type that is hard or impossible to infer,
    specify its type with an annotated assignment - use a colon and type between
    the variable name and value (the same as is done with function arguments
    that have a default value):

    ```python
    a: Foo = SomeUndecoratedFunction()
    ```

<a id="type-comments"></a>
[*Type Comments*](#type-comments)
:   Though you may see them remaining in the codebase (they were necessary
    before Python 3.6), do not add any more uses of a `# type: <type name>`
    comment on the end of the line:

    ```python
    a = SomeUndecoratedFunction()  # type: Foo
    ```

<a id="s3.19.9-tuples-vs-lists"></a>
<a id="s3.19.9-tuples"></a>
<a id="3199-tuples-vs-lists"></a>

<a id="typing-tuples"></a>
#### 3.19.9 Tuples vs Lists 

Typed lists can only contain objects of a single type. Typed tuples can either
have a single repeated type or a set number of elements with different types.
The latter is commonly used as the return type from a function.

```python
a: list[int] = [1, 2, 3]
b: tuple[int, ...] = (1, 2, 3)
c: tuple[int, str, float] = (1, "2", 3.5)
```

<a id="s3.19.10-typevars"></a>
<a id="s3.19.10-type-var"></a>
<a id="31910-typevar"></a>
<a id="typing-type-var"></a>

<a id="typevars"></a>
#### 3.19.10 Type variables 

The Python type system has
[generics](https://docs.python.org/3/library/typing.html#generics). A type
variable, such as `TypeVar` and `ParamSpec`, is a common way to use them.

Example:

```python
from collections.abc import Callable
from typing import ParamSpec, TypeVar
_P = ParamSpec("_P")
_T = TypeVar("_T")
...
def next(l: list[_T]) -> _T:
  return l.pop()

def print_when_called(f: Callable[_P, _T]) -> Callable[_P, _T]:
  def inner(*args: _P.args, **kwargs: _P.kwargs) -> _T:
    print("Function was called")
    return f(*args, **kwargs)
  return inner
```

A `TypeVar` can be constrained:

```python
AddableType = TypeVar("AddableType", int, float, str)
def add(a: AddableType, b: AddableType) -> AddableType:
  return a + b
```

A common predefined type variable in the `typing` module is `AnyStr`. Use it for
multiple annotations that can be `bytes` or `str` and must all be the same type.

```python
from typing import AnyStr
def check_length(x: AnyStr) -> AnyStr:
  if len(x) <= 42:
    return x
  raise ValueError()
```

A type variable must have a descriptive name, unless it meets all of the
following criteria:

*   not externally visible
*   not constrained

```python
Yes:
  _T = TypeVar("_T")
  _P = ParamSpec("_P")
  AddableType = TypeVar("AddableType", int, float, str)
  AnyFunction = TypeVar("AnyFunction", bound=Callable)
```

```python
No:
  T = TypeVar("T")
  P = ParamSpec("P")
  _T = TypeVar("_T", int, float, str)
  _F = TypeVar("_F", bound=Callable)
```

<a id="s3.19.11-string-types"></a>
<a id="s3.19.11-strings"></a>
<a id="31911-string-types"></a>

<a id="typing-strings"></a>
#### 3.19.11 String types 

> Do not use `typing.Text` in new code. It's only for Python 2/3 compatibility.

Use `str` for string/text data. For code that deals with binary data, use
`bytes`.

```python
def deals_with_text_data(x: str) -> str:
  ...
def deals_with_binary_data(x: bytes) -> bytes:
  ...
```

If all the string types of a function are always the same, for example if the
return type is the same as the argument type in the code above, use
[AnyStr](#typing-type-var).

<a id="s3.19.12-imports-for-typing"></a>
<a id="s3.19.12-imports"></a>
<a id="31912-imports-for-typing"></a>

<a id="typing-imports"></a>
#### 3.19.12 Imports For Typing 

For symbols (including types, functions, and constants) from the `typing` or
`collections.abc` modules used to support static analysis and type checking,
always import the symbol itself. This keeps common annotations more concise and
matches typing practices used around the world. You are explicitly allowed to
import multiple specific symbols on one line from the `typing` and
`collections.abc` modules. For example:

```python
from collections.abc import Mapping, Sequence
from typing import Any, Generic, cast, TYPE_CHECKING
```

Given that this way of importing adds items to the local namespace, names in
`typing` or `collections.abc` should be treated similarly to keywords, and not
be defined in your Python code, typed or not. If there is a collision between a
type and an existing name in a module, import it using `import x as y`.

```python
from typing import Any as AnyType
```

When annotating function signatures, prefer abstract container types like
`collections.abc.Sequence` over concrete types like `list`. If you need to use a
concrete type (for example, a `tuple` of typed elements), prefer built-in types
like `tuple` over the parametric type aliases from the `typing` module (e.g.,
`typing.Tuple`).

```python
from typing import List, Tuple

def transform_coordinates(original: List[Tuple[float, float]]) ->
    List[Tuple[float, float]]:
  ...
```

```python
from collections.abc import Sequence

def transform_coordinates(original: Sequence[tuple[float, float]]) ->
    Sequence[tuple[float, float]]:
  ...
```

<a id="s3.19.13-conditional-imports"></a>
<a id="31913-conditional-imports"></a>

<a id="typing-conditional-imports"></a>
#### 3.19.13 Conditional Imports 

Use conditional imports only in exceptional cases where the additional imports
needed for type checking must be avoided at runtime. This pattern is
discouraged; alternatives such as refactoring the code to allow top-level
imports should be preferred.

Imports that are needed only for type annotations can be placed within an `if
TYPE_CHECKING:` block.

-   Conditionally imported types need to be referenced as strings, to be forward
    compatible with Python 3.6 where the annotation expressions are actually
    evaluated.
-   Only entities that are used solely for typing should be defined here; this
    includes aliases. Otherwise it will be a runtime error, as the module will
    not be imported at runtime.
-   The block should be right after all the normal imports.
-   There should be no empty lines in the typing imports list.
-   Sort this list as if it were a regular imports list.
```python
import typing
if typing.TYPE_CHECKING:
  import sketch
def f(x: "sketch.Sketch"): ...
```

<a id="s3.19.14-circular-dependencies"></a>
<a id="s3.19.14-circular-deps"></a>
<a id="31914-circular-dependencies"></a>

<a id="typing-circular-deps"></a>
#### 3.19.14 Circular Dependencies 

Circular dependencies that are caused by typing are code smells. Such code is a
good candidate for refactoring. Although technically it is possible to keep
circular dependencies, various build systems will not let you do so
because each module has to depend on the other.

Replace modules that create circular dependency imports with `Any`. Set an
[alias](#typing-aliases) with a meaningful name, and use the real type name from
this module (any attribute of `Any` is `Any`). Alias definitions should be
separated from the last import by one line.

```python
from typing import Any

some_mod = Any  # some_mod.py imports this module.
...

def my_method(self, var: "some_mod.SomeType") -> None:
  ...
```

<a id="typing-generics"></a>
<a id="s3.19.15-generics"></a>
<a id="31915-generics"></a>

<a id="generics"></a>
#### 3.19.15 Generics 

When annotating, prefer to specify type parameters for
[generic](https://docs.python.org/3/library/typing.html#generics) types in a
parameter list; otherwise, the generics' parameters will be assumed to be
[`Any`](https://docs.python.org/3/library/typing.html#the-any-type).

```python
# Yes:
def get_names(employee_ids: Sequence[int]) -> Mapping[int, str]:
  ...
```

```python
# No:
# This is interpreted as get_names(employee_ids: Sequence[Any]) -> Mapping[Any, Any]
def get_names(employee_ids: Sequence) -> Mapping:
  ...
```

If the best type parameter for a generic is `Any`, make it explicit, but
remember that in many cases [`TypeVar`](#typing-type-var) might be more
appropriate:

```python
# No:
def get_names(employee_ids: Sequence[Any]) -> Mapping[Any, str]:
  """Returns a mapping from employee ID to employee name for given IDs."""
```

```python
# Yes:
_T = TypeVar('_T')
def get_names(employee_ids: Sequence[_T]) -> Mapping[_T, str]:
  """Returns a mapping from employee ID to employee name for given IDs."""
```


<a id="4-parting-words"></a>

<a id="consistency"></a>
## 4 Parting Words 

*BE CONSISTENT*.

If you're editing code, take a few minutes to look at the code around you and
determine its style. If they use `_idx` suffixes in index variable names, you
should too. If their comments have little boxes of hash marks around them, make
your comments have little boxes of hash marks around them too.

The point of having style guidelines is to have a common vocabulary of coding so
people can concentrate on what you're saying rather than on how you're saying
it. We present global style rules here so people know the vocabulary, but local
style is also important. If code you add to a file looks drastically different
from the existing code around it, it throws readers out of their rhythm when
they go to read it.

However, there are limits to consistency. It applies more heavily locally and on
choices unspecified by the global style. Consistency should not generally be
used as a justification to do things in an old style without considering the
benefits of the new style, or the tendency of the codebase to converge on newer
styles over time.
```