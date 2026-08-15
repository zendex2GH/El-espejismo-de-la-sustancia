% ============================================================
% CLINGO: DINAMICA EPISTEMICA DE LA FALACIA DE BELL (v2)
% ============================================================
% Mejora sustancial: compromisos ontológicos declarados y 
% restricciones de coherencia. Demuestra que contextual_model
% es la UNICA opcion para el realista local que prioriza 
% tanto realismo como localidad.
% ============================================================

#const t_max = 3.

% ------------------------------------------------------------
% 0. TIEMPO
% ------------------------------------------------------------
time(0..t_max).

% ------------------------------------------------------------
% 1. AGENTES con compromisos ontológicos declarados
% ------------------------------------------------------------
% locality_first_realists: realistas que PRIORIZAN LOCALIDAD.
%    No aceptan accion a distancia. Deben preservar no-señalizacion.
% realism_first_realists: realistas que PRIORIZAN ONTOLOGIA FUERTE.
%    Aceptan renunciar a localidad si preservan valores definidos.
% bellian_orthodox: defensores del modelo conjunto de Bell.
% epistemic_pragmatists: pragmáticos, no postulan valores preexistentes.
% experimental_neutrals: solo se fijan en los datos de detectores.

agent(locality_first_realists).
agent(realism_first_realists).
agent(bellian_orthodox).
agent(epistemic_pragmatists).
agent(experimental_neutrals).

% ------------------------------------------------------------
% 2. COMPROMISOS ONTOLOGICOS
% ------------------------------------------------------------
% Cada agente declara qué principios defiende:
commitment(locality).
commitment(realism).

commits_to(locality_first_realists, locality).
commits_to(locality_first_realists, realism).

commits_to(realism_first_realists, realism).

commits_to(bellian_orthodox, realism).
commits_to(bellian_orthodox, locality).

commits_to(epistemic_pragmatists, locality).

% experimental_neutrals no declaran compromisos ontológicos previos.

% ------------------------------------------------------------
% 3. MODELOS ESTADISTICOS y sus propiedades
% ------------------------------------------------------------
model(joint_model).
model(contextual_model).
model(epistemic_model).
model(bohm_model).

% Propiedades de cada modelo:
% - violates_locality: el modelo postula accion a distancia
% - violates_realism: el modelo niega valores definidos pre-medicion
% - requires_CFD: el modelo exige Definicion Contracausal
% - fits_data_S2828: el modelo ajusta S=2.828

model_property(joint_model, requires_CFD).
model_property(joint_model, fits_data_S2828, no).

model_property(contextual_model, fits_data_S2828, yes).
% contextual NO viola locality ni realism: es realista local sin CFD

model_property(epistemic_model, violates_realism).
model_property(epistemic_model, fits_data_S2828, yes).

model_property(bohm_model, violates_locality).
model_property(bohm_model, fits_data_S2828, yes).

% ------------------------------------------------------------
% 4. EVIDENCIA HISTORICA
% ------------------------------------------------------------
evidence(four_subexperiments, 1).
evidence(fine_theorem, 2).
evidence(contextual_fit, 3).

% ------------------------------------------------------------
% 5. SATELITES (mecanismos de reificacion)
% ------------------------------------------------------------
satellite(idealization).
satellite(naturalization).
satellite(personification).

% ------------------------------------------------------------
% 6. ESTADO INICIAL: todos en joint_model (ortodoxia previa)
% ------------------------------------------------------------
holds(A, joint_model, 0) :- agent(A).

% ------------------------------------------------------------
% 7. DINAMICA DE TRANSICION
% ------------------------------------------------------------
{ holds(A, M, T) : model(M) } = 1 :- agent(A), time(T), T >= 1.

% ------------------------------------------------------------
% 8. RESTRICCIONES DE COHERENCIA ONTOLOGICA (nucleo sustancial)
% ------------------------------------------------------------

