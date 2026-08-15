% ============================================================
% T7: IMPOSIBILIDAD DE LA RENDICIÓN DE CUENTAS INTERNA
% ============================================================

agente_estatal(a1; a2; a3).
accion_inst(f1; f2; f3).

% Red de favores: clique cerrada
favores(a1, a2). favores(a2, a1).
favores(a2, a3). favores(a3, a2).
favores(a1, a3). favores(a3, a1).

realiza(a1, f1). realiza(a2, f2). realiza(a3, f3).

% Cada acción debe ser vigilada por exactamente un agente
1 { vigila(X, A, F) : agente_estatal(X) } 1 :- realiza(A, F).

% Irreflexividad: nadie se vigila a sí mismo
:- vigila(X, X, F), agente_estatal(X), accion_inst(F).

% Omisión estructural: si hay favores mutuos, no hay vigilancia cruzada
:- vigila(X, Y, F), favores(X, Y), X != Y.

#show vigila/3.