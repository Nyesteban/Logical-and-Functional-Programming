my_length([],C,C).
my_length([_|T],C,R):- NC is C+1, my_length(T,NC,R).

my_append([],E,[E]).
my_append([H|T],E,[H|R]):-
	my_append(T,E,R).

split(L,LC,LC,L):-
	my_length(L,0,RL),
	my_length(LC,0,RLC),
	Diff is RLC-RL,
	abs(Diff,AUX),
	AUX=<1.
split([H|T],LC,Left,Right):-
	my_append(LC,H,RA),
	split(T,RA,Left,Right).

split(L,Left,Right):- split(L,[],Left,Right).

my_merge(L,[],L).
my_merge([],R,R).
my_merge([HL|TL],[HR|TR],[HL|R]) :- HL<HR,
	my_merge(TL,[HR|TR],R).
my_merge([HL|TL],[HR|TR],[HR|R]) :- HL>=HR,
	my_merge([HL|TL],TR,R).

merge_sort([],[]).
merge_sort([E],[E]).
merge_sort(L,R):-
	split(L,Left,Right),
	merge_sort(Left,RL),
	merge_sort(Right,RR),
	my_merge(RL,RR,R).

remove_doubles([],[]).
remove_doubles([E],[E]).
remove_doubles([H1,H2|T],[H1|R]):- H1=\=H2,
	remove_doubles([H2|T],R).
remove_doubles([H1,H2|T],R):- H1=:=H2,
	remove_doubles([H2|T],R).

sort_list(L,R):-
	merge_sort(L,R1),
	remove_doubles(R1,R),!.

heterList([],[]).
heterList([H|T],[HR|R]):- is_list(H),!,
	sort_list(H,HR),
	heterList(T,R).
heterList([H|T],[H|R]):-
	heterList(T,R).

%Tests
?- merge_sort([1,2,5,15,10],[1,2,5,10,15]).
?- merge_sort([1,2,5,10,15],[1,2,5,10,15]).
?- merge_sort([10,9,8,7,6,5,4,3,2,1],[1,2,3,4,5,6,7,8,9,10]).
?- merge_sort([1,1,1],[1,1,1]).
?- merge_sort([2,1,2,1,2,2,1,2],[1,1,1,2,2,2,2,2]).

?- sort_list([1,2,5,15,10],[1,2,5,10,15]).
?- sort_list([1,2,5,10,15],[1,2,5,10,15]).
?- sort_list([10,9,8,7,6,5,4,3,2,1],[1,2,3,4,5,6,7,8,9,10]).
?- sort_list([1,1,1],[1]).
?- sort_list([2,1,2,1,2,2,1,2],[1,2]).

?- heterList([1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7], [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7]).
?- heterList([1,[2,1,2,1,2,2,1,2],3],[1,[1,2],3]).
?- heterList([1,2,3,4,5,6,7,8,9,10],[1,2,3,4,5,6,7,8,9,10]).
?- heterList([[1,2,5,15,10],[1,2,5,10,15],[10,9,8,7,6,5,4,3,2,1]], [[1,2,5,10,15],[1,2,5,10,15],[1,2,3,4,5,6,7,8,9,10]]).
?- heterList([[8,9,8,10,9]],[[8,9,10]]).