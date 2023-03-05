my_merge(L,[],L).
my_merge([],R,R).
my_merge([HL|TL],[HR|TR],[HL|R]) :- HL<HR,
	my_merge(TL,[HR|TR],R).
my_merge([HL|TL],[HR|TR],[HR|R]) :- HL>HR,
	my_merge([HL|TL],TR,R).
my_merge([HL|TL],[HR|TR],R) :- HL=:=HR,
	my_merge([HL|TL],TR,R).

remove_doubles([],[]).
remove_doubles([E],[E]).
remove_doubles([H1,H2|T],[H1|R]):- H1=\=H2,
	remove_doubles([H2|T],R).
remove_doubles([H1,H2|T],R):- H1=:=H2,
	remove_doubles([H2|T],R).

merge_no_doubles(L1,L2,R):- 
	my_merge(L1,L2,R1), remove_doubles(R1,R).

heterList([],[]).
heterList([H|T],R):- is_list(H),!,
	heterList(T,RH),
	my_merge(H,RH,R).
heterList([_|T],R):- heterList(T,R).

% Tests
?- merge_no_doubles([1,1,2,3,3],[10,10,11],[1,2,3,10,11]).
?- merge_no_doubles([1],[1,2],[1,2]).
?- merge_no_doubles([1,2],[1],[1,2]).
?- merge_no_doubles([1,1,1],[2,2,2],[1,2]).
?- merge_no_doubles([1,3,5,7,9],[2,4,6,8,10],[1,2,3,4,5,6,7,8,9,10]).

?- heterList([1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8], [1, 2, 3, 4, 6, 7, 9, 10, 11]).
?- heterList([1,[1,2,3],3],[1,2,3]).
?- heterList([[1,2,3,4,5,6,7,8,9,10]],[1,2,3,4,5,6,7,8,9,10]).
?- heterList([],[]).
?- heterList([10],[]).