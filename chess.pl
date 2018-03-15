commands :-
  write("List of commands:"), nl, nl,
  write("print_coordinates"), nl,
  write("print_board"), nl,
  nl.

print_coordinates :-
  solution(A),
  display_coordinates(A, 1).

print_board :-
  solution(A),
  print_boundry,
  print_columns(A, 1),
  print_column_letters,
  nl.

print_square :- write("| ").
print_queen :- write("|Q").
print_end_quare :- write("|"), nl.
print_boundry :- write("   - - - - - - - - "), nl.
print_column_letters :- write("   h g f e d c b a "), nl.

print_columns([], _).
print_columns([H|T], C) :-
  write(C), write(" "),
  print_row(H, 1),
  C1 is C + 1,
  print_columns(T, C1).

print_row(_, 9) :-
  print_end_quare,
  print_boundry, !.
print_row(X, Col) :-
  X is Col, print_queen,
  Col1 is Col + 1, print_row(X, Col1).
print_row(X, Col) :-
  X =\= Col, print_square,
  Col1 is Col + 1, print_row(X, Col1).

solution(Queens) :-
 permutation([1,2,3,4,5,6,7,8], Queens),
 safe(Queens).

permutation([],[]).
permutation([H|T], P) :-
 permutation(T, P1),
 mydelete(H, P, P1).

mydelete(X, [X|L], L).
mydelete(X, [Y|L], [Y|L1]) :-
 mydelete(X, L, L1).

safe([]).
safe([Queen|Others]) :-
 safe(Others),
 noattack(Queen,Others,1).

noattack(_,[],_).
noattack(Y, [Y1|L], X1) :-
 Y1 - Y =\= X1,
 Y - Y1 =\= X1,
 X2 is X1 + 1,
 noattack(Y, L, X2).

display_coordinates([], 9).
display_coordinates([H|T], Y) :-
  nth1(H, [h,g,f,e,d,c,b,a], X),
  write("["), write(X),
  write(Y), write("]"), nl,
  Y1 is Y + 1,
  display_coordinates(T, Y1).
