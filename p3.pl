% Generate all strings of n parenthesis correctly closed.

parenthesis('(').
parenthesis(')').

% check flow model: (i,i)
check([],0).
check([H|T],C):-
	H == '(',
	C1 is C+1,
	check(T,C1).
check([H|T],C):-
	H == ')',
	C>0,
	C1 is C-1,
	check(T,C1).

% combination flow model: (i,i,i,o)
combination(N,N,C,C):-!.
combination(N,I,C,R):-
	parenthesis(X),
	N1 is I+1,
	combination(N,N1,[X|C],R).

% onesolution flow model: (i,o)
onesolution(N,R):-
	combination(N,0,[],R),
	check(R,0).

% allsolutions flow model: (i,o)
allsolutions(N,R):-
	findall(ResPredicatePartial,onesolution(N,ResPredicatePartial),R).