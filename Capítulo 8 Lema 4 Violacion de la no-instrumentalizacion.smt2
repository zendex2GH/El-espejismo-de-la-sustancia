; ============================================================
; Lema 4: Violacion de la no-instrumentalizacion
; Instancia: un detenido x, una accion de exhibicion, un fin social f.
; Si la accion usa a x como medio para f, y no-instrumentalizacion
; prohibe eso, entonces el sistema es inconsistente.
; ============================================================
(set-option :produce-unsat-cores true)

(declare-datatypes ((Persona 0)) ((x_detenido z_ciudadano)))
(declare-datatypes ((Accion 0)) ((a_exhibicion)))
(declare-datatypes ((Fin 0)) ((f_disciplinamiento)))

(declare-fun Realiza (Persona Accion) Bool)
(declare-fun FinDe (Accion Fin) Bool)
(declare-fun Medio (Persona Fin) Bool)
(declare-fun NoInstrumentalizacion () Bool)

; A1: La accion de exhibicion es realizada por el sistema (agentes estatales)
;     pero usa al detenido x como objeto de la accion
(assert (! (Realiza x_detenido a_exhibicion) :named h-realiza-exhibicion))

; A2: El fin de la accion es el disciplinamiento social
(assert (! (FinDe a_exhibicion f_disciplinamiento) :named h-fin-disciplina))

; A3: Definicion de instrumentalizacion: si x realiza (es objeto de) una accion
;     cuyo fin es f, entonces x es medio para f
(assert (! (forall ((p Persona) (a Accion) (f Fin))
  (=> (and (Realiza p a) (FinDe a f)) (Medio p f))) :named ax-medio-def))

; A4: Principio de no-instrumentalizacion: nadie es medio para fin social
(assert (! (forall ((p Persona) (f Fin)) (not (Medio p f))) :named ax-no-instrumental))

(push)
  (echo "===== L4: ¿Es consistente el terror ejemplar bajo no-instrumentalizacion? =====")
  (check-sat)
  (get-unsat-core)
(pop)