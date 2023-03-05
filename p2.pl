% Determine the successor of a number represented as digits in a list.
% reverse_list flow model: (i, i), (i, o)
reverse_list(L,L1):- reverse_list(L,[],L1).
reverse_list([],ACC,ACC).
reverse_list([X|L],ACC,L1):- reverse_list(L,[X|ACC],L1).
% successor flow model: (i, i), (i, o)
successor(L,L1):- reverse_list(L,L2), 
	successor(L2,1,[],L1),!.
successor([],0,L,L).
successor([],1,L,L1):- successor([],0,[1|L],L1).
successor([H|T],0,L,L1):- successor(T,0,[H|L],L1). 
successor([H|T],1,L,L1):- H =\= 9,
	successor(T,0,[NR|L],L1), NR is H+1.
successor([H|T],1,L,L1):- H =:= 9,
	successor(T,1,[0|L],L1).
% For a heterogeneous list, formed from integer numbers and list of numbers, determine the successor of a sublist considered as a number.
% heterList flow model: (i, i), (i, o)
heterList([],[]).
heterList([H|T], [HR|R]) :- is_list(H), !,
    successor(H, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).

% Tests

?- reverse_list([1,2,3],[3,2,1]).
?- reverse_list([[0,0,1],1],[1,[0,0,1]]).
?- reverse_list([1,2,3,4,5,6,7,8,9,10],[10,9,8,7,6,5,4,3,2,1]).
?- reverse_list([0,0,0,0,0],[0,0,0,0,0]).
?- reverse_list([1],[1]).
?- reverse_list([],[]).

?- successor([1,2,3],[1,2,4]).
?- successor([0],[1]).
?- successor([9],[1,0]).
?- successor([9,9,9],[1,0,0,0]).
?- successor([1,0,0,0],[1,0,0,1]).
?- successor([1,0,9,9],[1,1,0,0]).
?- successor([8,9,9],[9,0,0]).
?- successor([8,8,9],[8,9,0]).

?- heterList([1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6], [1, [2, 4], 4, 5, [6, 8, 0], 10, 11, [1, 2, 1], 6]).
?- heterList([],[]).
?- heterList([1,2,3],[1,2,3]).
?- heterList([1,2,[1,2,3]],[1,2,[1,2,4]]).
?- heterList([[9,9,9],[1,0,0,0],[8,8,9]],[[1,0,0,0],[1,0,0,1],[8,9,0]]).
?- heterList([9,[9]],[9,[1,0]]).