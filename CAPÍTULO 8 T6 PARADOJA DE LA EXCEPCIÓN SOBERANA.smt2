; ============================================================
; T6: PARADOJA DE LA EXCEPCIÓN SOBERANA
; Análogo normativo de la auto-referencia destructiva (Tarski/Curry)
; ============================================================
(set-option :produce-unsat-cores true)
(set-option :produce-models true)

(declare-sort Norma)
(declare-sort Agente)
(declare-sort Situacion)

(declare-const n_universal  Norma)
(declare-const n_excepcion  Norma)
(declare-const e_estado     Agente)
(declare-const x_victima    Agente)
(declare-const s_amenaza    Situacion)

(declare-fun Vinculante     (Norma Agente) Bool)
(declare-fun Suspende       (Agente Norma Norma Situacion Agente) Bool)
(declare-fun Determina      (Agente Situacion) Bool)
(declare-fun Protegido      (Norma Agente) Bool)
(declare-fun Vacia          (Norma) Bool)
(declare-fun EsSoberano     (Agente) Bool)

; Dominio: al menos dos agentes distintos
(assert (! (distinct n_universal n_excepcion) :named distinct-normas))
(assert (! (distinct e_estado x_victima) :named distinct-agentes))

; HECHOS DE DOMINIO
(assert (! (Vinculante n_universal e_estado) :named h1-vincula-univ))
(assert (! (Vinculante n_excepcion e_estado) :named h2-vincula-exc))
(assert (! (EsSoberano e_estado) :named dom-soberano))

; La norma universal pretende proteger a todos los agentes
(assert (! (forall ((x Agente)) (Protegido n_universal x)) :named h3-univ-protege-todos))

; AXIOMAS

; A1: Si un agente soberano determina una situación, puede suspender cualquier
;     norma universal para cualquier agente afectado usando la norma de excepción.
(assert (! (forall ((e Agente) (n_u Norma) (n_e Norma) (s Situacion) (x Agente))
  (=> (and (EsSoberano e) (Vinculante n_u e) (Vinculante n_e e) (Determina e s))
      (Suspende e n_u n_e s x))) :named ax-excepcion-auto-certifica))

; A2: Si una norma universal puede ser suspendida para todo agente
;     en alguna situación, entonces es vacía (carece de efecto protector).
(assert (! (forall ((n_u Norma) (n_e Norma) (e Agente) (s Situacion))
  (=> (forall ((x Agente)) (Suspende e n_u n_e s x))
      (Vacia n_u))) :named ax-suspension-universal-implica-vacio))

; A3: Si una norma es vacía, no protege a ningún agente.
(assert (! (forall ((n Norma) (x Agente))
  (=> (Vacia n) (not (Protegido n x)))) :named ax-vacio-no-protege))

; ============================================================
; T6a: Consistencia del modelo base (sin invocar la excepción)
; ============================================================
(push)
  (echo "===== T6a: Modelo base =====")
  (check-sat)
(pop)

; ============================================================
; T6b: Paradoja — si el soberano determina una amenaza, la norma universal
;      se vacía, contradiciendo su propia pretensión protectora.
; ============================================================
(push)
  (assert (! (Determina e_estado s_amenaza) :named T6b-determina))
  (echo "===== T6b: Paradoja de la excepción soberana =====")
  (check-sat)
  (get-unsat-core)
(pop)