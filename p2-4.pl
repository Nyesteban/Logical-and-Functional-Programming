my_append([],E,[E]).
my_append([H|T],E,[H|R]):- my_append(T,E,R).

my_length([],0).
my_length([_|T],R):- my_length(T,R1), R is R1+1.

inv_list([],[]).
inv_list([H|T],R):- inv_list(T,R1), my_append(R1,H,R).

sum([],[],E,[E]):- E=\=0,!.
sum([],[],0,[]):-!.
sum([H],[],0,[H]):-!.
sum([],[H],0,[H]):-!.
sum([],[H|T],E,[HR|TR]):-
	S is H+E,
	E1 is S div 10,
	HR is S mod 10,
	sum([],T,E1,TR).
sum([H|T],[],E,[HR|TR]):-
	S is H+E,
	E1 is S div 10,
	HR is S mod 10,
	sum(T,[],E1,TR).
sum([H|T],[H1|T1],E,[HR|TR]):-
	S is H+H1+E,
	E1 is S div 10,
	HR is S mod 10,
	sum(T,T1,E1,TR).

sum_lists(L1,L2,R):-
	inv_list(L1,LR1),
	inv_list(L2,LR2),
	sum(LR1,LR2,0,R1), inv_list(R1,R).

heterList([],[]).
heterList([H|T],R):- is_list(H),!,
	heterList(T,R1),
	sum_lists(H,R1,R).
heterList([_|T],R):- heterList(T,R).

% Tests
?- sum_lists([0],[1,0,0],[1,0,0]).
?- sum_lists([9],[9,1],[1,0,0]).
?- sum_lists([9,8,9],[9,9,0],[1,9,7,9]).
?- sum_lists([1,1],[1,9,9],[2,1,0]).
?- sum_lists([1,0,0,0],[1,0,0],[1,1,0,0]).

?- heterList([1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6], [8, 2, 2]).
?- heterList([1,2,3],[]).
?- heterList([[1,0]],[1,0]).
?- heterList([[9,8,9],[9,9,0],10,10,[1]],[1,9,8,0]).
?- heterList([[1,1],[1,9,9]],[2,1,0]).