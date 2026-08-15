; ============================================================
; Z3: DEMOSTRACION FORMAL DE LA FALACIA ESTRUCTURAL DEL TEOREMA DE BELL
; ============================================================
; Tesis central: Bell demuestra correctamente que 
;   Realismo ∧ Localidad ∧ DistribucionConjunta → |S| ≤ 2,
;   pero INCORRECTAMENTE infiere ¬(Realismo ∧ Localidad) de 
;   ¬(Realismo ∧ Localidad ∧ DistribucionConjunta).
;   Esto es una falacia logica: requiere el lema no probado
;   (Realismo ∧ Localidad) → DistribucionConjunta.
;   Pitowsky-Fine demostraron que la Distribucion Conjunta se deriva
;   de la Definicion Contracausal (CFD), no de la Localidad.
;   Por tanto, el realista local puede preservar Realismo y Localidad
;   renunciando a la Distribucion Conjunta (modelo contextual).
; ============================================================

(set-option :produce-unsat-cores true)
(set-option :produce-models true)

; -------------------------------------------------------------------
; 1. ONTOLOGIA: compromisos sobre la naturaleza de la realidad
; -------------------------------------------------------------------

; Realismo (R): las particulas poseen propiedades definidas 
; independientemente de ser medidas. Los detectores revelan, no inventan.
(declare-const Realism Bool)

; Localidad (L): la eleccion de eje de medicion en Alice no altera 
; instantaneamente el resultado en Bob. No-senalizacion.
(declare-const Locality Bool)

; Definicion Contracausal (CFD): los experimentos no realizados 
; tienen resultados definidos. Es decir, A y A' existen simultaneamente.
; Nota: Fine (1982) demostro que CFD ⇔ Distribucion Conjunta.
(declare-const CFD Bool)

; Distribucion Conjunta Clasica (DC): existe una unica medida de 
; probabilidad P(A, A', B, B') sobre las 4 variables simultaneas.
; Esta es la herramienta estadistica que Bell impone.
(declare-const JointDist Bool)

; -------------------------------------------------------------------
; 2. EPISTEMOLOGIA: el terreno neutral del estadistico
; -------------------------------------------------------------------

; FourSubexperiments: los datos provienen de 4 corridas fisicamente
; distintas. En cada una solo se miden 2 observables, nunca 4.
; Es el unico objeto empirico comun a realistas y no realistas.
(declare-const FourSubexperiments Bool)

; OnlyDetectorData: el estadistico solo tiene acceso a los registros
; de los medidores (+1/-1), no a "propiedades subyacentes".
(declare-const OnlyDetectorData Bool)

; -------------------------------------------------------------------
; 3. METODOLOGIA: elecciones del modelado estadistico
; -------------------------------------------------------------------

; StatisticianImposesJoint: el estadistico postula una distribucion
; conjunta P(A,A',B,B') como modelo subyacente. 
; NOTA: esto es una ELECCION DE MODELO, no una consecuencia de los datos.
(declare-const StatisticianImposesJoint Bool)

; StatisticianUsesContextual: el estadistico usa 4 distribuciones
; separadas P_ab, P_ab', P_a'b, P_a'b', una por sub-experimento,
; sin postular una quinta distribucion conjunta global.
(declare-const StatisticianUsesContextual Bool)

; -------------------------------------------------------------------
; 4. PARAMETRO EMPIRICO: valor CHSH observado
; -------------------------------------------------------------------
(declare-const S_value Real)

; -------------------------------------------------------------------
; 5. AXIOMAS DEL SISTEMA FORMAL (verdades que aceptamos)
; -------------------------------------------------------------------

; AXIOMA 1 (Metodologico): Si los datos provienen de 4 experimentos
; separados y solo observamos detectores, no hay base empirica para
; postular una distribucion conjunta sobre 4 variables no medidas
; simultaneamente.
(assert (! (=> (and FourSubexperiments OnlyDetectorData)
               (not StatisticianImposesJoint))
         :named A1_NoEmpiricalBasisForJoint))

; AXIOMA 2 (Eleccion de Bell): Bell identifica su modelo formal con
; el realismo local. Pero JointDist es una eleccion metodologica,
; no una consecuencia ontologica.
(assert (! (= JointDist StatisticianImposesJoint)
         :named A2_JointIsMethodologicalChoice))

; AXIOMA 3 (Teorema de Fine): CFD es matematicamente equivalente
; a la existencia de una distribucion de probabilidad conjunta.
(assert (! (= CFD JointDist)
         :named A3_Fine_Equivalence))

; AXIOMA 5 (Teorema de Bell, matematicamente correcto):
; Si se acepta Realismo ∧ Localidad ∧ DistribucionConjunta,
; entonces necesariamente |S| ≤ 2.
(assert (! (=> (and Realism Locality JointDist) (<= S_value 2.0))
         :named A5_CHSH_Correct))

; AXIOMA 6 (Dato experimental): Aspect, Weihs, Hensen et al.
(assert (! (= S_value 2.828) :named A6_Experimental_Data))

; AXIOMA 7 (Modelo Contextual Realista): Un realista local que
; renuncia a la Distribucion Conjunta puede usar un modelo contextual
; (4 distribuciones separadas) que ajusta perfectamente S = 2.828.
; Este axioma captura la posibilidad logica que Bell ignora.
(assert (! (=> (and Realism Locality StatisticianUsesContextual)
               (and (not JointDist) (= S_value 2.828)))
         :named A7_ContextualRealism_FitsData))

