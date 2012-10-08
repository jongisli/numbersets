% Number sets in prolog

% Problem 1: the less/2 predicate
less(z, s(_)).
less(s(X), s(Y)) :- less(X,Y).

% Problem 2: the checkset/1 predicate
checkset([_]).
checkset([X1,X2 | XS]) :- less(X1,X2), checkset([X2|XS]).

% Problem 3: the ismember/3 predicate
ismember(_,[],X2) :- X2 = no.
ismember(X,[X|_],X2) :- X2 = yes.
ismember(X1,[_|XS],X3) :- ismember(X1,XS,X3).

% Problem 4: the union/3 predicate
%union([],X,X) :- true.
%union([X1|X1s],[X2|X2s],[X3|X3s]) :-
