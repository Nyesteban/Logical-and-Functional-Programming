mountain([_],1):-!.
mountain([H1,H2|T],0):-
	H1<H2,
	mountain([H2|T],0).
mountain([H1,H2|T],_):-
	H1>H2,
	mountain([H2|T],1).
main_mountain([H1,H2|T]):-
	H1<H2,
	mountain([H1,H2|T],0).
remove_odd([],[]).
remove_odd([H|T],[H|R]):- H mod 2 =:= 0, !, remove_odd(T,R).
remove_odd([_|T],R):- remove_odd(T,R).
heterList([],[]).
heterList([H|T],[HR|R]):- is_list(H), 
	main_mountain(H),!,
	remove_odd(H,HR),
	heterList(T,R).
heterList([H|T],[H|R]):- heterList(T,R).