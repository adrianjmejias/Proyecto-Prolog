% Checkear si un string X forma un string S, e indicar cuantas copias son necesarias para formarlo

% n_periodo()

caracter_valido(X):- X >= "A", X =< "Z", !.
caracter_valido(X):- X >= "a", X =< "z", !.
caracter_valido('!'):-!.
caracter_valido(','):-!.
caracter_valido(':'):-!.
caracter_valido(':'):-!.
caracter_valido(';'):-!.
caracter_valido('?'):-!.
caracter_valido(' '):-!.

reversed_num_list([],[]).
reversed_num_list([E | Es], R):- 
    caracter_valido(E)
    , number_chars(E, List)
    , reverse(List, Reversed)
    , atomic_list_concat(Reversed, Atom)
    , reversed_num_list(Es, Rnext)
    , atom_number(Atom, Num)
    , R = [Num | Rnext]
    .

%cifrar
transformar(1, Input, Out):- 
    atom_codes(Input, Atoms)
    , reverse(Atoms, Reversed)
    %Aca tengo que hacer validacion y reverse de los caracteres en la lista
    , reversed_num_list(Reversed, AsciiReversed)
    , atomic_list_concat(AsciiReversed, '', Aux)
    , atom_string(Aux, Out)
    .
%cifrar
transformar(0, S, M).
% 2

% 3
% convertir una cadena a ascii, desde el ultimo hasta el inicio, voltear el valor y concatenarlos
% transformar (1, "abc", M)
% ascii a :97, b: 98, c:99
% resultado
% "998979"
% 4

