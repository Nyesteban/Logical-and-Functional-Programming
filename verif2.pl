f([],[]).
f([H|T],[H|S]):-f(T,S).
f([H|T],S):- H mod 2 =:= 0, f(T,S).