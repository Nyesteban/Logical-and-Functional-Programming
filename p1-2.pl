remove_occ(_,[],[]):-!.
remove_occ(E,[H|T],R):- E=:=H, remove_occ(E,T,R),!.
remove_occ(E,[H|T],[H|R]):- E=\=H, remove_occ(E,T,R).

atomcount(_,[],0):-!.
atomcount(E,[H|T],R):- H=:=E, atomcount(E,T,R1), R is R1+1,!.
atomcount(E,[H|T],R):- H=\=E, atomcount(E,T,R).

numberatom([],[]):-!.
numberatom([H|T],[[H,HC]|R]):-atomcount(H,[H|T],HC),
	remove_occ(H,T,R1), 
	numberatom(R1,R).


% Tests

?- remove_occ(3,[1,2,3],[1,2]).
?- remove_occ(1,[1,2,1,1,1,3,1,1],[2,3]).
?- remove_occ(2,[1,2,2,2,1],[1,1]).
?- remove_occ(1,[1,1,1,1,1],[]).
?- remove_occ(1,[1],[]).

?- atomcount(1,[1,2,3],1).
?- atomcount(1,[1,2,1,1,1,3,1,1],6).
?- atomcount(2,[1,2,2,2,1],3).
?- atomcount(1,[1,1,1,1,1],5).
?- atomcount(1,[1],1).

?- numberatom([1,2,3],[[1,1],[2,1],[3,1]]).
?- numberatom([1,2,1,1,1,3,1,1],[[1,6],[2,1],[3,1]]).
?- numberatom([1,2,2,2,1],[[1,2],[2,3]]).
?- numberatom([1,1,1,1,1],[[1,5]]).
?- numberatom([1],[[1,1]]).