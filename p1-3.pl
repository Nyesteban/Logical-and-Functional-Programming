atomcount(_,[],0):-!.
atomcount(E,[H|T],R):- H=:=E, atomcount(E,T,R1), R is R1+1,!.
atomcount(E,[H|T],R):- H=\=E, atomcount(E,T,R).

remove_occ(_,[],[]):-!.
remove_occ(E,[H|T],R):- E=:=H, remove_occ(E,T,R),!.
remove_occ(E,[H|T],[H|R]):- E=\=H, remove_occ(E,T,R).

remove_rep([],[]):-!.
remove_rep([H|T],R):- atomcount(H,[H|T],R1), R1>1, !, remove_occ(H,[H|T],R2), remove_rep(R2,R).
remove_rep([H|T],[H|R]):- remove_rep(T,R).

maxvalue(A,B,A):-A>=B.
maxvalue(A,B,B):-A<B.

maxlist([H],H):-!.
maxlist([H|T],R):- maxlist(T,R1), maxvalue(H,R1,R).

remove_max(L,R):- maxlist(L,R1), remove_occ(R1,L,R),!.

% Tests

?- atomcount(1,[1,2,3],1).
?- atomcount(1,[1,2,1,1,1,3,1,1],6).
?- atomcount(2,[1,2,2,2,1],3).
?- atomcount(1,[1,1,1,1,1],5).
?- atomcount(1,[1],1).

?- remove_rep([1,2,1,4,1,3,4],[2,3]).
?- remove_rep([1,2,1,4,1,3,4,2,3],[]).
?- remove_rep([1,2,3],[1,2,3]).
?- remove_rep([1,2,3,4,5,6,7,8,9,10,1],[2,3,4,5,6,7,8,9,10]).
?- remove_rep([1,2,2,3,3,3,4,4,4,4,5,5,5,5,5,6,6,6,6,6,6,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9,9,10,10,10,10,10,10,10,10,10,10],[1]).

?- maxlist([1,2,3],3).
?- maxlist([1,2,1,1,1,3,1,1],3).
?- maxlist([1,2,2,2,1],2).
?- maxlist([1,1,1,1,1],1).
?- maxlist([1],1).
?- maxlist([1,2,2,3,3,3,4,4,4,4,5,5,5,5,5,6,6,6,6,6,6,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9,9,10,10,10,10,10,10,10,10,10,10],10).

?- remove_max([1,2,3],[1,2]).
?- remove_max([1,2,1,1,1,3,1,1],[1,2,1,1,1,1,1]).
?- remove_max([1,2,2,2,1],[1,1]).
?- remove_max([1,1,1,1,1],[]).
?- remove_max([1],[]).
?- remove_max([1,2,2,3,3,3,4,4,4,4,5,5,5,5,5,6,6,6,6,6,6,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9,9,10,10,10,10,10,10,10,10,10,10],[1,2,2,3,3,3,4,4,4,4,5,5,5,5,5,6,6,6,6,6,6,7,7,7,7,7,7,7,8,8,8,8,8,8,8,8,9,9,9,9,9,9,9,9,9,9]).