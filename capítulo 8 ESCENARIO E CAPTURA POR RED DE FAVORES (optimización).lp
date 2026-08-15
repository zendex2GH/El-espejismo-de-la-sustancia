% ============================================================
% ESCENARIO E: CAPTURA POR RED DE FAVORES (versión corregida)
% ============================================================

agente_estatal(a1; a2; a3).
ciudadano(c1; c2; c3).
recurso(impuestos).

aporta(c1, impuestos). aporta(c2, impuestos). aporta(c3, impuestos).

% RED DE FAVORES: clique cerrada entre agentes estatales
favores(a1, a2). favores(a2, a1).
favores(a1, a3). favores(a3, a1).
favores(a2, a3). favores(a3, a2).

% Los ciudadanos aportan impuestos que los agentes reciben
recibe(A, impuestos) :- agente_estatal(A), aporta(_, impuestos).

% Cada agente estatal decide: privilegio propio o bien público
usa(A, privilegio) | usa(A, bien_publico) :- agente_estatal(A), recibe(A, impuestos).

% Si A usa bien público y B usa privilegio, y hay favores entre ellos, A rompe la red
rompe_favores(A, B) :- usa(A, bien_publico), usa(B, privilegio), favores(A, B).

% Captura del estado: se da cuando todos los agentes estatales eligen privilegio
captura :- usa(A, privilegio) : agente_estatal(A).

% WEAK CONSTRAINTS: Energía estructural
% Prioridad 2: romper favores cuesta 5 (mantiene coherencia de la red)
:~ rompe_favores(A, B), agente_estatal(A), agente_estatal(B). [5@2]

% Prioridad 1: usar para bien público cuesta 3; usar para privilegio cuesta 1
:~ usa(A, bien_publico), agente_estatal(A). [3@1]
:~ usa(A, privilegio), agente_estatal(A). [1@1]

#show usa/2. #show captura/0. #show rompe_favores/2.