% R8.1: Si un agente se compromete con LOCALITY, NO puede adoptar
%       un modelo que viole locality (ej: bohm_model).
:- holds(A, M, T), commits_to(A, locality), model_property(M, violates_locality), time(T), T >= 1.

% R8.2: Si un agente se compromete con REALISM, NO puede adoptar
%       un modelo que viole realism (ej: epistemic_model).
:- holds(A, M, T), commits_to(A, realism), model_property(M, violates_realism), time(T), T >= 1.

% R8.3: El modelo joint_model requiere CFD. Despues de t=1, mantenerlo
%       sin justificacion adicional es insostenible.
satellite_active(A, idealization, T) :-
    holds(A, joint_model, T), evidence(four_subexperiments, TE), TE <= T, time(T).

satellite_active(A, naturalization, T) :-
    holds(A, joint_model, T), evidence(fine_theorem, TE), TE <= T, time(T).

satellite_active(A, personification, T) :-
    holds(A, joint_model, T), time(T).

% R8.4: Sostenibilidad de joint_model
:- holds(A, joint_model, T), time(T), T >= 1,
   evidence(four_subexperiments, TE), TE <= T,
   #count { S : satellite_active(A, S, T) } < 2.

:- holds(A, joint_model, T), time(T), T >= 2,
   evidence(fine_theorem, TE), TE <= T,
   #count { S : satellite_active(A, S, T) } < 3.

% ------------------------------------------------------------
% 9. METRICAS
% ------------------------------------------------------------

changed(A, T) :- time(T), T > 0, holds(A, M, T), holds(A, M2, T-1), M != M2.

crisis(T) :- time(T), T > 0, #count { A : changed(A, T) } >= 2.

fragmentation(T) :- time(T), #count { M : holds(A, M, T), agent(A) } >= 3.

stabilized(A) :- agent(A), holds(A, M, 2), changed(A, 2), holds(A, M, 3).

% Costo ontológico: satelites activos (entidades no medidas postuladas)
ontological_cost(A, T, C) :- agent(A), time(T),
    C = #count { S : satellite_active(A, S, T) }.

% Ajuste empirico: 1 si ajusta S=2.828
empirical_fit(A, T, 1) :- holds(A, M, T), model_property(M, fits_data_S2828, yes).
empirical_fit(A, T, 0) :- holds(A, M, T), model_property(M, fits_data_S2828, no).

% Costo de violacion de compromiso (nuevo, sustancial)
commitment_violation(A, T) :- holds(A, M, T), commits_to(A, C), model_property(M, violates_C),
    violation_property(C, violates_C).

violation_property(locality, violates_locality).
violation_property(realism, violates_realism).

% ------------------------------------------------------------
% 10. DINAMICA HISTORICA MINIMA
% ------------------------------------------------------------
:- not crisis(1).
:- not fragmentation(2).
:- #count { A : stabilized(A) } = 0.

% ------------------------------------------------------------
% 11. OPTIMIZACION MULTIOBJETIVO
% ------------------------------------------------------------
% Prioridad 1 (peso 4): minimizar costo ontológico (satelites)
% Prioridad 2 (peso 3): minimizar uso de joint_model post-t=0
% Prioridad 3 (peso 2): maximizar ajuste empirico
% Prioridad 4 (peso 1): minimizar violaciones de compromiso
% Prioridad 5 (peso 0): minimizar cambios bruscos

#minimize { C@4, A, T : ontological_cost(A, T, C) }.
#minimize { 1@3, A, T : holds(A, joint_model, T), T >= 1 }.
#maximize { F@2, A, T : empirical_fit(A, T, F) }.
#minimize { 1@1, A, T : commitment_violation(A, T) }.
#minimize { 1@0, A, T : changed(A, T) }.

% ------------------------------------------------------------
% 12. OUTPUT
% ------------------------------------------------------------
#show holds/3.
#show crisis/1.
#show fragmentation/1.
#show changed/2.
#show ontological_cost/3.
#show empirical_fit/3.
#show commitment_violation/2.


