; ============================================================
; Lema 2: Contradiccion Iatrogenica
; Instancia minima: si encierro implica daño, y no-daño es axioma,
; entonces AplicaEncierro ∧ NoDano es unsat.
; ============================================================
(set-option :produce-unsat-cores true)

(declare-fun AplicaEncierro () Bool)
(declare-fun CausaDano () Bool)
(declare-fun NoDano () Bool)

; A1: El encierro, tal como lo operan los agentes, causa daño previsible
(assert (! (=> AplicaEncierro CausaDano) :named ax-iatrogenia))

; A2: El axioma fundacional de integridad prohíbe el daño
(assert (! NoDano :named ax-no-dano))

; A3: Definición de daño como contradicción de no-daño
(assert (! (=> CausaDano (not NoDano)) :named ax-def-dano))

(push)
  (echo "===== L2: ¿Es consistente aplicar encierro bajo no-dano? =====")
  (assert (! AplicaEncierro :named hip-aplica))
  (check-sat)
  (get-unsat-core)
(pop)