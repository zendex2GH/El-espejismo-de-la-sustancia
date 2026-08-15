% Código Clingo: clique de tamaño n
% Verifica que no existe asignación de vigilancia válida.

#const n=3.

agente_estatal(1..n).
accion(1..n).

realiza(X, X) :- agente_estatal(X).

favores(X, Y) :- agente_estatal(X), agente_estatal(Y), X != Y.

1 { vigila(X, A, F) : agente_estatal(X) } 1 :- realiza(A, F).

:- vigila(X, X, F).
:- vigila(X, Y, F), favores(X, Y).

#show vigila/3.