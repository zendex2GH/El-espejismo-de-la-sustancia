% ============================================================
% T7-v2-CF6: VIGILANCIA POSIBLE EN GRAFO NO CONEXO
% Dos componentes: {1,2} con favores mutuos, {3} aislado.
% El agente 3 (sin favores con nadie) puede vigilar a 1 y 2.
% El agente 1 o 2 puede vigilar a 3.
% ============================================================
agente_estatal(1; 2; 3).
accion(1; 2; 3).

% Cada agente realiza una accion
realiza(X, X) :- agente_estatal(X).

% Solo favores entre 1 y 2 (componente conexa)
favores(1, 2). favores(2, 1).

% Completitud: cada accion vigilada por exactamente un agente
1 { vigila(X, A, F) : agente_estatal(X) } 1 :- realiza(A, F).

% Irreflexividad: nadie vigila su propia accion
:- vigila(X, X, F).

% Omision estructural: no se vigila a quien se le debe favores
:- vigila(X, Y, F), favores(X, Y).

#show vigila/3.