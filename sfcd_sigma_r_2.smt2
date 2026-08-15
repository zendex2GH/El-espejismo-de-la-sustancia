;; ┌─────────────────────────────────────────────────────────────┐
;; │  SFCD v2.0 y Σ_R  – Formalización en Z3 (SMT‑LIB2)         │
;; │  Con unsat cores para diagnosticar contradicciones          │
;; │  Ejecutar:  z3 -smt2 sfcd_sigma_r.smt2                     │
;; └─────────────────────────────────────────────────────────────┘

;; Activar generación de núcleos insatisfacibles
(set-option :produce-unsat-cores true)

;; ===========================================================
;; PARTE I: SFCD – Sistema Formal de Coherencia Discursiva
;; ===========================================================

;; --- Dominios (Sortes) ---
(declare-sort Agente)
(declare-sort Norma)
(declare-sort Acto)
(declare-sort Estrato)
(declare-sort Contexto)
(declare-sort Hecho)

;; --- Funciones y predicados ---
(declare-fun Obligatorio (Agente Norma Estrato) Bool)
(declare-fun Prohibido   (Agente Norma Estrato) Bool)
(declare-fun Permitido   (Agente Norma Estrato) Bool)
(declare-fun Competente (Agente Norma Estrato) Bool)
(declare-fun Regula     (Norma Agente Estrato) Bool)
(declare-fun Fuerza        (Acto) Int)
(declare-fun CondFeliz     (Acto Contexto) Bool)
(declare-fun Valido        (Acto Contexto) Bool)
(declare-fun norma_aplicable (Acto) Norma)
(declare-fun emisor        (Acto) Agente)
(declare-fun resultado     (Acto Contexto) Hecho)
(declare-fun CuentaComo         (Hecho Hecho Contexto) Bool)
(declare-fun HechoBruto         (Hecho) Bool)
(declare-fun HechoInstitucional (Hecho) Bool)
(declare-fun RecColectivo       (Hecho Contexto) Bool)
(declare-fun Autoriza      (Norma Norma Estrato Estrato) Bool)
(declare-fun ValidezNorma  (Norma Estrato) Bool)

;; --- Axiomas del SFCD (todos nombrados) ---

(assert (! (forall ((X Hecho) (Y Hecho) (C Contexto))
           (=> (CuentaComo X Y C)
               (and (HechoBruto X) (HechoInstitucional Y))))
       :named ax1-const-institucional))

(assert (! (forall ((X Hecho) (Y Hecho) (C Contexto))
           (=> (CuentaComo X Y C)
               (RecColectivo Y C)))
       :named ax2-rec-colectivo))

(assert (! (forall ((alfa Acto) (C Contexto))
           (=> (= (Fuerza alfa) 0)
               (= (Valido alfa C)
                  (and (CondFeliz alfa C)
                       (exists ((s Estrato))
                          (Competente (emisor alfa) (norma_aplicable alfa) s))))))
       :named ax3-validez-declarativo))

(assert (! (forall ((a Agente) (n Norma) (s Estrato))
           (not (and (Obligatorio a n s) (Prohibido a n s))))
       :named ax4-incompatibilidad-deontica))

(assert (! (forall ((a Agente) (n Norma))
           (=> (exists ((s0 Estrato)) (Regula n a s0))
               (forall ((s2 Estrato)) (not (Competente a n s2)))))
       :named ax5-incompetencia-reflexiva))

(assert (! (forall ((n Norma) (s Estrato))
           (=> (ValidezNorma n s)
               (exists ((n2 Norma) (s2 Estrato))
                  (and (Autoriza n2 n s2 s) (distinct s2 s)))))
       :named ax6-jerarquia-kelseniana))

;; Supuestos de existencia (también nombrados, aunque no afectan los unsat cores)
(assert (! (exists ((a Agente) (n Norma) (s Estrato)) (Obligatorio a n s))
       :named exist-obl))
(assert (! (exists ((a Agente) (n Norma) (s Estrato)) (Competente a n s))
       :named exist-comp))
