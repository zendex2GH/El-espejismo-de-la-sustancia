% ============================================================
% T7-v2: IMPOSIBILIDAD EN CLIQUES DE TAMAÑO N
% Parametrizable: cambiar #const n
% ============================================================
#const n=5.

agente_estatal(1..n).
accion(1..n).

% Cada agente realiza exactamente una accion distinta
realiza(X, X) :- agente_estatal(X).

% Clique completa: todo par de agentes distintos tiene favores mutuos
favores(X, Y) :- agente_estatal(X), agente_estatal(Y), X != Y.

% Completitud: cada accion debe ser vigilada por exactamente un agente
1 { vigila(X, A, F) : agente_estatal(X) } 1 :- realiza(A, F).

% Irreflexividad: nadie vigila su propia accion
:- vigila(X, X, F).

% Omision estructural: no se vigila a quien se le debe favores
:- vigila(X, Y, F), favores(X, Y).

#show vigila/3.