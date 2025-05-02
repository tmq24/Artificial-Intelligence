parent(marry, bill).
parent(tom, bill).
parent(tom, liz).
parent(bill, ann).
parent(bill, sue).
parent(sue, jim).

woman(marry).
woman(liz).
woman(sue).
woman(ann).
man(tom).
man(bill).
man(jim).


child(Y, X) :- parent(X, Y).
mother(X, Y) :- parent(X, Y), woman(X).
father(X, Y) :- parent(X, Y), man(X).
grandparent(X, Z) :- parent(X, Y), parent(Y, Z).
sister(X, Y) :- parent(Z, X), parent(Z, Y), woman(X), X \= Y.


/*
Cau 1:
a ?- parent(jim,X).
false.
=> Jim không phải là parent của ai 

b ?- parent(X,jim).
X = sue.
=> Sue là parent của Jim

c ?- parent(marry,X),parent(X,part).
false.
=> Không có ai tên "part" trong cây gia phả

d ?- parent(marry,X),parent(X,Y),parent(Y,jim).
X = bill,
Y = sue.
=> Marry là parent của Bill, Bill là parent của Sue, Sue là parent của Jim

Cau 2:
a. Ai là cha mẹ của Bill?
?- parent(X,bill).
X = marry ;
X = tom.
=> Marry và Tom là parent của Bill

b. Marry có con không?
Cach 1: ?- parent(marry,X).
X = bill.

Cach 2: ?- child(Y,marry).
Y = bill.

=> Marry có con là Bill

c. Ai là ông bà của Sue?
?- grandparent(X,sue).
X = marry ;
X = tom.
=> Marry và Tom là ông bà của Sue

*/