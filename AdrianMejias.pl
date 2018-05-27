

% Checkear si un string X forma un string S, e indicar cuantas copias son necesarias para formarlo

check_valid_char_list([]).
check_valid_char_list([X | Xs]):-
    caracter_valido(X), check_valid_char_list(Xs)
.


caracter_valido(X):- char_type(X, alpha), !.
caracter_valido(','):-!.
caracter_valido('!'):-!.
caracter_valido('.'):-!.
caracter_valido(':'):-!.
caracter_valido(';'):-!.
caracter_valido('?'):-!.
caracter_valido(' '):-!.

char_list_to_code_list([], []).
char_list_to_code_list([C | Chars], Code):-
    char_list_to_code_list(Chars, NextCode)
    , char_code(C, CodedChar)
    , Code = [CodedChar | NextCode]
.

code_list_to_char_list([], []).
code_list_to_char_list([Code | Codes], Chars):-
    atom_number(Code, Num)
    , char_code(Char, Num)
    , code_list_to_char_list(Codes, NextChars)
    , Chars = [Char | NextChars]
.

reversed_atom_list([],[]).
reversed_atom_list([E | Es], R):-
     number_chars(E, List)
    , reverse(List, Reversed)
    , atomic_list_concat(Reversed, Atom)
    , reversed_atom_list(Es, Rnext)
    , R = [Atom | Rnext]
.

char_list_to_atoms([], []).
char_list_to_atoms(['1' | [D1 | [D2 | Rest]]], AtomList):-
    atomic_list_concat([1, D1, D2], Atom)
    , char_list_to_atoms(Rest, NAtoms)
    , AtomList = [Atom | NAtoms]
    , !
.
char_list_to_atoms([D1 | [D2 | Rest]], AtomList):-
    atomic_list_concat([D1, D2], Atom)
    , char_list_to_atoms(Rest, NAtoms)
    , AtomList = [Atom | NAtoms]
    , !
.
%3 Cifrar y decifrar
%cifrar
transformar(1, Input, Out):-
    string_chars(Input, Chars)
    , check_valid_char_list(Chars)
    , char_list_to_code_list(Chars, Codes)
    , reverse(Codes, Reversed)
    , reversed_atom_list(Reversed, ReversedCodes)
    , atomics_to_string(ReversedCodes, Out)
.

%decifrar
transformar(0, Input, Out):-
    string_chars(Input, Chars)
    , reverse(Chars, Reversed)
    , char_list_to_atoms(Reversed, AtomList)
    , code_list_to_char_list(AtomList, CharList)
    , check_valid_char_list(CharList)
    , atomics_to_string(CharList, Out)
.

%1 periodo

n_periodo("",0):-!.

n_periodo(Input,Out_c):-
    string_chars(Input, Chars)
    , check_valid_char_list(Chars)
    , search_period(Chars,Out_c)
    ,!
    .

search_period([S|Ss],Out_p):-
    view_repet(S,[],Ss,List_r)
    ,check_period([],List_r,[S|Ss],[S|Ss],[],List_r2)
    ,atomic_list_concat(List_r2,B)
    ,string_length(B,A)
    ,Out_p=A
    ,!
    .
%comparar patron contra el string completo
check_period(C,[],[],_,_,C):-!.

check_period([],[A|Aux],[B|Baux],S,W,List_r2):-
    A=B
    ,append(W,[B],X1)
    ,check_period([A],Aux,Baux,S,X1,List_r2)
    ,!
    .
check_period(C,[A|Aux],[B|Baux],S,W,List_r2):-
     A=B
     ,append(C,[A],X)
     ,append(W,[B],X1)
     ,check_period(X,Aux,Baux,S,X1,List_r2)
     ,!.

check_period(C,[],M,S,_,List_r2):-
     atomic_list_concat(C,B)
     ,string_length(B,A)
     ,atomic_list_concat(M,M1)
     ,string_length(M1,W1)
     ,A>W1
     ,List_r2=S
     ,!.

check_period(C,[],M,S,W,List_r2):-
     check_period([],C,M,S,W,List_r2)
     ,!.

check_period([C|_],[A|_],[B|Baux],S,W,List_r2):-
    A\=B
    ,append(W,[B],X1)
    ,view_repet(C,X1,Baux,List_r4)
    ,check_period([],List_r4,S,S,[],List_r2)
    ,!.
check_period([],[A|_],[B|Baux],S,W,List_r2):-
    A\=B
    ,append(W,[B],X1)
    ,view_repet(A,X1,Baux,List_r4)
    ,check_period([],List_r4,S,S,[],List_r2)
    ,!.

%revisar patron
view_repet(Aux,[],[],[Aux]):-!.
view_repet(_,A,[],A):-!.

view_repet(Aux,[],[A|Auxr],Out_r):-
    Aux\=A
    ,view_repet(Aux,[Aux,A],Auxr,Out_r)
    ,!
    .
view_repet(Aux,D,[A|Auxr],Out_r):-
    Aux\=A
    ,append(D,[A],X)
    ,view_repet(Aux,X,Auxr,Out_r)
    ,!
.
view_repet(Aux,[],[A|_],Out_r):-
    Aux=A
    ,Out_r=[Aux]
    ,!.

view_repet(Aux,List,[A|_],Out_r):-
    Aux=A
    ,Out_r=List
    ,!
    .
% 2 ocurrencias
ocurrencias("",0):-!.
ocurrencias(Input,Out):-
    n_periodo(Input,Out_pp)
    ,string_length(Input,Cc)
    ,Out is div(Cc,Out_pp)
    ,!
    .

%4 LCS

lcs([H|Aux],[H|Baux],[H|Lcs]) :-
    !,
    lcs(Aux,Baux,Lcs)
    .

lcs([A|Aux],[B|Baux],Lcs):-
    lcs(Aux ,[B|Baux],Lcs1),
    lcs([A|Aux],Baux ,Lcs2),
    longest(Lcs1,Lcs2,Lcs)
    ,!
    .

lcs(_,_,[]).

longest(A,B,Lcs) :-
    length(A,Length1),
    length(B,Length2),
    ((Length1 > Length2) -> Lcs = A ; Lcs = B)
    .

spy(S1, S2,Lcs,Length):-
    string_chars(S1, C1)
    , string_chars(S2, C2)
    , check_valid_char_list(C1)
    , check_valid_char_list(C2)
    , lcs(C1, C2, R)
    , string_chars(Lcs, R)
    , string_length(Lcs, Length)
    .
