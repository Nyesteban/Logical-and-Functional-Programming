rem_inc([],[]).
rem_inc([H],[H]).
rem_inc([H1,H2],[]):- H1 < H2.
rem_inc([H1,H2|T],[H1|R]):- H1>=H2, rem_inc([H2|T],R).
rem_inc([H1,H2,H3|T],R):- H1<H2, H2<H3, rem_inc([H2,H3|T],R).
rem_inc([H1,H2,H3|T],R):- H1<H2, H2>=H3, rem_inc([H3|T],R).
heterList([],[]).
heterList([H|T],[HR|R]):- is_list(H),!,
	rem_inc(H,HR),
	heterList(T,R).
heterList([H|T],[H|R]):- heterList(T,R).