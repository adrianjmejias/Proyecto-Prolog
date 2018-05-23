% predecesor(guillermo, veronica).
% predecesor(guillermo, lucia).
% predecesor(veronica, maria).
% predecesor(veronica, ruben).
% predecesor(veronica, rubensote).
% predecesor(veronica, rubensito).
% predecesor(ruben, rafael).
% predecesor(ruben, carolina).
% predecesor(yo, tu).
% anterior(X,Y):- predecesor(X,Y).
% anterior(X,Y):- predecesor(X,Z), anterior(Z,Y).
% hermanos(X,Y):- predecesor(Z,X), predecesor(Z,Y).

% n(0).
% n(s(X)):- n(X).
% m(0,s(Y)):- n(Y).
% m(s(X),s(Y)) :- m(X,Y).

%[1,2,3,4,5,6,7,8,9]
head([X | _], X).

tail([], []).
tail([_ | Xs], Xs).

last([R | []], R).
last([_ | Xs], R) :- last(Xs, R).

test(X, R):- [X | R];

init([], []).
init([_], []).
init([X | Xs], R) :- init(Xs, Rnext)
    , R is [X | Rnext].


aelem(E, [E | _]).
aelem(E, [_ | Es]) :- aelem(E, Es).

alength([], 0).
alength([_ | Xs], N) :- alength(Xs, M)
    , N is M +1
    .

