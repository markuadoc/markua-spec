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
