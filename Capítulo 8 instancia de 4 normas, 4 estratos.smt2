; Código Z3: instancia de 4 normas, 4 estratos
; Verifica que n_limitacion (nivel 1) y n_meta (nivel 2)
; no son justificables sin axioma fundacional externo.

(set-option :produce-unsat-cores true)

(declare-datatypes ((Norma 0)) ((n_integridad n_prision n_limitacion n_meta)))
(declare-datatypes ((Estrato 0)) ((s_civil s_penal s_const s_meta)))

(declare-fun Nivel (Norma) Int)
(assert (! (= (Nivel n_integridad) 0) :named nivel-integridad))
(assert (! (= (Nivel n_prision) 0) :named nivel-prision))
(assert (! (= (Nivel n_limitacion) 1) :named nivel-limitacion))
(assert (! (= (Nivel n_meta) 2) :named nivel-meta))

(declare-fun Vincula (Estrato Norma) Bool)
(declare-fun Limita (Norma Norma) Bool)
(declare-fun Justificada (Norma) Bool)

(assert (! (forall ((n_lim Norma) (n_obj Norma))
  (=> (Limita n_lim n_obj) (> (Nivel n_lim) (Nivel n_obj)))) :named ax-limit-jerarquia))

(assert (! (forall ((n Norma))
  (= (Justificada n)
     (or (exists ((n_sup Norma)) (and (Limita n_sup n) (> (Nivel n_sup) (Nivel n))))
         (= n n_integridad)))) :named ax-justificacion))

(assert (! (Vincula s_const n_limitacion) :named h-const))
(assert (! (Limita n_limitacion n_integridad) :named h-limita-integridad))
(assert (! (Limita n_limitacion n_prision) :named h-limita-prision))

(push)
(echo "CF1: limitacion constitucional autoportante?")
(assert (! (not (Limita n_meta n_limitacion)) :named cf1-bloqueo))
(assert (! (Justificada n_limitacion) :named hip-just))
(check-sat) ; unsat
(pop)

(push)
(echo "CF2: metanorma que limita a la limitacion")
(assert (! (Limita n_meta n_limitacion) :named h-meta-limita))
(assert (! (Justificada n_meta) :named hip-just-meta))
(check-sat) ; unsat
(pop)