(assert (! (exists ((a Agente) (n Norma) (s Estrato)) (Regula n a s))
       :named exist-regula))

;; Consistencia del SFCD
(push)
(check-sat)          ; sat
(pop)

;; Teorema: un acto sobre una norma que regula al emisor NO puede ser válido
(push)
(declare-const alfa1 Acto)
(declare-const a1 Agente)
(declare-const n1 Norma)
(declare-const s1 Estrato)
(declare-const c1 Contexto)

(assert (! (= (emisor alfa1) a1) :named teo-juez-emisor))
(assert (! (= (norma_aplicable alfa1) n1) :named teo-juez-norma))
(assert (! (= (Fuerza alfa1) 0) :named teo-juez-fuerza))
(assert (! (Regula n1 a1 s1) :named teo-juez-regula))
(assert (! (CondFeliz alfa1 c1) :named teo-juez-cond))
(assert (! (Valido alfa1 c1) :named teo-juez-querido))

(check-sat)          ; unsat
(get-unsat-core)     ; muestra los axiomas/aserciones que colisionan
(pop)

;; ===========================================================
;; PARTE II: Σ_R – Cálculo de Reificación y Movilización Sacrificial
;; ===========================================================

(declare-sort Entidad)
(declare-sort Prop)

(declare-fun Constituido (Entidad) Bool)
(declare-fun Arbitrario  (Entidad) Bool)
(declare-fun Cree (Agente Prop) Bool)
(declare-fun EsArbitrario_prop       (Entidad) Prop)
(declare-fun Natural_prop            (Entidad) Prop)
(declare-fun CausalidadPropia_prop   (Entidad) Prop)
(declare-fun ViolenciaSimbolica_prop (Entidad Agente) Prop)
(declare-fun Reificado          (Entidad Agente) Bool)
(declare-fun Sagrado            (Entidad Agente) Bool)
(declare-fun ViolenciaSimbolica (Entidad Agente) Bool)
(declare-fun Sacrifica          (Agente Entidad) Bool)

;; --- Axiomas de Σ_R (todos nombrados) ---

(assert (! (forall ((e Entidad)) (Constituido e)) :named sig-A1-constitucion))
(assert (! (forall ((e Entidad)) (Arbitrario e))  :named sig-A2-arbitrariedad))

(assert (! (forall ((e Entidad) (ag Agente))
           (= (Reificado e ag)
              (and (not (Cree ag (EsArbitrario_prop e)))
                   (Cree ag (Natural_prop e))
                   (Cree ag (CausalidadPropia_prop e)))))
       :named sig-A3-reificacion))

(assert (! (forall ((e Entidad) (ag Agente))
           (= (Sagrado e ag) (Reificado e ag)))
       :named sig-A4-sagrado))

(assert (! (forall ((e Entidad) (ag Agente))
           (= (ViolenciaSimbolica e ag)
              (and (Reificado e ag)
                   (not (Cree ag (ViolenciaSimbolica_prop e ag))))))
       :named sig-A5-violencia-simb))

(assert (! (forall ((ag Agente) (e Entidad))
           (=> (Sacrifica ag e) (Sagrado e ag)))
       :named sig-A6-sacrificio-requiere-sagrado))

(assert (! (exists ((e Entidad) (ag Agente)) (Reificado e ag)) :named sig-exist-reif))
(assert (! (exists ((e Entidad) (ag Agente)) (ViolenciaSimbolica e ag)) :named sig-exist-viol))

;; Consistencia de Σ_R
(push)
(check-sat)          ; sat
(pop)

;; Teorema T1: Si un agente cree que e es arbitrario, NO se sacrifica por e.
(push)
(declare-const agT Agente)
(declare-const eT Entidad)
(assert (! (Cree agT (EsArbitrario_prop eT)) :named t1-cree-arbitrario))
(assert (! (Sacrifica agT eT) :named t1-sacrifica))

(check-sat)          ; unsat
(get-unsat-core)     ; muestra los axiomas que impiden el sacrificio
(pop)

;; Final
(exit)