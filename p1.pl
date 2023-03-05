% Write a predicate to determine the lowest common multiple of a list formed from integer numbers.
% gcd flow model: (i i i), (i i o)
gcd(A, 0, A):- !.
gcd(A,B,R):- A1 is A mod B, gcd(B,A1,R).
% lcm flow model: (i i i), (i i o)
lcm(X,Y,LCM):- gcd(X,Y,GCD), LCM is X*Y//GCD.
% lcm_of_list flow model: (i i), (i o)
lcm_of_list([],1):- !.
lcm_of_list([H|T],LCM) :- lcm_of_list(T,LCM2), lcm(H,LCM2,LCM).
%  Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … element in a list.
% insert_rec flow model: (i i i i i), (i i i i o)
insert_rec([],_,_,_,[]):- !.
insert_rec([H|T],V,Position,Index,[H,V|R]):- Position =:= Index,
	Position1 is Position*2,
	Index1 is Index+1,
	insert_rec(T,V,Position1,Index1,R),!.
insert_rec([H|T],V,Position,Index,[H|R]):- Position =\= Index,
	Index1 is Index+1,
	insert_rec(T,V,Position,Index1,R).
% insert flow model: (i i i), (i i o)
insert(L,V,R):-insert_rec(L,V,1,1,R).

% Tests
?- gcd(0,100,100).
?- gcd(101,0,101).
?- gcd(100,25,25).
?- gcd(200,150,50).
?- gcd(150,200,50).
?- gcd(7,9,1).

?- lcm(0,10,0).
?- lcm(10,0,0).
?- lcm(10,10,10).
?- lcm(10,11,110).
?- lcm(10,15,30).
?- lcm(7,9,63).

?- lcm_of_list([],1).
?- lcm_of_list([10],10).
?- lcm_of_list([10,10],10).
?- lcm_of_list([10,11],110).
?- lcm_of_list([1,2,3,4,5,6,7,8,9,10],2520).
?- lcm_of_list([10,11,12,13,14,15],60060).

?- insert([1,2,3,4,5,6,7,8,9,10],100,[1,100,2,100,3,4,100,5,6,7,8,100,9,10]).
?- insert([],1,[]).
?- insert([1],1,[1,1]).
?- insert([0,1,2,3],5,[0,5,1,5,2,3,5]).
?- insert([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],0,[1,0,1,0,1,1,0,1,1,1,1,0,1,1,1,1,1,1,1,1,0]).
?- insert([0,1],1,[0,1,1,1]).