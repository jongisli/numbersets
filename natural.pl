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
union([],X,X).
union(X,[],X).
union([X1|X1s],[X2|X2s],[X1|X3s]) :-
	less(X1,X2),
	union(X1s,[X2|X2s],X3s).
union([X1|X1s],[X2|X2s],[X2|X3s]) :-
	less(X2,X1),
	union([X1|X1s],X2s,X3s).
union([X|X1s],[X|X2s],[X|X3s]) :-
	union(X1s,X2s,X3s).

% Problem 5: the intersection/3 predicate
intersection([],_,[]).
intersection(_,[],[]).
intersection([X|X1s],[X|X2s],[X|X3s]) :-
	intersection(X1s,X2s,X3s).
intersection([X1|X1s],[X2|X2s],X3) :-
	less(X1,X2),
	intersection(X1s,[X2|X2s],X3).
intersection([X1|X1s],[X2|X2s],X3) :-
	less(X2,X1),
	intersection([X1|X1s],X2s,X3).