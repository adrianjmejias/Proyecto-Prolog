

% Checkear si un string X forma un string S, e indicar cuantas copias son necesarias para formarlo

% n_periodo()

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
% 2
ocurrencias("",0):-!.
ocurrencias(Input,Out):-
    n_periodo(Input,Out_pp)
    ,string_length(Input,Cc)
    ,Out is div(Cc,Out_pp)
    ,!.



% 3
% convertir una cadena a ascii, desde el ultimo hasta el inicio, voltear el valor y concatenarlos
% transformar (1, "abc", M)
% ascii a :97, b: 98, c:99
% resultado
% "998979"
% 4

