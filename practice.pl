inserare([], E, [E]).
inserare([H|T], E, [E,H|T]).
inserare([H|T], E, [H|R]) :- 
         inserare(T, E, R).

permutari([], []).
permutari([H|T], R) :-
    permutari(T, RP),
    inserare(RP, H, R).

subset([], []).
subset([E|Tail], [E|R]):-
  subset(Tail, R).
subset([_|Tail], R):-
  subset(Tail, R).

valid_perm([],N,S):-
	N =< 0,
	S1 is S mod 3,
	S1 =:= 0. 
valid_perm([H|T],N,S):-
	H1 is N-1,
	S1 is S+H,
	valid_perm(T,H1,S1).

sol_aux(L,N,R):-
	subset(L,R),
	valid_perm(R,N,0).

all_sol(L,N,R):-
	findall(RPartial,sol_aux(L,N,RPartial),R).