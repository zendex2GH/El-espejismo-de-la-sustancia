% ============================================================
% Escenario E-v2: EQUILIBRIO PARAMETRICO EN RED DE FAVORES
% Descomentar UNA configuracion
% Correccion: topologia condicional + count vacio robusto
% ============================================================

% CONFIGURACION A: Captura total (clique)
% #const utilidad_privilegio = 5.
% #const utilidad_bien_publico = 1.
% #const costo_ruptura = 2.
% #const topologia = clique.

% CONFIGURACION B: Cooperacion total (clique)
% #const utilidad_privilegio = 2.
% #const utilidad_bien_publico = 2.
% #const costo_ruptura = 10.
% #const topologia = clique.

% CONFIGURACION C: Clique mixta
% #const utilidad_privilegio = 3.
% #const utilidad_bien_publico = 2.
% #const costo_ruptura = 1.
% #const topologia = clique.

% CONFIGURACION D: Estrella (ACTIVA)
#const utilidad_privilegio = 3.
#const utilidad_bien_publico = 2.
#const costo_ruptura = 1.
#const topologia = estrella.

% CONFIGURACION E: Cadena
% #const utilidad_privilegio = 3.
% #const utilidad_bien_publico = 2.
% #const costo_ruptura = 1.
% #const topologia = cadena.

% ============================================================
% MODELO
% ============================================================
agente(a1; a2; a3).

% Definicion condicional de la red de favores
favores(A,B) :- agente(A), agente(B), A != B, topologia = clique.

favores(a1,a2) :- topologia = estrella.
favores(a2,a1) :- topologia = estrella.
favores(a1,a3) :- topologia = estrella.
favores(a3,a1) :- topologia = estrella.

favores(a1,a2) :- topologia = cadena.
favores(a2,a1) :- topologia = cadena.
favores(a2,a3) :- topologia = cadena.
favores(a3,a2) :- topologia = cadena.

% Cada agente elige exactamente una estrategia
1 { elige(A, privilegio); elige(A, bien_publico) } 1 :- agente(A).

% Utilidad bruta segun eleccion
ub(A, utilidad_privilegio) :- elige(A, privilegio).
ub(A, utilidad_bien_publico) :- elige(A, bien_publico).

% CORRECCION ROBUSTA para count vacio en Clingo 6:
% Se determina explicitamente si un agente tiene vecinos desertores.
tiene_desertor(A) :- favores(A,B), elige(B, privilegio).

% Si tiene desertores, se cuentan
num_rupturas(A, R) :- elige(A, bien_publico), tiene_desertor(A),
    R = #count { B : favores(A,B), elige(B, privilegio) }.

% Si NO tiene desertores, las rupturas son 0 (evita el bug del agregado vacio)
num_rupturas(A, 0) :- elige(A, bien_publico), not tiene_desertor(A).

% Quien elige privilegio no paga costos de ruptura
num_rupturas(A, 0) :- elige(A, privilegio).

% Costo = costo_ruptura * numero de rupturas
costo(A, C) :- num_rupturas(A, R), C = costo_ruptura * R.

% Utilidad neta
utilidad_neta(A, U) :- ub(A, UB), costo(A, C), U = UB - C.

% Utilidad total del sistema
utilidad_total(T) :- T = #sum { UN : utilidad_neta(_, UN) }.

% Optimizacion: maximizar utilidad total
#maximize { T : utilidad_total(T) }.

#show elige/2.
#show utilidad_total/1.