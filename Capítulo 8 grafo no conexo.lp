% Código Clingo: grafo no conexo
% Componente {1,2} con favores, {3} aislado

agente_estatal(1; 2; 3).
accion(1; 2; 3).

realiza(X, X) :- agente_estatal(X).

favores(1, 2). favores(2, 1).

1 { vigila(X, A, F) : agente_estatal(X) } 1 :- realiza(A, F).
:- vigila(X, X, F).
:- vigila(X, Y, F), favores(X, Y).

#show vigila/3.