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
    , check_valid_char_list(CharList)
    , atomics_to_string(CharList, Out)
.

% 2

% 3
% convertir una cadena a ascii, desde el ultimo hasta el inicio, voltear el valor y concatenarlos
% transformar (1, "abc", M)
% ascii a :97, b: 98, c:99
% resultado
% "998979"
% 4

