inserare([], E, [E]).
inserare([H|T], E, [E,H|T]).
inserare([H|T], E, [H|R]) :- 
         inserare(T, E, R).

permutari([], []).
permutari([H|T], R) :-
    permutari(T, RP),
    inserare(RP, H, R).

valid_perm([]).
valid_perm([_]).
valid_perm([H1,H2|T]):-
	Hminus is H1-H2,
	abs(Hminus,Habs),
	Habs =< 3,
	valid_perm([H2|T]).

sol_aux(L,R):-
	permutari(L,R),
	valid_perm(R).

all_perm(L,R):-
	findall(RPartial,permutari(L,RPartial),R).

all_sol(L,R):-
	findall(RPartial,sol_aux(L,RPartial),R).