; AXIOMA 8 (Exclusion metodologica): el estadistico o impone
; distribucion conjunta o usa modelo contextual, no ambos.
(assert (! (xor StatisticianImposesJoint StatisticianUsesContextual)
         :named A8_MutualExclusion))

; -------------------------------------------------------------------
; 6. LA FALACIA: A4 es la hipotesis cuestionada, NO un axioma global.
; -------------------------------------------------------------------

; Bell asume implicitamente que Realismo ∧ Localidad implica CFD.
; Por Fine (A3), esto equivale a imponer Distribucion Conjunta.
; Definimos A4 como proposicion, pero NO lo asertamos globalmente.
; Lo invocaremos selectivamente para demostrar su efecto destructivo.

(declare-const A4_Bell_Fallacious_Lemma Bool)
(assert (! (= A4_Bell_Fallacious_Lemma (=> (and Realism Locality) CFD))
         :named A4_Definition))

; -------------------------------------------------------------------
; 7. TEOREMAS: Verificaciones de consistencia logica
; -------------------------------------------------------------------

; ============================================================
; TEOREMA 1 (Bell es matematicamente correcto aqui):
; Realismo ∧ Localidad ∧ DistribucionConjunta es INCOMPATIBLE
; con los datos. Z3 debe devolver UNSAT.
; ============================================================
(push)
(assert (! (and Realism Locality JointDist) :named T1_Bell_Target))
(check-sat)
(get-unsat-core)
(pop)

; ============================================================
; TEOREMA 2 (La Falacia expuesta):
; Si insertamos el lema falaz de Bell (A4), entonces Realismo ∧ Localidad
; se vuelve incompatible con los datos. Esta incompatibilidad
; es ARTIFICIAL: surge de A4, no de la fisica.
; Z3 debe devolver UNSAT, mostrando que A4 es la pieza problematica.
; ============================================================
(push)
(assert (! A4_Bell_Fallacious_Lemma :named A4_Invoked))
(assert (! Realism :named R_T2))
(assert (! Locality :named L_T2))
(assert (! A6_Experimental_Data :named Data_T2))
(check-sat)
(get-unsat-core)
(pop)

; ============================================================
; TEOREMA 3 (El escape realista):
; Realismo ∧ Localidad ∧ ModeloContextual ∧ ¬DistribucionConjunta
; ES CONSISTENTE con S = 2.828. 
; Z3 debe devolver SAT con modelo concreto donde R=true, L=true.
; Este es el nucleo de la refutacion a Bell: el realista local
; no esta obligado a usar distribucion conjunta.
; ============================================================
(push)
(assert (! Realism :named R_T3))
(assert (! Locality :named L_T3))
(assert (! StatisticianUsesContextual :named SUC_T3))
(assert (! (not JointDist) :named NotJD_T3))
(assert (! A6_Experimental_Data :named Data_T3))
(check-sat)
(get-model)
(pop)

; ============================================================
; TEOREMA 4 (La neutralidad del estadistico):
; El terreno comun (4 sub-experimentos, solo datos de detectores)
; no fuerza al estadistico a elegir distribucion conjunta.
; Z3 debe devolver SAT con modelo contextual basado puramente en datos.
; ============================================================
(push)
(assert (! FourSubexperiments :named FS_T4))
(assert (! OnlyDetectorData :named ODD_T4))
(assert (! StatisticianUsesContextual :named SUC_T4))
(assert (! (not StatisticianImposesJoint) :named NotSIJ_T4))
(check-sat)
(get-model)
(pop)

; ============================================================
; TEOREMA 5 (Realismo local sin el lema de Bell):
; Si removemos A4, Realismo ∧ Localidad es perfectamente viable
; con los datos. Z3 debe devolver SAT.
; El modelo forzado por la estructura axiomatica usara SUC=true.
; ============================================================
(push)
(assert (! Realism :named R_T5))
(assert (! Locality :named L_T5))
(assert (! A6_Experimental_Data :named Data_T5))
(check-sat)
(get-model)
(pop)

; ============================================================
; TEOREMA 6 (La estructura logica de la falacia):
; Formalizamos que aceptar ¬(R∧L∧DC) y mantener R∧L es consistente.
; Bell razona: ¬(R∧L∧DC) ∧ (R∧L) ⊢ ¬(R∧L)
; Esto es invalido logicamente a menos que se asuma (R∧L)→DC.
; Demostramos que sin esa implicacion, no hay contradiccion.
; ============================================================
(push)
(assert (! (not (and Realism Locality JointDist)) :named NotRLJD_T6))
(assert (! Realism :named R_T6))
(assert (! Locality :named L_T6))
(assert (! A6_Experimental_Data :named Data_T6))
(check-sat)
(get-model)
(pop)

; ============================================================
; TEOREMA 7 (Pitowsky-Fine como desactivador de la falacia):
; Si aceptamos Fine (A3) y RECHAZAMOS explicitamente el lema de Bell,
; entonces el realista local puede preservar todos sus compromisos
; ontologicos usando modelo contextual.
; ============================================================
(push)
(assert (! (not A4_Bell_Fallacious_Lemma) :named NotA4_T7))
(assert (! Realism :named R_T7))
(assert (! Locality :named L_T7))
(assert (! StatisticianUsesContextual :named SUC_T7))
(assert (! A6_Experimental_Data :named Data_T7))
(check-sat)
(get-model)
(pop)