my_insert([],L,L).
my_insert([H|T],L,[H|R]):- my_insert(T,L,R).

substitute_elem([],_,_,[]).
substitute_elem([H|T],E,L,R):- H=:=E,
	my_insert(L,T,R1),
	substitute_elem(R1,E,L,R).
substitute_elem([H|T],E,L,[H|R]):- H=\=E,
	substitute_elem(T,E,L,R).

heterList([],_,[]).
heterList([[H|HT]|T],E,[HR|R]):-
	substitute_elem([H|HT],H,E,HR),
	heterList(T,E,R).
heterList([H|T],E,[H|R]):- number(H),
	heterList(T,E,R).

% Tests
?- substitute_elem([1,2,1,3,1,4],1,[10,11],[10,11,2,10,11,3,10,11,4]).
?- substitute_elem([1,2,3],10,[1],[1,2,3]).
?- substitute_elem([1,2,3],1,[2],[2,2,3]).
?- substitute_elem([1,2,3,1,1],1,[2,0,0],[2,0,0,2,3,2,0,0,2,0,0]).
?- substitute_elem([1],1,[10],[10]).

?- heterList([1, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7], [11, 11], [1, [11, 11, 1, 11, 11], 3, 6, [11, 11, 10, 1, 3, 9], 5, [11, 11, 11, 11, 11, 11], 7]).
?- heterList([1],[1],[1]).
?- heterList([[1,2]],[2],[[2,2]]).
?- heterList([10,[10,10,11],10],[11,12],[10,[11,12,11,12,11],10]).
?- heterList([[1]],[10],[[10]]).