% Código Clingo: equilibrio paramétrico en red de favores
% Configuración D activada (estrella)

#const utilidad_privilegio=3.
#const utilidad_bien_publico=2.
#const costo_ruptura=1.
#const topologia=estrella.

agente(a1; a2; a3).

favores(A,B) :- agente(A), agente(B), A != B, topologia=clique.
favores(a1,a2). favores(a2,a1) :- topologia=estrella.
favores(a1,a3). favores(a3,a1) :- topologia=estrella.
favores(a1,a2). favores(a2,a1) :- topologia=cadena.
favores(a2,a3). favores(a3,a2) :- topologia=cadena.

1 { elige(A, privilegio); elige(A, bien_publico) } 1 :- agente(A).

ub(A, utilidad_privilegio) :- elige(A, privilegio).
ub(A, utilidad_bien_publico) :- elige(A, bien_publico).

num_rupturas(A, R) :- elige(A, bien_publico), 
    R = #count { B : favores(A,B), elige(B, privilegio) }.
num_rupturas(A, 0) :- elige(A, privilegio).

costo(A, C) :- num_rupturas(A, R), C = costo_ruptura * R.
utilidad_neta(A, U) :- ub(A, UB), costo(A, C), U = UB - C.

utilidad_total(T) :- T = #sum { UN : utilidad_neta(_, UN) }.
#maximize { T : utilidad_total(T) }.

#show elige/2.
#show utilidad_total/1.