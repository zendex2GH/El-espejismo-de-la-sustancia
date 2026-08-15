; ============================================================
; T6-v2: JERARQUIA DE PARADOJAS DE LA EXCEPCION SOBERANA
; ============================================================
(set-option :produce-unsat-cores true)

(declare-datatypes ((Rama 0)) ((ejecutivo legislativo judicial observador)))
(declare-datatypes ((Norma 0)) ((n_universal n_excepcion)))
(declare-datatypes ((Agente 0)) ((a1 a2 a3)))
(declare-datatypes ((Situacion 0)) ((s_amenaza s_normal)))

(declare-fun Determina (Rama Situacion) Bool)
(declare-fun Suspende (Rama Norma Norma Situacion Agente) Bool)
(declare-fun Vacia (Norma) Bool)
(declare-fun Capturada (Rama) Bool)
(declare-fun Protegido (Norma Agente) Bool)

; A1: Si una norma puede ser suspendida para todo agente por alguna rama,
;     entonces es vacia
(assert (! (forall ((r Rama) (s Situacion))
  (=> (forall ((x Agente)) (Suspende r n_universal n_excepcion s x))
      (Vacia n_universal))) :named ax-suspension-universal-vacia))

; A2: Norma vacia no protege
(assert (! (forall ((n Norma) (x Agente))
  (=> (Vacia n) (not (Protegido n x)))) :named ax-vacio-no-protege))

; A3: Colusion: si las 3 ramas internas estan capturadas, determinacion de una implica las otras
(assert (! (forall ((s Situacion))
  (=> (and (Capturada ejecutivo) (Capturada legislativo) (Capturada judicial)
           (Determina ejecutivo s))
      (and (Determina legislativo s) (Determina judicial s)))) :named ax-colusion))

; HECHO: n_universal protege a los agentes (no es vacia inicialmente)
(assert (! (forall ((x Agente)) (Protegido n_universal x)) :named h-universal-protege))

; ============================================================
; T6a-v2: AUTO-CERTIFICACION UNILATERAL
; Arquitectura: una sola rama que determina puede suspender para todo agente
; ============================================================
(push)
  (echo "===== T6a-v2: Auto-certificacion unilateral =====")
  (assert (! (forall ((x Agente))
    (=> (Determina ejecutivo s_amenaza)
        (Suspende ejecutivo n_universal n_excepcion s_amenaza x))) :named ax-t6a-unilateral))
  
  (assert (! (Determina ejecutivo s_amenaza) :named h-amenaza-ejec))
  (assert (! (not (Vacia n_universal)) :named hip-no-vacia))
  (check-sat)
  (get-unsat-core)
(pop)

; ============================================================
; T6b-v2: SEPARACION DE PODERES SIN CAPTURA
; Arquitectura: suspension requiere consenso de 3 ramas.
; Ejecutivo determina, pero las otras no (no hay colusion).
; La excepcion no se activa. La norma universal se preserva.
; ============================================================
(push)
  (echo "===== T6b-v2: Separacion de poderes sin captura =====")
  (assert (! (forall ((x Agente))
    (=> (and (Determina ejecutivo s_amenaza) (Determina legislativo s_amenaza) (Determina judicial s_amenaza))
        (Suspende ejecutivo n_universal n_excepcion s_amenaza x))) :named ax-t6b-consenso))
  
  (assert (! (not (Capturada ejecutivo)) :named cf5-no-captura-ejec))
  (assert (! (not (Capturada legislativo)) :named cf5-no-captura-leg))
  (assert (! (not (Capturada judicial)) :named cf5-no-captura-jud))
  
  (assert (! (Determina ejecutivo s_amenaza) :named h-amenaza-ejec-b))
  (assert (! (not (Vacia n_universal)) :named hip-no-vacia-b))
  (check-sat)
  (get-unsat-core)
(pop)

; ============================================================
; T6b-captura: SEPARACION DE PODERES CON COLUSION
; Las 3 ramas estan capturadas. Ejecutivo determina -> por colusion, las 3 determinan.
; El consenso se activa. La excepcion es universal. Colapsa a unilateral.
; ============================================================
(push)
  (echo "===== T6b-captura: Separacion con captura total =====")
  (assert (! (forall ((x Agente))
    (=> (and (Determina ejecutivo s_amenaza) (Determina legislativo s_amenaza) (Determina judicial s_amenaza))
        (Suspende ejecutivo n_universal n_excepcion s_amenaza x))) :named ax-t6b-consenso-c))
  
  (assert (! (Capturada ejecutivo) :named h-captura-ejec))
  (assert (! (Capturada legislativo) :named h-captura-leg))
  (assert (! (Capturada judicial) :named h-captura-jud))
  (assert (! (Determina ejecutivo s_amenaza) :named h-amenaza-ejec-c))
  
  (assert (! (not (Vacia n_universal)) :named hip-no-vacia-c))
  (check-sat)
  (get-unsat-core)
(pop)

; ============================================================
; T6c-v2: OBSERVADOR EXTERNO
; Arquitectura: suspension requiere ejecutivo + observador.
; Ejecutivo determina (y esta capturado), pero observador no determina.
; La excepcion no se activa. La norma universal se preserva.
; ============================================================
(push)
  (echo "===== T6c-v2: Observador externo no determina =====")
  (assert (! (forall ((x Agente))
    (=> (and (Determina ejecutivo s_amenaza) (Determina observador s_amenaza))
        (Suspende ejecutivo n_universal n_excepcion s_amenaza x))) :named ax-t6c-observador))
  
  (assert (! (Capturada ejecutivo) :named h-captura-ejec-d))
  (assert (! (Capturada legislativo) :named h-captura-leg-d))
  (assert (! (Capturada judicial) :named h-captura-jud-d))
  (assert (! (Determina ejecutivo s_amenaza) :named h-amenaza-ejec-d))
  (assert (! (not (Determina observador s_amenaza)) :named h-observador-no))
  
  (assert (! (not (Vacia n_universal)) :named hip-no-vacia-d))
  (check-sat)
  (get-unsat-core)
(pop)