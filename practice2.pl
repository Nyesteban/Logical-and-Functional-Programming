inserare([], E, [E]).
inserare([H|T], E, [E,H|T]).
inserare([H|T], E, [H|R]) :- 
         inserare(T, E, R).

perm([], []).
perm([H|T], R) :-
    perm(T, RP),
    inserare(RP, H, R).
perm([_,T],R):-
    perm(T,R).

subset([], []).
subset([E|Tail], [E|R]):-
  subset(Tail, R).
subset([_|Tail], R):-
  subset(Tail, R).

valid_perm([],N,P,C):-
	N =:= 0,
	P =:= C.
valid_perm([H|T],N,P,C):-
	H1 is N-1,
	C1 is C*H,
	valid_perm(T,H1,P,C1).

sol_aux(L,N,P,R):-
	subset(L,R1),
	perm(R1,R),
	valid_perm(R,N,P,1).

all_perm(L,R):-
	findall(RPartial,perm(L,RPartial),R).

all_sol(L,N,P,R):-
	findall(RPartial,sol_aux(L,N,P,RPartial),R).