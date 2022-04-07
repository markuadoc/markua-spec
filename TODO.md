# TODO

type: a, i, I, 1, etc for lists conflicts with type:

Tables:
row-start, row-end, col-start, col-end, cols: 4,6,7,12, rows: 13..18,22


What do we do with figure numbering?

Spec - have a global setting called figure-number-format: sequential | chapter (default sequential):

n

Figure 1, Figure 2, Figure 3, ...

OR

chapter_num.n

Figure 1.1, Figure 1.2, Figure 4.1, Figure 5.1, Figure 5.2, ...

SO:

1. Group by class, capitalized.
2. Number respecting figure-number-format: sequential | chapter

RESULT:

for class `listing`:

Listing 1, Listing 2, Listing 3, ...
Listing 3.1, Listing 3.2, Listing 4.1, ...

In a document:

List of Listings (`class: listing`)
...

List of Figures (`class: figure` [or implicit])
...

List of Equations (`class: equation`)
...

etc.

[Mar 31: YES]






foo bar ![](baz.png){title: "Here's a Baz"} baz lorem ipsum 

either:
a) we ignore the title because images inserted in a span context cannot be figures and thus cannot have captions
b) we respect the title because clearly the author wants one, so then we make a figure but what we do about spacing is up to the Markua Processor but it looks like this probably:

foo bar
(BAZ PICTURE)
Here's a Baz
baz lorem ipsum

Since there is a figure caption, it IS a figure, and thus we
add newlines where needed.

I was saying (a). I am now saying (b).

We could possibly add a warning, indicating that we added single newlines.

foo bar ![](baz.png){title: "Here's a Baz"} baz lorem ipsum 
== BECOMES ==>
foo bar
![](baz.png){title: "Here's a Baz"}
baz lorem ipsum 


because we're now going with (b), "Insertion Method: Figure and Span" is no longer needed.


DECISION:
Resources vary in four different ways.
1. Type: audio, code, image, iframe, markua, math, and video
2. Format: mp3, ruby, png, latexmath, mp4, etc.
3. Class: span, figure, equation, listing, table, etc.
4. Location: Inline, Local, and Web


Class is JUST about the list(s) of figures at the beginning of
a document, nothing more.

e.g. zoo animals by mammal / bird or cute / scary



# h1

## h2

para

para

para

para *italics text* stuff `puts "foo"`{lang: ruby} stuff **bold** stuff

baz

this is sad ![](tears-of-joy.png) really

baz

insertion method span (inside a new para):

foo bar

![](foo.png)

baz




THESE ARE THE TYPES:

Types:

`table` (format: markua, csv)
`list` (format: markua)






#########
MAR 31:

CHOICES: (the below would have relevant syntactic sugar)
a) type `poetry` with whitespace always verbatim and limited Markua formatting and monospaced font optional
b) type `poetry` with whitespace either verbatim or semantic and limited Markua formatting and monospaced font optional
c) type `markua` with class `poem` or anything with whitespace either `verbatim` or `semantic` and all Markua formatting and monospaced font optional
d) no whitespace verbatim, no poetry resources, etc.
e) rm poetry resource, be able to stick a class of poetry on a fenced markua block [literally c]
f) ```poem which is syntactic sugar for (c) or (a)

NO `raw` Markua resource format (which is equivalent to just typing it) because it is not "a thing in the book"...

{type: poetry, title: "Nothing Like The Sun"}
```
I grant I never saw a goddess go;
My mistress when she walks treads on the ground.
    And yet, by *heaven*, I       think            my love as rare
    As any she belied with **false compare**.

I grant I never saw a goddess go;
My mistress when she walks treads on the ground.
    And yet, by heaven, I think my love as rare
    As any she belied with false compare.
```


```verbatim
I grant I never saw a goddess go;
My mistress when she walks treads on the ground.
  And yet, by *heaven*, I       think            my love as rare
  As any she belied with **false compare**.
```   

BEST ANSWER: no `markua` resource, but yes to a limited `poetry` resource????

MAR 31: YES (as `verbatim` resource.). prevent slippery slope of expanded scope


CB:
1. Are there other formats beside code and poetry that need whitespace verbatim?

`verbatim` resource type.
What `verbatim` means is...
1. whitespace is preserved verbatim
2. no automatic indenting is done
3. basic Markua text formatting (bold, italic, etc.) is done
4. Markua resources (e.g. tables, images, lists) CANNOT be nested in it.
5. can add {monospaced: true | false} (default false)
6. can be local, web, inline resource
7. {type: verbatim, class: normal_rules_apply}




{type: markua, class: poem, title: "Nothing Like The Sun", whitespace: verbatim}
```
I grant I never saw a goddess go;
My mistress when she walks treads on the ground.
    And yet, by *heaven*, I       think            my love as rare
    As any she belied with **false compare**.

![](person.jpg)

I grant I never saw a goddess go;
My mistress when she walks treads on the ground.
    And yet, by heaven, I think my love as rare
    As any she belied with false compare.
```


#########







{type: markua, class: poem, title: "Nothing Like The Sun", whitespace: verbatim}
```
I grant I never saw a goddess go;
My mistress when she walks treads on the ground.
    And yet, by *heaven*, I think my love as rare
    As any she belied with **false compare**.
```


^ needs sugar



sugar list:

```@
aoeu
```


Syntactic sugar following ```:

```
$ - latexmath
@ - asciimath
! - svg
(three tildes => ```text)
(three backticks => ```guess)
& - {type: markua, whitespace: verbatim}
```



[A]

{type: markua, whitespace: verbatim, monospace: false}
{type: markua, class: poem, whitespace: verbatim, monospace: false}
```
I grant I never saw a goddess go;
My mistress when she walks treads on the ground.
    And yet, by *heaven*, I think my love as rare
    As any she belied with **false compare**.
```

```&
aoeu
```












TODO


