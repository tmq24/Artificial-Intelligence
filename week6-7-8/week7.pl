herbivores(goat).
ferocious_animals(wolf).

carnivores(X) :- ferocious_animals(X).
eat(X,meat) :- carnivores(X).
eat(X,grass) :- herbivores(X).
eat(X,Y) :- carnivores(X), herbivores(Y).
drink(X,water) :- herbivores(X).
drink(X,water) :- carnivores(X).
consume(X,Y) :- eat(X,Y).
consume(X,Y) :- drink(X,Y).

/*
Cau hoi: co dong vat hung du khong va no tieu thu gi?
?- ferocious_animals(X), consume(X,Y).
X = wolf,
Y = meat ;
X = wolf,
Y = goat ;
X = wolf,
Y = water.

=> Dong vat hung du la wolf va no tieu thu meat, goat, water.
*/