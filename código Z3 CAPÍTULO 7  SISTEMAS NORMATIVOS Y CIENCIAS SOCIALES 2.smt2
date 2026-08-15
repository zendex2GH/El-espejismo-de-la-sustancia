; ============================================================
; CAPÍTULO 7 — SISTEMAS NORMATIVOS Y CIENCIAS SOCIALES
; Bloque Z3 v2.0: Σ_R + SFCD (Teoremas T1, T2, T3)
; Mejoras: universo distinto, hechos de dominio, modelo pedagógico limpio
; ============================================================
(set-option :produce-unsat-cores true)
(set-option :produce-models true)

; --------------------------------------------------
; 1. SORTS PRIMITIVOS
; --------------------------------------------------
(declare-sort Agente)
(declare-sort Entidad)
(declare-sort Estrato)
(declare-sort Norma)

; --------------------------------------------------
; 2. CONSTANTES DEL UNIVERSO (todas distintas)
; --------------------------------------------------
(declare-const a_critic  Agente)   ; el crítico ilustrado
(declare-const soberano  Agente)   ; agente con poder en estrato supremo
(declare-const w         Agente)   ; whistleblower

(declare-const e_patria  Entidad)  ; entidad reificada: la Patria/Nación

(declare-const s0        Estrato)  ; estrato constitucional / supremo
(declare-const s1        Estrato)  ; estrato legal / ordinario

(declare-const n_auto    Norma)    ; norma de autolimitación soberana
(declare-const n_violada Norma)  ; norma que el sistema viola
(declare-const n_meta    Norma)    ; metanorma de lealtad institucional

; Axioma de identidad: el universo tiene exactamente estos individuos
(assert (! (distinct a_critic soberano w) :named distinct-agentes))
(assert (! (distinct e_patria) :named distinct-entidades))
(assert (! (distinct s0 s1) :named distinct-estratos))
(assert (! (distinct n_auto n_violada n_meta) :named distinct-normas))

; --------------------------------------------------
; 3. PREDICADOS DE Σ_R (Cálculo de Reificación)
; --------------------------------------------------
(declare-fun CreeArbitrario (Agente Entidad) Bool)
(declare-fun Reificado    (Entidad Agente) Bool)
(declare-fun Sagrado      (Entidad Agente) Bool)
(declare-fun Sacrifica    (Agente Entidad) Bool)

; --------------------------------------------------
; 4. PREDICADOS DE ESTRATIFICACIÓN NORMATIVA
; Anclaje: SPA (Cap. 3) — estratos indexados, análogo a Tarski
; --------------------------------------------------
(declare-fun Competente (Agente Estrato) Bool)
(declare-fun Regula     (Agente Norma Estrato) Bool)
(declare-fun Evalua     (Agente Norma Estrato) Bool)
(declare-fun Menciona   (Norma Agente Estrato) Bool)

; --------------------------------------------------
; 5. PREDICADOS DE INMUNIDAD SISTÉMICA
; Anclaje: Luhmann (autopoiesis) + Bourdieu (violencia simbólica)
; --------------------------------------------------
(declare-fun DenunciaExt  (Agente Norma) Bool)
(declare-fun DenunciaRec  (Agente Norma) Bool)
(declare-fun Interno      (Agente) Bool)
(declare-fun Delito       (Agente) Bool)
(declare-fun Sancion      (Agente) Bool)
(declare-fun Valida       (Norma) Bool)
(declare-fun Reforma      (Norma) Bool)
(declare-fun Metanorma    (Norma) Bool)

; --------------------------------------------------
; 6. HECHOS DE DOMINIO (Background Facts)
;    Fijan la estructura ontológica para que Z3 no minimice arbitrariamente
; --------------------------------------------------

; 6.1 Perfiles de competencia estratificada
(assert (! (Competente soberano s0) :named dom-comp-s0))
(assert (! (not (Competente soberano s1)) :named dom-no-comp-s1))
(assert (! (not (Competente a_critic s0)) :named dom-critic-no-s0))
(assert (! (not (Competente a_critic s1)) :named dom-critic-no-s1))
(assert (! (not (Competente w s0)) :named dom-w-no-s0))
(assert (! (not (Competente w s1)) :named dom-w-no-s1))

; 6.2 Perfiles institucionales
(assert (! (Interno w) :named dom-w-interno))
(assert (! (not (Interno a_critic)) :named dom-critic-externo))
(assert (! (not (Interno soberano)) :named dom-soberano-externo))

; 6.3 Tipología de normas
(assert (! (Metanorma n_meta) :named dom-n-meta))
(assert (! (not (Metanorma n_auto)) :named dom-n-auto-no-meta))
(assert (! (not (Metanorma n_violada)) :named dom-n-violada-no-meta))

; 6.4 La Patria está reificada para el soberano y para w, pero el crítico
;     no la tiene reificada (esto es coherente con su rol de crítico)
(assert (! (Reificado e_patria soberano) :named dom-reif-soberano))
(assert (! (Reificado e_patria w) :named dom-reif-w))
(assert (! (not (Reificado e_patria a_critic)) :named dom-no-reif-critic))

; --------------------------------------------------
; 7. AXIOMAS DE Σ_R
; --------------------------------------------------

