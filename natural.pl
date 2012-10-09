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


:- begin_tests(natural).
:- use_module(natural).
% Testing 1.
test(less_succeed) :- less(z, s(z)).
test(less_fail, fail) :- less(s(z), z).
test(less_derive, all(X == [z,s(z)])) :- less(X, s(s(z))).

% Testing 2.
test(checkset_succeed) :- checkset([s(z), s(s(s(z))), s(s(s(s(s(z)))))]).
test(checkset_fail1, fail) :- checkset([s(s(s(z))), s(s(s(s(s(z))))), s(z)]).
test(checkset_fail2, fail) :- checkset([z,z]).
test(checkset_fail3, fail) :- checkset(z).
test(checkset_derive, all(X == [z, s(z)])) :- checkset([X, s(s(z)), s(s(s(z)))]).

% Testing 3.
test(ismember_succeed) :- ismember(s(z), [z, s(z)], yes).
test(ismember_fail, fail) :- ismember(s(s(z)), [z, s(z)], yes).
%test(ismember_derive) :- ismember(N, [s(z), s(s(s(z)))], A).

% Testing 4.
test(union_succeed) :- union([z, s(s(z))], [s(z), s(s(z))], [z, s(z), s(s(z))]).
test(union_fail, fail) :- union([z, s(s(z))], [z, s(s(z))], [z, s(z), s(s(z))]).
test(union_derive, all(X = [[z], [z,s(z)], [z,s(z)]])) :- % same answer twice
	union(X, [s(z)], [z,s(z)]). 

% Testing 5.
test(intersection_succeed) :-
	intersection([z,s(s(z))], [s(s(z)), s(s(s(z)))], [s(s(z))]).
test(intersection_fail, fail) :-
	intersection([z,s(s(z))], [s(s(z)), s(s(s(z)))], [z, s(s(z))]).
test(intersection_derive, all(A == [[]])) :- intersection([z], [s(z)], A).

:- end_tests(natural).