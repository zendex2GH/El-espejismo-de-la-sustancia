; Código Z3: instancia de 4 estados lineales con loop en e3
; Verifica que ningun estado alcanzable es de equilibrio.

(set-option :produce-unsat-cores true)

(declare-datatypes ((Estado 0)) ((e0 e1 e2 e3)))

(declare-fun Aplica (Estado) Bool)
(declare-fun Deteriorado (Estado) Bool)
(declare-fun Justifica (Estado) Bool)
(declare-fun Equilibrio (Estado) Bool)

(assert (! (=> (Aplica e0) (Deteriorado e1)) :named ax-t0))
(assert (! (=> (Aplica e1) (Deteriorado e2)) :named ax-t1))
(assert (! (=> (Aplica e2) (Deteriorado e3)) :named ax-t2))
(assert (! (=> (Aplica e3) (Deteriorado e3)) :named ax-t3))

(assert (! (= (Equilibrio e0) (not (Aplica e0))) :named ax-eq0))
(assert (! (= (Equilibrio e1) (not (Aplica e1))) :named ax-eq1))
(assert (! (= (Equilibrio e2) (not (Aplica e2))) :named ax-eq2))
(assert (! (= (Equilibrio e3) (not (Aplica e3))) :named ax-eq3))

(assert (! (Aplica e0) :named h-inicio))

(push)
(assert (! (=> (Deteriorado e0) (Justifica e0)) :named ax-d0))
(assert (! (=> (Deteriorado e1) (Justifica e1)) :named ax-d1))
(assert (! (=> (Deteriorado e2) (Justifica e2)) :named ax-d2))
(assert (! (=> (Deteriorado e3) (Justifica e3)) :named ax-d3))
(assert (! (=> (Justifica e0) (Aplica e0)) :named ax-j0))
(assert (! (=> (Justifica e1) (Aplica e1)) :named ax-j1))
(assert (! (=> (Justifica e2) (Aplica e2)) :named ax-j2))
(assert (! (=> (Justifica e3) (Aplica e3)) :named ax-j3))
(assert (! (or (Equilibrio e0) (Equilibrio e1) (Equilibrio e2) (Equilibrio e3)) :named hip-equilibrio))
(check-sat)
(get-unsat-core)
(pop)

(push)
(echo "CF4: Deterioro en e3 NO justifica encierro")
(assert (! (=> (Deteriorado e0) (Justifica e0)) :named cf4-d0))
(assert (! (=> (Deteriorado e1) (Justifica e1)) :named cf4-d1))
(assert (! (=> (Deteriorado e2) (Justifica e2)) :named cf4-d2))
(assert (! (=> (Justifica e0) (Aplica e0)) :named cf4-j0))
(assert (! (=> (Justifica e1) (Aplica e1)) :named cf4-j1))
(assert (! (=> (Justifica e2) (Aplica e2)) :named cf4-j2))
(assert (! (=> (Justifica e3) (Aplica e3)) :named cf4-j3))
(assert (! (Equilibrio e3) :named hip-equilibrio-cf4))
(check-sat)
(pop)