; sig-A3-reificacion: Reificación bloquea percepción de arbitrariedad
; Anclaje: Lukács — "objetividad fantasmal"
(assert (! (forall ((x Agente) (y Entidad))
  (=> (Reificado y x) (not (CreeArbitrario x y))))
  :named sig-A3-reificacion))

; sig-A4-sagrado: Lo sagrado implica lo reificado
; Anclaje: Bourdieu — sacralización como legitimación
(assert (! (forall ((x Agente) (y Entidad))
  (=> (Sagrado y x) (Reificado y x)))
  :named sig-A4-sagrado))

; sig-A6-sacrificio-requiere-sagrado: El sacrificio exige entidad sagrada
; Anclaje: Himnos nacionales — "morir por la patria"
(assert (! (forall ((x Agente) (y Entidad))
  (=> (Sacrifica x y) (Sagrado y x)))
  :named sig-A6-sacrificio-requiere-sagrado))

; --------------------------------------------------
; 8. AXIOMA DE INCOMPETENCIA REFLEXIVA ESTRATIFICADA
; Anclaje: SPA (Cap. 3) + Kelsen (Grundnorm) + Schmitt (Poder Constituyente)
; --------------------------------------------------
(assert (! (forall ((a Agente) (n Norma) (s Estrato))
  (=> (and (Regula a n s) (Menciona n a s)) (not (Evalua a n s))))
  :named sig-IR-estratificacion))

; --------------------------------------------------
; 9. AXIOMAS DE INMUNIDAD SISTÉMICA
; Anclaje: Luhmann — autopoiesis normativa
; --------------------------------------------------

; La metanorma de lealtad: denuncia interna = delito
(assert (! (forall ((x Agente) (n Norma))
  (=> (and (DenunciaExt x n) (Interno x)) (Delito x)))
  :named T3-metanorma-lealtad))

; Derivación de sanción
(assert (! (forall ((x Agente)) (=> (Delito x) (Sancion x)))
  :named T3-sancion-derivada))

; Bloqueo de reconocimiento: el sistema no reconoce denuncias de internos
(assert (! (forall ((x Agente) (n Norma))
  (=> (and (DenunciaExt x n) (Interno x)) (not (DenunciaRec x n))))
  :named T3-bloqueo-reconocimiento))

; Principio lógico interno: denuncia reconocida + sin reforma = norma inválida
(assert (! (forall ((x Agente) (n Norma))
  (=> (and (DenunciaRec x n) (not (Reforma n))) (not (Valida n))))
  :named T3-principio-logico))

; Presunción de vigencia: si no hay reforma, la norma sigue válida
(assert (! (forall ((n Norma)) (=> (not (Reforma n)) (Valida n)))
  :named T3-presuncion-vigencia))

; --------------------------------------------------
; 10. TEOREMA T1 — INMUNIDAD DEL CRÍTICO
; --------------------------------------------------
(push)
  (echo "===== T1: Inmunidad del Crítico =====")
  ; El crítico cree que la Patria es arbitraria
  (assert (! (CreeArbitrario a_critic e_patria) :named T1-hipotesis-critico))
  ; El crítico intenta sacrificarse por la Patria
  (assert (! (Sacrifica a_critic e_patria)     :named T1-hipotesis-sacrificio))
  
  (check-sat)
  (get-unsat-core)
(pop)

; --------------------------------------------------
; 11. TEOREMA T2 — PARADOJA DE LA SOBERANÍA
; --------------------------------------------------
(push)
  (echo "===== T2: Paradoja de la Soberanía =====")
  ; El soberano emite una norma en s0 que menciona su propia competencia
  (assert (! (Regula soberano n_auto s0)       :named T2-regula-auto))
  (assert (! (Menciona n_auto soberano s0)     :named T2-menciona-auto))
  ; El soberano intenta validar esa norma él mismo
  (assert (! (Evalua soberano n_auto s0)        :named T2-evalua-auto))
  
  (check-sat)
  (get-unsat-core)
(pop)

; --------------------------------------------------
; 12. TEOREMA T3a — INMUNIDAD SISTÉMICA (ABSORCIÓN)
; --------------------------------------------------
(push)
  (echo "===== T3a: Inmunidad Sistémica (Absorción) =====")
  ; Hechos empíricos del caso
  (assert (! (DenunciaExt w n_violada) :named T3-hecho-denuncia))
  (assert (! (not (Reforma n_violada))  :named T3-absorcion-no-reforma))
  
  (check-sat)
  (get-model)
(pop)

; --------------------------------------------------
; 13. TEOREMA T3b — COLAPSO SIN ESTRATO SUPERIOR
; --------------------------------------------------
(push)
  (echo "===== T3b: Colapso sin Estrato Superior =====")
  ; Mismos hechos que T3a
  (assert (! (DenunciaExt w n_violada) :named T3-hecho-denuncia-b))
  ; Forzamos al sistema a reconocer la denuncia del interno
  (assert (! (DenunciaRec w n_violada) :named T3-reconocimiento-forzado))
  ; Negamos la reforma
  (assert (! (not (Reforma n_violada)) :named T3-sin-reforma))
  
  (check-sat)
  (get-unsat-core)
(pop)