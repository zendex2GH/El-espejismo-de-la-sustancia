; ============================================================
; CAPÍTULO 8 — T5: PARADOJA DEÓNTICA DEL CASTIGO
; ============================================================
(set-option :produce-unsat-cores true)
(set-option :produce-models true)

(declare-sort Agente)
(declare-sort Accion)
(declare-sort Efecto)

(declare-const carcelero Agente)
(declare-const detenido  Agente)
(declare-const encierro  Accion)
(declare-const e_psic   Efecto)    ; daño psicológico
(declare-const e_soc    Efecto)    ; daño social (familia, reincidencia)
(declare-const e_mej    Efecto)    ; mejora conductual

; Predicados primitivos (NINGUNO define la conclusión)
(declare-fun EsEstatal    (Agente) Bool)
(declare-fun Aplica       (Agente Agente Accion) Bool)   ; a aplica ac sobre d
(declare-fun Produce      (Agente Agente Accion Efecto) Bool)
(declare-fun Obligatorio  (Accion Efecto) Bool)         ; ac debe producir e
(declare-fun Prohibido    (Agente Agente Accion Efecto) Bool)

; Dominio
(assert (! (distinct carcelero detenido) :named distinct-agentes))
(assert (! (distinct e_psic e_soc e_mej) :named distinct-efectos))
(assert (! (EsEstatal carcelero) :named dom-estatal))
(assert (! (not (EsEstatal detenido)) :named dom-detenido))

; HECHOS EMPÍRICOS (background sociológico, no tautológicos)
(assert (! (Aplica carcelero detenido encierro) :named h1-aplica))
(assert (! (Produce carcelero detenido encierro e_psic) :named h2-psic))
(assert (! (Produce carcelero detenido encierro e_soc) :named h3-soc))
(assert (! (not (Produce carcelero detenido encierro e_mej)) :named h4-no-mejora))

; AXIOMAS DEÓNTICOS (independientes entre sí)

; A1: Si una acción es obligatoria para un efecto, y el agente la aplica,
;     entonces el sistema exige que ese efecto se produzca.
(assert (! (forall ((a Agente) (d Agente) (ac Accion) (e Efecto))
  (=> (and (Obligatorio ac e) (Aplica a d ac))
      (Produce a d ac e))) :named ax-obligacion-implica-produccion))

; A2: Si un efecto es producido y está prohibido, hay violación deóntica.
(declare-fun Violacion () Bool)
(assert (! (forall ((a Agente) (d Agente) (ac Accion) (e Efecto))
  (=> (and (Prohibido a d ac e) (Produce a d ac e))
      Violacion)) :named ax-prohibicion-viola))

; A3: El encierro está obligado a producir mejora (rehabilitación).
(assert (! (Obligatorio encierro e_mej) :named ax-obliga-rehab))

; A4: El encierro está prohibido de producir daño psicológico iatrogénico.
(assert (! (Prohibido carcelero detenido encierro e_psic) :named ax-prohibe-psic))

; A5: El encierro está prohibido de producir daño social iatrogénico.
(assert (! (Prohibido carcelero detenido encierro e_soc) :named ax-prohibe-soc))

; A6: Compatibilidad estructural: si Produce(a,d,ac,e1) y Produce(a,d,ac,e2),
;     y e1 es daño y e2 es mejora, son mutuamente excluyentes en el modelo.
;     (Esto no es definicional; es una restricción empírica del encierro total).
(assert (! (forall ((a Agente) (d Agente) (ac Accion))
  (=> (and (Produce a d ac e_psic) (Produce a d ac e_mej))
      false)) :named ax-exclusion-psic-mejora))

(assert (! (forall ((a Agente) (d Agente) (ac Accion))
  (=> (and (Produce a d ac e_soc) (Produce a d ac e_mej))
      false)) :named ax-exclusion-soc-mejora))

; ============================================================
; TEOREMA T5: El sistema deóntico del encierro es inconsistente
; ============================================================
(push)
  (assert (! (not Violacion) :named T5-neg-violacion))
  (check-sat)
  (get-unsat-core)
(pop)