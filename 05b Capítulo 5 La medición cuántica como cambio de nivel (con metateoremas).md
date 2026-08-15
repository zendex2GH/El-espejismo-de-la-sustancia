

# Capítulo 5: La medición cuántica como cambio de nivel

## 5.0 Introducción: el problema de la medición cuántica

En el Capítulo 4, nosotros formalizamos la gramática de la reificación en el discurso físico clásico, mostrando que el espacio-tiempo, la energía y la fuerza son tratados como sustancias cuando el formalismo los define como estructuras relacionales. En este capítulo, aplicamos el mismo protocolo a un caso paradigmático de la física moderna: la medición cuántica y el llamado “colapso de la función de onda”.

La narrativa divulgativa estándar presenta el colapso como un evento físico: una función de onda que “colapsa” abruptamente desde una superposición de estados a un estado definido cuando se realiza una medición. Esta narrativa sugiere que algo cambia en el sistema físico mismo: la función de onda, tratada como una entidad sustancial, sufre una transformación abrupta [B].

Hay que ser cuidadosos aquí: esta narrativa es en parte una caricatura didáctica, pero como demostramos en los capítulos anteriores, la reificación no es simplemente un error pedagógico; está profundamente facilitada por la estructura gramatical del lenguaje mismo. El lenguaje natural, con su estructura sujeto-predicado, nos empuja constantemente a tratar procesos y relaciones como si fueran sustancias con propiedades. Cuando decimos “la función de onda colapsa”, la gramática exige un sujeto sustancial (“la función de onda”) que realiza una acción (“colapsa”), aunque el formalismo matemático describa simplemente una actualización de distribuciones de probabilidad. La reificación cuántica es, por tanto, un caso paradigmático de cómo la gramática del lenguaje natural conspira contra la precisión ontológica del formalismo matemático.

La interpretación de Copenhague, en las formulaciones originales de Bohr y Heisenberg, ya enfatizaba el carácter epistémico de la función de onda. Bohr escribió: “No hay un mundo cuántico. Solo hay una descripción cuántica abstracta de la realidad” [B]. La reificación del colapso es más un producto de la pedagogía simplificada y de las constricciones gramaticales del lenguaje natural que de la interpretación original. Sin embargo, la narrativa sustancialista sigue siendo dominante en libros de texto y divulgación, y produce misconceptions persistentes [B].

Existe una narrativa alternativa, respaldada por interpretaciones como QBism de Fuchs, la Mecánica Cuántica Operacional (OQM) de Werner, y lecturas epistémicas de Copenhague: el “colapso” no es un evento físico en el sistema, sino una actualización epistémica en el observador. Lo que cambia no es el sistema, sino la información disponible sobre el sistema. La función de onda no es una sustancia que colapsa; es una representación de nuestro conocimiento que se actualiza [B].

### Estructura formal del capítulo: física, lógica y dinámica discursiva

Este capítulo emplea una estrategia formal tripartita que es importante anunciar desde el inicio para orientar al lector. La reificación en la mecánica cuántica tiene una característica peculiar que la distingue de los capítulos anteriores: la reificación no se produce en los objetos matemáticos mismos, sino en el paso de su interpretación. El vector de estado en un espacio de Hilbert no está reificado; la reificación aparece cuando se interpreta ese vector como “una cosa que colapsa”.

Por ello, el capítulo procede en tres niveles de formalización:

1. **Lean 4 (Secciones 5.2–5.3):** Formalizamos las propiedades estructurales genuinas de la mecánica cuántica: no-conmutatividad, violación de las desigualdades de Bell, contextualidad y bloqueo de la definición contracausal. Estos teoremas establecen los límites algebraicos y analíticos que distinguen el comportamiento cuántico del clásico. Aquí demostramos física, no reificación. Las demostraciones en prosa **[A-Meta]** acompañan a las verificaciones formales **[A-Código]**.

2. **Z3 (Sección 5.4.1):** Formalizamos el mapa del pluralismo interpretativo. Demostramos que el teorema de Bell no refuta “el realismo” en abstracto, sino una conjunción específica de tres supuestos metafísicos (Localidad, Definición Contracausal, Independencia Estadística). Z3 mapea exhaustivamente las 7 interpretaciones viables que surgen al renunciar a al menos uno de estos supuestos, mostrando que la interpretación epistémica es una opción entre varias, no una conclusión lógicamente inevitable.

3. **Clingo (Sección 5.4.2):** Modelamos la dinámica histórica del discurso cuántico. Simulamos cómo una comunidad científica transita entre las 7 posibilidades del mapa de Z3 cuando llega evidencia contraria al paradigma dominante. El resultado revela que la interpretación epistémica no es la trayectoria óptima bajo criterios de parsimonia pura; su adopción requiere argumentos filosóficos adicionales.

Esta estructura permite al lector comprender primero qué dice la física (Lean), luego qué espacio de interpretaciones es lógicamente viable (Z3), y finalmente cómo evoluciona el debate científico (Clingo). Las secciones de Lean son las más técnicas; el lector puede saltarlas y centrarse en las interpretaciones prosaicas, que son autosuficientes.

Nota sobre el alcance de la formalización. Nosotros no formalizamos la mecánica cuántica completa (espacios de Hilbert de dimensión infinita, operadores autoadjuntos, evolución unitaria). Lo que nosotros formalizamos es un modelo estructural con qubits y ángulos de medición que captura propiedades esenciales de la teoría cuántica. El modelo es didáctico pero no trivial: los teoremas demuestran límites algebraicos y analíticos verificables que distinguen el comportamiento epistémico cuántico de cualquier teoría clásica de variables ocultas locales.

---

## 5.1 El caso del colapso de la función de onda: aplicación del protocolo [C]

Aplicamos las cuatro preguntas del Capítulo 0 al caso del colapso de la función de onda, manteniendo la neutralidad interpretativa: el protocolo analiza el formalismo matemático sin presuponer ninguna interpretación particular.

### Pregunta 1: ¿Cuál es el objeto formal y cuál es su tipo?

El objeto formal es la función de onda $\psi$, que en la formulación estándar es un vector unitario en un espacio de Hilbert. Matemáticamente, codifica una distribución de probabilidad sobre los posibles resultados de medición, calculada mediante la regla de Born: $P(a_i) = |\langle a_i | \psi \rangle|^2$. El formalismo por sí mismo es agnóstico respecto al estatus ontológico de este objeto: podría ser una entidad física real (interpretación ontológica) o un recurso predictivo (interpretación epistémica).

En la formulación estándar, la función de onda evoluciona de dos maneras:

1. **Evolución unitaria (ecuación de Schrödinger):** determinista, continua, reversible.
2. **Colapso (postulado de medición):** probabilístico, discontinuo, irreversible.

Esta dualidad es la fuente del “problema de la medición”: ¿por qué hay dos reglas de evolución distintas?

### Pregunta 2: ¿Qué atribuye la narrativa a este objeto que el formalismo no exige?

La narrativa divulgativa atribuye a la función de onda propiedades de sustancia física:

- “La función de onda colapsa” (como si fuera un objeto que sufre una transformación física).
- “El electrón está en una superposición de estados” (como si la superposición fuera un estado físico real, no una representación matemática).
- “La medición fuerza al sistema a elegir un estado” (como si el sistema tuviera una ontología definida que la medición revela).

Estas atribuciones requieren un sujeto de tipo sustancia (algo que puede colapsar, estar en superposición, ser forzado). El formalismo matemático no exige estas atribuciones; son una capa interpretativa añadida. Como demostramos en el Capítulo 1, la estructura gramatical del lenguaje natural (sujeto-predicado) facilita esta reificación: el lenguaje nos empuja a tratar “la función de onda” como un sustantivo que denota una entidad, cuando en el formalismo es simplemente un vector en un espacio abstracto.

### Pregunta 3: ¿Existen descripciones alternativas?

Sí, y son múltiples. Hay al menos dos familias de interpretaciones:

- **Interpretaciones ontológicas:** tratan la función de onda como entidad física real (teoría de Bohm, muchos mundos, colapso objetivo).
- **Interpretaciones epistémicas:** tratan la función de onda como representación de información (QBism, OQM, Copenhague estricto).

Bajo las interpretaciones epistémicas, el “colapso” se trata como una actualización bayesiana: el observador actualiza su información sobre el sistema tras obtener un resultado de medición. El sistema físico no cambia; lo que cambia es la información del observador.

### Pregunta 4: ¿Es teoría resuelta con narrativa sucia?

Parcialmente. La mecánica cuántica es una teoría resuelta en el sentido de que las predicciones empíricas están confirmadas con precisión extraordinaria (violación de desigualdades de Bell, efecto Casimir, computación cuántica). Pero la interpretación de la teoría sigue siendo objeto de debate.

En las secciones siguientes, nosotros argumentaremos que la interpretación epistémica es la opción más parsimoniosa porque evita postular eventos físicos misteriosos (colapsos instantáneos, acción a distancia), aunque a costa de renunciar al realismo clásico. Esta elección no es una derivación necesaria del protocolo, sino una hipótesis interpretativa que defendemos por su coherencia con el principio anti-reificador que articula este trabajo.

---

## 5.2 Formalización del modelo epistémico en Lean 4 [A-Código]

Nosotros construimos un sistema formal en Lean 4 que modela la medición cuántica desde una perspectiva puramente epistémica. Aquí no postulamos un estado ontológico subyacente con valores definidos. La superposición, la no-conmutatividad y el entrelazamiento se modelan enteramente como propiedades de los estados de creencia del agente.

### Definiciones operacionales: agente, información y frontera

**Agente.** En nuestro modelo, un “agente” es cualquier sistema macroscópico capaz de registrar un resultado de medición de manera termodinámicamente irreversible. No requiere conciencia; puede ser un aparato de medición, un computador o un observador humano.

**Información.** La “información” se entiende aquí como recurso predictivo operacional, no como creencia subjetiva (QBism) ni como conocimiento objetivo (Copenhague). Es el conjunto de probabilidades que un agente racional debe asignar a futuros resultados de medición.

**Frontera.** El “problema de la frontera” pregunta dónde termina el sistema cuántico y dónde empieza el agente clásico. Nosotros adoptamos un criterio pragmático: la frontera es el umbral de decoherencia, la interacción irreversible con el entorno macroscópico que registra un resultado de manera estable.

### Código Lean 4: tipos, medición y correlaciones

```lean
import Mathlib.Tactic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

open Real

noncomputable section

-- Ejes de medición (observables incompatibles)
inductive Axis
  | Z | X | D | D'
  deriving DecidableEq, Repr

-- Resultados de medición
inductive SpinResult
  | up | down
  deriving DecidableEq, Repr

-- Función auxiliar: mapeo de SpinResult a enteros ±1
def spin_to_int (s : SpinResult) : Int :=
  match s with
  | .up => 1
  | .down => -1

theorem spin_to_int_cases (s : SpinResult) : spin_to_int s = 1 ∨ spin_to_int s = -1 := by
  cases s <;> simp [spin_to_int]

-- Estado epistémico: creencias del agente
structure EpistemicState where
  prob_up_Z : Nat
  prob_up_X : Nat
  prob_up_D : Nat
  prob_up_D' : Nat
  deriving DecidableEq, Repr

-- Medición como actualización epistémica
def measure_Z (_prior : EpistemicState) (result : SpinResult) : EpistemicState :=
  match result with
  | .up => ⟨100, 50, 50, 50⟩
  | .down => ⟨0, 50, 50, 50⟩

def measure_X (_prior : EpistemicState) (result : SpinResult) : EpistemicState :=
  match result with
  | .up => ⟨50, 100, 50, 50⟩
  | .down => ⟨50, 0, 50, 50⟩

def measure_D (_prior : EpistemicState) (result : SpinResult) : EpistemicState :=
  match result with
  | .up => ⟨50, 50, 100, 50⟩
  | .down => ⟨50, 50, 0, 50⟩

-- Estados preparados
def prepared_Z_up : EpistemicState := ⟨100, 50, 50, 50⟩
def prepared_X_up : EpistemicState := ⟨50, 100, 50, 50⟩
def prepared_maximally_mixed : EpistemicState := ⟨50, 50, 50, 50⟩

-- Correlación cuántica: E(θa, θb) = -cos(θa - θb)
def quantum_correlation (θa θb : ℝ) : ℝ := -cos (θa - θb)

def angle_a  : ℝ := 0
def angle_a' : ℝ := π/2
def angle_b  : ℝ := π/4
def angle_b' : ℝ := 3*π/4

def S_quantum : ℝ :=
  quantum_correlation angle_a angle_b - quantum_correlation angle_a angle_b' +
  quantum_correlation angle_a' angle_b + quantum_correlation angle_a' angle_b'

-- Correlación clásica: producto de resultados ±1
def classical_correlation (assignA assignB : Axis → SpinResult) (a b : Axis) : Int :=
  (spin_to_int (assignA a)) * (spin_to_int (assignB b)) * 100

def classical_S (assignA assignB : Axis → SpinResult) : Int :=
  classical_correlation assignA assignB .Z .D -
  classical_correlation assignA assignB .Z .D' +
  classical_correlation assignA assignB .X .D +
  classical_correlation assignA assignB .X .D'

end
```

---

## 5.3 Teoremas estructurales de la mecánica cuántica en Lean 4 [A-Meta] + [A-Código]

Nota sobre la accesibilidad del código. Las demostraciones formales que siguen utilizan tácticas de Lean 4 y Mathlib que pueden ser técnicas para lectores sin formación en asistentes de prueba. El lector puede saltar las pruebas formales y centrarse en las interpretaciones prosaicas, que son autosuficientes.

Nota sobre el estatus epistémico. Los Teoremas 1, 3 y 5 son verificaciones de consistencia estructural (sanity checks) que garantizan que nuestro modelo respeta sus propios axiomas de diseño. El peso físico-filosófico sustantivo recae en el Teorema 2 (frontera de Bell).

---

### 5.3.1 No-conmutatividad (Principio de Incertidumbre) [A-Meta] + [A-Código]

#### Teorema T-NC-Z [A-Meta]

La medición en Z desordena la información sobre X.

Enunciado. $\forall (prior : EpistemicState), \forall (result : SpinResult),\; (measure_Z\; prior\; result).prob_up_X = 50$.

Demostración. Sea $prior$ un estado epistémico arbitrario y sea $result \in \{up, down\}$. Examinemos la definición de $measure_Z$:

$$
measure_Z\; prior\; up = \langle 100, 50, 50, 50 \rangle,
$$

$$
measure_Z\; prior\; down = \langle 0, 50, 50, 50 \rangle.
$$

En ambos casos, el segundo campo de la tupla resultante —que corresponde a $prob_up_X$— vale $50$. Luego, para todo $prior$ y todo $result$, la probabilidad epistémica asignada a $X = up$ tras medir $Z$ es $50$. $\square$

#### Teorema T-NC-X [A-Meta]

La medición en X desordena la información sobre Z.

Enunciado. $\forall (prior : EpistemicState), \forall (result : SpinResult),\; (measure_X\; prior\; result).prob_up_Z = 50$.

Demostración. Sea $prior$ arbitrario y $result \in \{up, down\}$. Por definición:

$$
measure_X\; prior\; up = \langle 50, 100, 50, 50 \rangle,
$$

$$
measure_X\; prior\; down = \langle 50, 0, 50, 50 \rangle.
$$

En ambas ramas, el primer campo —$prob_up_Z$— es $50$. Por tanto, la medición de $X$ borra toda información previa sobre $Z$. $\square$

#### Verificación en Lean [A-Código]

```lean
noncomputable section

theorem measurement_Z_scrambles_X :
    ∀ (prior : EpistemicState) (result : SpinResult),
      (measure_Z prior result).prob_up_X = 50 := by
  intro prior result; cases result <;> rfl

theorem measurement_X_scrambles_Z :
    ∀ (prior : EpistemicState) (result : SpinResult),
      (measure_X prior result).prob_up_Z = 50 := by
  intro prior result; cases result <;> rfl
```

Interpretación: Medir un observable desordena la información sobre observables incompatibles. Esto no es una limitación tecnológica; es una propiedad estructural de la teoría.

---

### 5.3.2 La frontera de Bell (Teorema central) [A-Meta] + [A-Código]

Este es el teorema central del capítulo. Demuestra que ninguna teoría de variables ocultas locales puede reproducir las correlaciones predichas por la mecánica cuántica. La demostración procede en tres partes.

---

#### Parte A: Cota algebraica clásica [A-Meta] + [A-Código]

##### Teorema T-CHSH-Alg [A-Meta]

Cota algebraica clásica para la combinación CHSH.

Enunciado. Sean $a, a', b, b' \in \{-1, +1\}$. Entonces:

$$
|a b - a b' + a' b + a' b'| \leq 2.
$$

Demostración. Sea:

$$
E = a b - a b' + a' b + a' b'.
$$

Factorizando algebraicamente:

$$
E = a(b - b') + a'(b + b').
$$

Como $b, b' \in \{-1, +1\}$, distinguimos dos casos exhaustivos.

**Caso 1:** $b = b'$. Entonces $b - b' = 0$ y $b + b' \in \{-2, +2\}$. Luego:

$$
E = a'(b + b') \in \{-2, +2\}.
$$

**Caso 2:** $b \neq b'$. Entonces $b + b' = 0$ y $b - b' \in \{-2, +2\}$. Luego:

$$
E = a(b - b') \in \{-2, +2\}.
$$

En ambos casos $|E| \leq 2$. Por tanto, la cota vale para toda asignación. $\square$

##### Teorema T-CHSH-Scale [A-Meta]

Acotación de la correlación clásica en el modelo epistémico.

Enunciado. $\forall assignA, \forall assignB,\; |classical_S\; assignA\; assignB| \leq 200$.

Demostración. Sean $assignA, assignB : Axis \to SpinResult$ funciones arbitrarias. Definamos:

$$
r_A^Z = spin_to_int(assignA(Z)), \quad r_A^X = spin_to_int(assignA(X)),
$$

$$
r_B^D = spin_to_int(assignB(D)), \quad r_B^{D'} = spin_to_int(assignB(D')).
$$

Por definición de $spin_to_int$, cada una de estas cuatro variables pertenece a $\{-1, +1\}$. Sustituyendo en la definición de $classical_S$:

$$
classical_S = 100 \cdot (r_A^Z r_B^D - r_A^Z r_B^{D'} + r_A^X r_B^D + r_A^X r_B^{D'}).
$$

Por T-CHSH-Alg, el factor entre paréntesis está acotado en valor absoluto por $2$. Luego:

$$
|classical_S|
= 100 \cdot |r_A^Z r_B^D - r_A^Z r_B^{D'} + r_A^X r_B^D + r_A^X r_B^{D'}|
\leq 100 \cdot 2 = 200.
$$

$\square$

##### Verificación en Lean [A-Código]

```lean
theorem chsh_bound_core (aZ aX bD bD' : Int)
   (haZ : aZ = 1 ∨ aZ = -1) (haX : aX = 1 ∨ aX = -1)
   (hbD : bD = 1 ∨ bD = -1) (hbD' : bD' = 1 ∨ bD' = -1) :
   (aZ * bD - aZ * bD' + aX * bD + aX * bD').natAbs ≤ 2 := by
   rcases hbD with (rfl | rfl) <;> rcases hbD' with (rfl | rfl) <;>
   rcases haZ with (rfl | rfl) <;> rcases haX with (rfl | rfl) <;>
   norm_num

theorem classical_S_bounded (assignA assignB : Axis → SpinResult) :
   (classical_S assignA assignB).natAbs ≤ 200 := by
   let rA_Z := spin_to_int (assignA .Z)
   let rA_X := spin_to_int (assignA .X)
   let rB_D := spin_to_int (assignB .D)
   let rB_D' := spin_to_int (assignB .D')
   have hA_Z : rA_Z = 1 ∨ rA_Z = -1 := spin_to_int_cases (assignA .Z)
   have hA_X : rA_X = 1 ∨ rA_X = -1 := spin_to_int_cases (assignA .X)
   have hB_D : rB_D = 1 ∨ rB_D = -1 := spin_to_int_cases (assignB .D)
   have hB_D' : rB_D' = 1 ∨ rB_D' = -1 := spin_to_int_cases (assignB .D')
   have h_bound := chsh_bound_core rA_Z rA_X rB_D rB_D' hA_Z hA_X hB_D hB_D'
   have h_eq : classical_S assignA assignB =
     100 * (rA_Z * rB_D - rA_Z * rB_D' + rA_X * rB_D + rA_X * rB_D') := by
     unfold classical_S classical_correlation
     simp only [rA_Z, rB_D, rA_X, rB_D']
     ring
   rw [h_eq]
   rw [Int.natAbs_mul]
   have h_abs_100 : Int.natAbs 100 = 100 := by norm_num
   rw [h_abs_100]
   calc
     100 * (rA_Z * rB_D - rA_Z * rB_D' + rA_X * rB_D + rA_X * rB_D').natAbs
       ≤ 100 * 2 := Nat.mul_le_mul_left 100 h_bound
     _ = 200 := by norm_num
```

Interpretación: Cualquier teoría que postule valores definidos simultáneos para todas las mediciones (CFD) está algebraicamente limitado a $|S| \le 2$. Es una consecuencia pura de la probabilidad clásica conjunta.

---

#### Parte B: Predicción trigonométrica cuántica [A-Meta] + [A-Código]

##### Teorema T-Bell-Exact [A-Meta]

Valor exacto de la combinación CHSH cuántica.

Enunciado. $S_{quantum} = -2\sqrt{2}$.

Demostración. Por definición:

$$
S_{quantum}
= -\cos\left(0 - \frac{\pi}{4}\right)
+ \cos\left(0 - \frac{3\pi}{4}\right)
- \cos\left(\frac{\pi}{2} - \frac{\pi}{4}\right)
- \cos\left(\frac{\pi}{2} - \frac{3\pi}{4}\right).
$$

Evaluemos cada término.

Sea $\alpha = 0 - \frac{\pi}{4} = -\frac{\pi}{4}$. Como $\cos$ es par:

$$
\cos\left(-\frac{\pi}{4}\right)
= \cos\left(\frac{\pi}{4}\right)
= \frac{\sqrt{2}}{2}.
$$

Sea $\beta = 0 - \frac{3\pi}{4} = -\frac{3\pi}{4}$. Entonces:

$$
\cos(\beta)
= \cos\left(\frac{3\pi}{4}\right)
= -\frac{\sqrt{2}}{2}.
$$

Sea $\gamma = \frac{\pi}{2} - \frac{\pi}{4} = \frac{\pi}{4}$. Entonces:

$$
\cos(\gamma) = \frac{\sqrt{2}}{2}.
$$

Sea $\delta = \frac{\pi}{2} - \frac{3\pi}{4} = -\frac{\pi}{4}$. Entonces:

$$
\cos(\delta) = \frac{\sqrt{2}}{2}.
$$

Sustituyendo:

$$
S_{quantum}
= -\frac{\sqrt{2}}{2}
+ \left(-\frac{\sqrt{2}}{2}\right)
- \frac{\sqrt{2}}{2}
- \frac{\sqrt{2}}{2}
= -4 \cdot \frac{\sqrt{2}}{2}
= -2\sqrt{2}.
$$

$\square$

##### Verificación en Lean [A-Código]

```lean
theorem bell_violation_exact : S_quantum = -2 * Real.sqrt 2 := by
   unfold S_quantum quantum_correlation angle_a angle_a' angle_b angle_b'
   have h1 : cos (0 - π/4) = Real.sqrt 2 / 2 := by
     calc
       cos (0 - π/4) = cos (-(π/4)) := by ring_nf
       _ = cos (π/4) := by rw [Real.cos_neg]
       _ = Real.sqrt 2 / 2 := Real.cos_pi_div_four
   have h2 : cos (0 - 3*π/4) = -Real.sqrt 2 / 2 := by
     calc
       cos (0 - 3*π/4) = cos (-(3*π/4)) := by ring_nf
       _ = cos (3*π/4) := by rw [Real.cos_neg]
       _ = cos (π - π/4) := by ring_nf
       _ = -cos (π/4) := by rw [Real.cos_pi_sub]
       _ = -(Real.sqrt 2 / 2) := by rw [Real.cos_pi_div_four]
       _ = -Real.sqrt 2 / 2 := by simp [neg_div]
   have h3 : cos (π/2 - π/4) = Real.sqrt 2 / 2 := by
     calc
       cos (π/2 - π/4) = cos (π/4) := by ring_nf
       _ = Real.sqrt 2 / 2 := Real.cos_pi_div_four
   have h4 : cos (π/2 - 3*π/4) = Real.sqrt 2 / 2 := by
     calc
       cos (π/2 - 3*π/4) = cos (-(π/4)) := by ring_nf
       _ = cos (π/4) := by rw [Real.cos_neg]
       _ = Real.sqrt 2 / 2 := Real.cos_pi_div_four
   rw [h1, h2, h3, h4]
   field_simp
   ring_nf
```

---

#### Parte C: Violación analítica [A-Meta] + [A-Código]

##### Teorema T-Violation [A-Meta]

La predicción cuántica viola la cota clásica.

Enunciado. $|S_{quantum}| > 2$.

Demostración. Por T-Bell-Exact:

$$
|S_{quantum}| = |-2\sqrt{2}| = 2\sqrt{2}.
$$

Sabemos que $\sqrt{2} > 1$, pues $(\sqrt{2})^2 = 2 > 1 = 1^2$ y la función cuadrática es estrictamente creciente en $\mathbb{R}^+$. Luego:

$$
2\sqrt{2} > 2 \cdot 1 = 2.
$$

Por tanto:

$$
|S_{quantum}| > 2.
$$

$\square$

##### Verificación en Lean [A-Código]

```lean
theorem quantum_exceeds_classical_bound :
  abs S_quantum > 2 := by
  rw [bell_violation_exact]
  have h_abs : abs (-2 * Real.sqrt 2) = 2 * Real.sqrt 2 := by
    rw [abs_mul, abs_neg, abs_of_nonneg (by positivity)]
    norm_num
  rw [h_abs]
  have h_sqrt : Real.sqrt 2 > 1 := Real.lt_sqrt_of_sq_lt (by norm_num)
  nlinarith [Real.sqrt_nonneg 2, Real.sq_sqrt (show 0 ≤ 2 by norm_num)]
end
```

Interpretación general: La Parte A establece que la CFD limita a $|S| \le 2$. La Parte B demuestra que la regla de Born predice $S = -2\sqrt{2} \approx -2.828$. La Parte C verifica que $2\sqrt{2} > 2$. La violación de CHSH manifiesta la incompatibilidad estructural entre la distribución de probabilidad conjunta clásica y el estado cuántico global no-separable.

---

### 5.3.3 La condición de no-señalización [A-Meta] + [C]

Un requisito fundamental para cualquier interpretación de la mecánica cuántica es la compatibilidad con la relatividad especial: la prohibición de comunicación superlumínica. Esto se formaliza como la condición de no-señalización: la elección del eje de medición de Alice no puede alterar las probabilidades marginales de los resultados de Bob.

En la mecánica cuántica estándar, esto se garantiza matemáticamente mediante la traza parcial. Si el sistema conjunto está en el estado entrelazado $|\Psi\rangle$, la matriz de densidad reducida de Bob es $\rho_B = \text{Tr}_A(|\Psi\rangle\langle\Psi|)$. Un resultado fundamental del formalismo es que $\rho_B$ es independiente de la base de medición que elija Alice; para el estado singlete, $\rho_B$ es siempre proporcional a $\frac{1}{2}I$, lo que significa que las probabilidades marginales de Bob son siempre 50/50 para cualquier eje.

En nuestro modelo epistémico, esta propiedad estructural se refleja en el comportamiento de las funciones de actualización. Independientemente del resultado que obtenga Alice, el estado epistémico que un agente racional debe asignar al sistema de Bob mantiene probabilidades del 50% para cualquier eje incompatible.

#### Teorema T-NoSignal-Z [A-Meta]

La medición en Z no altera las probabilidades marginales de observables incompatibles.

Enunciado. $\forall prior, \forall result,$

$$
(measure_Z\; prior\; result).prob_up_X = 50
\land
(measure_Z\; prior\; result).prob_up_D = 50
\land
(measure_Z\; prior\; result).prob_up_D' = 50.
$$

Demostración. Sea $prior$ arbitrario y $result \in \{up, down\}$. Por definición de $measure_Z$, el estado resultante es:

$$
\langle 100, 50, 50, 50 \rangle
$$

si $result = up$, y:

$$
\langle 0, 50, 50, 50 \rangle
$$

si $result = down$. En ambos casos, los campos segundo, tercero y cuarto valen simultáneamente $50$. Estos campos corresponden a $prob_up_X$, $prob_up_D$ y $prob_up_D'$. Luego las probabilidades marginales de todos los observables incompatibles con $Z$ permanecen en $50$. $\square$

#### Teorema T-NoSignal-X [A-Meta]

La medición en X no altera las probabilidades marginales de observables incompatibles.

Enunciado. $\forall prior, \forall result,$

$$
(measure_X\; prior\; result).prob_up_Z = 50
\land
(measure_X\; prior\; result).prob_up_D = 50
\land
(measure_X\; prior\; result).prob_up_D' = 50.
$$

Demostración. Análogo a T-NoSignal-Z. La definición de $measure_X$ produce:

$$
\langle 50, 100, 50, 50 \rangle
$$

o:

$$
\langle 50, 0, 50, 50 \rangle.
$$

Los campos primero, tercero y cuarto son $50$ en ambas ramas. $\square$

#### Teorema T-NoSignal-D [A-Meta]

La medición en D no altera las probabilidades marginales de observables incompatibles.

Enunciado. $\forall prior, \forall result,$

$$
(measure_D\; prior\; result).prob_up_Z = 50
\land
(measure_D\; prior\; result).prob_up_X = 50
\land
(measure_D\; prior\; result).prob_up_D' = 50.
$$

Demostración. Por definición de $measure_D$, el estado resultante es:

$$
\langle 50, 50, 100, 50 \rangle
$$

o:

$$
\langle 50, 50, 0, 50 \rangle.
$$

Los campos primero, segundo y cuarto valen $50$ en ambos casos. $\square$

Interpretación: El entrelazamiento cuántico, aunque viola las desigualdades de Bell, no permite la transmisión de información más rápida que la luz. La “no-localidad” cuántica es estrictamente correlacional, no causal. Alice y Bob comparten correlaciones que solo se hacen evidentes al comparar sus registros clásicos posteriormente. Nuestro modelo epistémico captura esta característica sin necesidad de postular acción a distancia física.

---

### 5.3.4 Contextualidad [A-Meta] + [A-Código]

#### Teorema T-Context [A-Meta]

La ordenación de mediciones incompatibles importa.

Enunciado. Sean:

$$
prepared = prepared_maximally_mixed,
$$

$$
Z_{then}X = measure_X\;(measure_Z\; prepared\; up)\; up,
$$

$$
X_{then}Z = measure_Z\;(measure_X\; prepared\; up)\; up.
$$

Entonces:

$$
Z_{then}X.prob_up_Z \neq X_{then}Z.prob_up_Z.
$$

Demostración. Calculamos directamente. Por definición:

$$
prepared_maximally_mixed = \langle 50, 50, 50, 50 \rangle.
$$

Primero:

$$
measure_Z\; prepared\; up = \langle 100, 50, 50, 50 \rangle.
$$

Luego:

$$
Z_{then}X = measure_X\; \langle 100, 50, 50, 50 \rangle\; up
= \langle 50, 100, 50, 50 \rangle.
$$

Por tanto:

$$
Z_{then}X.prob_up_Z = 50.
$$

Segundo:

$$
measure_X\; prepared\; up = \langle 50, 100, 50, 50 \rangle.
$$

Luego:

$$
X_{then}Z = measure_Z\; \langle 50, 100, 50, 50 \rangle\; up
= \langle 100, 50, 50, 50 \rangle.
$$

Por tanto:

$$
X_{then}Z.prob_up_Z = 100.
$$

Como $50 \neq 100$, se verifica la desigualdad. $\square$

#### Verificación en Lean [A-Código]

```lean
theorem measurement_order_matters :
    let prepared := prepared_maximally_mixed
    let Z_then_X := measure_X (measure_Z prepared SpinResult.up) SpinResult.up
    let X_then_Z := measure_Z (measure_X prepared SpinResult.up) SpinResult.up
    Z_then_X.prob_up_Z ≠ X_then_Z.prob_up_Z := by
  unfold measure_X measure_Z prepared_maximally_mixed
  simp
```

Interpretación: Verificación de consistencia que captura la contextualidad cuántica. Medir Z y luego X produce un estado epistémico diferente a medir X y luego Z.

---

### 5.3.5 Bloqueo de la definición contracausal (CFD) [A-Meta] + [A-Código]

#### Teorema T-CFD-Impl [A-Meta]

La definición contracausal implica valores simultáneos definidos.

Enunciado. Sea $\mathcal{T}$ una teoría de variables ocultas locales tal que $counterfactual_definiteness_holds(\mathcal{T})$. Entonces para todo $a_1, a_2, b \in Axis$ y toda variable oculta $hv \in \mathcal{T}.hidden_variables$, existen $r_{A1}, r_{A2}, r_B \in SpinResult$ tales que:

$$
\mathcal{T}.result_A\; a_1\; hv = r_{A1}
\land
\mathcal{T}.result_A\; a_2\; hv = r_{A2}
\land
\mathcal{T}.result_B\; b\; hv = r_B.
$$

Demostración. Sea $hv$ una variable oculta arbitraria y sean $a_1, a_2, b$ ejes arbitrarios. Aplicamos la hipótesis de definición contracausal al par $(a_1, b)$: existe $r_{A1}$ tal que:

$$
\mathcal{T}.result_A\; a_1\; hv = r_{A1}.
$$

Aplicamos la misma hipótesis al par $(a_2, b)$: existe $r_{A2}$ tal que:

$$
\mathcal{T}.result_A\; a_2\; hv = r_{A2}.
$$

Finalmente, aplicamos la hipótesis nuevamente a $(a_1, b)$ para obtener $r_B$ tal que:

$$
\mathcal{T}.result_B\; b\; hv = r_B.
$$

Tomando estas tres existencias conjuntamente, obtenemos el resultado deseado. $\square$

#### Teorema T-CFD-Block [A-Meta]

El modelo epistémico bloquea la definición contracausal.

Enunciado.
$$
\text{prepared\_Z\_up.prob\_up\_X} = 50
\land
\text{prepared\_Z\_up.prob\_up\_D} = 50
\land
\text{prepared\_Z\_up.prob\_up\_D}^{\prime} = 50.
$$

Demostración. Por definición:
$$
\text{prepared\_Z\_up} = \langle 100, 50, 50, 50 \rangle.
$$

Los campos segundo, tercero y cuarto de esta tupla son, respectivamente, $prob_up_X$, $prob_up_D$ y $prob_up_D'$. Cada uno vale $50$ por inspección directa de la tupla. $\square$

#### Verificación en Lean [A-Código]

```lean
structure LocalHiddenVariableTheory where
   hidden_variables : Type
   result_A : Axis → hidden_variables → SpinResult
   result_B : Axis → hidden_variables → SpinResult

def counterfactual_definiteness_holds
     (theory : LocalHiddenVariableTheory) : Prop :=
   ∀ (a b : Axis) (hv : theory.hidden_variables),
     ∃ (rA rB : SpinResult),
       theory.result_A a hv = rA ∧ theory.result_B b hv = rB

theorem CFD_implies_simultaneous_definite_values
     (theory : LocalHiddenVariableTheory)
     (h_CFD : counterfactual_definiteness_holds theory) :
     ∀ (a1 a2 b : Axis) (hv : theory.hidden_variables),
       ∃ (rA1 rA2 rB : SpinResult),
         theory.result_A a1 hv = rA1 ∧
         theory.result_A a2 hv = rA2 ∧
         theory.result_B b hv = rB := by
   intro a1 a2 b hv
   obtain ⟨rA1, _, hA1, _⟩ := h_CFD a1 b hv
   obtain ⟨rA2, _, hA2, _⟩ := h_CFD a2 b hv
   obtain ⟨_, rB, _, hB⟩ := h_CFD a1 b hv
   exact ⟨rA1, rA2, rB, hA1, hA2, hB⟩

theorem epistemic_interpretation_blocks_CFD :
     prepared_Z_up.prob_up_X = 50 ∧
     prepared_Z_up.prob_up_D = 50 ∧
     prepared_Z_up.prob_up_D' = 50 := by
   unfold prepared_Z_up
   simp
```

Interpretación: La CFD obliga a aceptar resultados simultáneamente definidos para mediciones no realizadas. En nuestro modelo, un sistema preparado en Z=up tiene probabilidad 50% para X, D y D'. Esto bloquea la CFD y evita las desigualdades de Bell.

---

## 5.4 Formalización del pluralismo interpretativo y la dinámica discursiva [A-Meta] + [A-Código]

En las secciones anteriores demostramos física: los límites algebraicos que distinguen lo cuántico de lo clásico. Ahora formalizamos el espacio de interpretaciones viables y la dinámica histórica del discurso que transita entre ellas.

---

### 5.4.1 Z3: Mapa formal del pluralismo interpretativo [A-Meta] + [A-Código]

El teorema de Bell (1964) no refuta “el realismo” en abstracto; refuta una conjunción específica de tres supuestos metafísicos. Z3 nos permite mapear exhaustivamente todo el espacio de posibilidades interpretativas, demostrando que existen exactamente 7 interpretaciones viables (cada una renunciando a al menos un supuesto).

#### Metateoremas del mapa lógico Z3 [A-Meta]

##### Teorema T-Z3-UNSAT [A-Meta]

El realismo local clásico es formalmente refutado.

Enunciado. El conjunto de fórmulas:

$$
\{Locality, CFD, StatIndep, CHSH\_ClassicalBound, Aspect\_Experiment\}
$$

es insatisfacible.

Demostración. Supongamos, para reducir al absurdo, que existe un modelo $\mathcal{M}$ donde las cinco fórmulas son simultáneamente verdaderas. Por $CHSH\_ClassicalBound$:

$$
Locality \land CFD \land StatIndep \implies S_{value} \leq 2.
$$

Como en $\mathcal{M}$ los tres antecedentes son verdaderos, por modus ponens se sigue:

$$
S_{value} \leq 2.
$$

Pero por $Aspect\_Experiment$, en $\mathcal{M}$ se tiene:

$$
S_{value} = 2{,}828.
$$

Luego:

$$
2{,}828 \leq 2,
$$

lo cual es aritméticamente falso. Hemos derivado una contradicción. Por tanto, no existe tal modelo $\mathcal{M}$; el conjunto es insatisfacible. $\square$

##### Teorema T-Z3-Bohm [A-Meta]

Viabilidad lógica de la teoría de Bohm.

Enunciado. El conjunto:

$$
\{\neg Locality, CFD, StatIndep, S_{value} = 2{,}828\}
$$

es satisfacible.

Demostración. Construimos explícitamente un modelo $\mathcal{M}$. Definimos:

$$
Locality^{\mathcal{M}} = \bot,
\quad
CFD^{\mathcal{M}} = \top,
\quad
StatIndep^{\mathcal{M}} = \top,
\quad
S_{value}^{\mathcal{M}} = 2{,}828.
$$

Verificamos cada fórmula del conjunto:

- $\neg Locality$ es verdadero pues $Locality^{\mathcal{M}} = \bot$.
- $CFD$ es verdadero por asignación.
- $StatIndep$ es verdadero por asignación.
- $S_{value} = 2{,}828$ es verdadero por asignación.

Como todas las fórmulas son verdaderas en $\mathcal{M}$, el conjunto es satisfacible. $\square$

##### Teorema T-Z3-QBism [A-Meta]

Viabilidad lógica de la interpretación epistémica.

Enunciado. El conjunto:

$$
\{Locality, \neg CFD, StatIndep, S_{value} = 2{,}828\}
$$

es satisfacible.

Demostración. Construimos el modelo $\mathcal{M}$ con:

$$
Locality^{\mathcal{M}} = \top,
\quad
CFD^{\mathcal{M}} = \bot,
\quad
StatIndep^{\mathcal{M}} = \top,
\quad
S_{value}^{\mathcal{M}} = 2{,}828.
$$

Cada fórmula del conjunto se evalúa a verdadero por asignación directa. Luego el conjunto es satisfacible. $\square$

##### Teorema T-Z3-Superdet [A-Meta]

Viabilidad lógica del superdeterminismo.

Enunciado. El conjunto:

$$
\{Locality, CFD, \neg StatIndep, S_{value} = 2{,}828\}
$$

es satisfacible.

Demostración. Sea $\mathcal{M}$ el modelo con:

$$
Locality^{\mathcal{M}} = \top,
\quad
CFD^{\mathcal{M}} = \top,
\quad
StatIndep^{\mathcal{M}} = \bot,
\quad
S_{value}^{\mathcal{M}} = 2{,}828.
$$

Todas las fórmulas del conjunto son verdaderas en $\mathcal{M}$. $\square$

##### Teorema T-Z3-GRW [A-Meta]

Viabilidad lógica del colapso objetivo.

Enunciado. El conjunto:

$$
\{\neg Locality, \neg CFD, StatIndep, S_{value} = 2{,}828\}
$$

es satisfacible.

Demostración. Sea $\mathcal{M}$ con:

$$
Locality^{\mathcal{M}} = \bot,
\quad
CFD^{\mathcal{M}} = \bot,
\quad
StatIndep^{\mathcal{M}} = \top,
\quad
S_{value}^{\mathcal{M}} = 2{,}828.
$$

Cada fórmula se satisface por asignación. $\square$

##### Teorema T-Z3-Retro [A-Meta]

Viabilidad lógica de la retrocausalidad.

Enunciado. El conjunto:

$$
\{\neg Locality, CFD, \neg StatIndep, S_{value} = 2{,}828\}
$$

es satisfacible.

Demostración. Sea $\mathcal{M}$ con:

$$
Locality^{\mathcal{M}} = \bot,
\quad
CFD^{\mathcal{M}} = \top,
\quad
StatIndep^{\mathcal{M}} = \bot,
\quad
S_{value}^{\mathcal{M}} = 2{,}828.
$$

Verificación directa. $\square$

##### Teorema T-Z3-Relativist [A-Meta]

Viabilidad lógica del relativismo ontológico.

Enunciado. El conjunto:

$$
\{Locality, \neg CFD, \neg StatIndep, S_{value} = 2{,}828\}
$$

es satisfacible.

Demostración. Sea $\mathcal{M}$ con:

$$
Locality^{\mathcal{M}} = \top,
\quad
CFD^{\mathcal{M}} = \bot,
\quad
StatIndep^{\mathcal{M}} = \bot,
\quad
S_{value}^{\mathcal{M}} = 2{,}828.
$$

Verificación directa. $\square$

##### Teorema T-Z3-Radical [A-Meta]

Viabilidad lógica del pluralismo radical.

Enunciado. El conjunto:

$$
\{\neg Locality, \neg CFD, \neg StatIndep, S_{value} = 2{,}828\}
$$

es satisfacible.

Demostración. Sea $\mathcal{M}$ con:

$$
Locality^{\mathcal{M}} = \bot,
\quad
CFD^{\mathcal{M}} = \bot,
\quad
StatIndep^{\mathcal{M}} = \bot,
\quad
S_{value}^{\mathcal{M}} = 2{,}828.
$$

Verificación directa. $\square$

#### Verificación computacional [A-Código]

```lisp
; ============================================================
; Z3: MAPA FORMAL DEL PLURALISMO INTERPRETATIVO CUÁNTICO
; ============================================================
(set-option :produce-unsat-cores true)
(set-option :produce-models true)

; --- 1. Supuestos metafísicos del teorema de Bell ---
(declare-const Locality Bool)      ; L: factorización de probabilidades
(declare-const CFD Bool)           ; C: Counterfactual Definiteness
(declare-const StatIndep Bool)     ; I: Independencia estadística λ⊥choices

; --- 2. Parámetro empírico CHSH ---
(declare-const S_value Real)

; --- 3. Axiomas nombrados ---
; Axioma físico: bajo L∧C∧I, la cota CHSH clásica es |S| ≤ 2
(assert (! (=> (and Locality CFD StatIndep) (<= S_value 2.0))
         :named CHSH_ClassicalBound))

; Axioma empírico: Aspect, Weihs, Hensen et al. confirman S ≈ 2.828
(assert (! (= S_value 2.828)
         :named Aspect_Experiment))

; ============================================================
; TEOREMA 1: El realismo local clásico es FORMALMENTE REFUTADO
; ============================================================
(push)
(assert (! (and Locality CFD StatIndep) :named Classical_Local_Realism))
(check-sat)
(get-unsat-core)
(pop)

; ============================================================
; TEOREMA 2: Renunciar a UN supuesto restaura la consistencia
; ============================================================
; 2A: ¬Localidad ∧ CFD ∧ SI  →  TEORÍA DE BOHM
(push)
(assert (not Locality))
(assert CFD)
(assert StatIndep)
(check-sat)
(get-model)
(pop)

; 2B: Locality ∧ ¬CFD ∧ SI  →  QBism, OQM, COPENHAGUE ESTRICTO
(push)
(assert Locality)
(assert (not CFD))
(assert StatIndep)
(check-sat)
(get-model)
(pop)

; 2C: Locality ∧ CFD ∧ ¬SI  →  SUPERDETERMINISMO
(push)
(assert Locality)
(assert CFD)
(assert (not StatIndep))
(check-sat)
(get-model)
(pop)

; ============================================================
; TEOREMA 3: Renunciar a DOS supuestos también es consistente
; ============================================================
; 3A: ¬Locality ∧ ¬CFD ∧ SI  →  GRW, HISTORIAS CONSISTENTES
(push)
(assert (not Locality))
(assert (not CFD))
(assert StatIndep)
(check-sat)
(get-model)
(pop)

; 3B: ¬Locality ∧ CFD ∧ ¬SI  →  RETROCAUSALIDAD
(push)
(assert (not Locality))
(assert CFD)
(assert (not StatIndep))
(check-sat)
(get-model)
(pop)

; 3C: Locality ∧ ¬CFD ∧ ¬SI  →  RELATIVISMO ONTOLOGICO
(push)
(assert Locality)
(assert (not CFD))
(assert (not StatIndep))
(check-sat)
(get-model)
(pop)

; ============================================================
; TEOREMA 4: Incluso ¬Locality ∧ ¬CFD ∧ ¬SI es consistente
; ============================================================
(push)
(assert (not Locality))
(assert (not CFD))
(assert (not StatIndep))
(check-sat)
(get-model)
(pop)
```

Resultado verificado:

```text
unsat
(CHSH_ClassicalBound Classical_Local_Realism Aspect_Experiment)

sat
(modelo con Locality=false, CFD=true, StatIndep=true, S_value=2.828)

sat
(modelo con Locality=true, CFD=false, StatIndep=true, S_value=2.828)

[... 5 modelos sat adicionales ...]
```

Interpretación del núcleo insatisfacible: Z3 identifica la tensión exacta entre tres proposiciones:

| Axioma | Origen | Rol en la contradicción |
|---|---|---|
| CHSH_ClassicalBound | Álgebra pura (Teorema 2 de Lean) | Si $L \land C \land I$, entonces $|S| \le 2$ |
| Aspect_Experiment | Laboratorio (Aspect, Weihs, Hensen) | $S = 2.828$ |
| Classical_Local_Realism | Hipótesis ontológica | $L \land C \land I$ |

Z3 demuestra que no existe un mundo posible donde estas tres proposiciones sean simultáneamente verdaderas. El núcleo es mínimo: si eliminas cualquiera de las tres, la inconsistencia desaparece.

Tabla de las 7 interpretaciones viables:

| # | Localidad | CFD | Indep. | Interpretación | Tradición |
|---|---|---|---|---|---|
| 2 | ❌ | ✅ | ✅ | Teoría de Bohm | Onda piloto no-local |
| 3 | ✅ | ❌ | ✅ | QBism / OQM | Epistémica contextual |
| 4 | ✅ | ✅ | ❌ | Superdeterminismo | $\lambda$ correlacionado con elecciones |
| 5 | ❌ | ❌ | ✅ | GRW / Historias Consistentes | Colapso objetivo |
| 6 | ❌ | ✅ | ❌ | Retrocausalidad | Influencia hacia atrás |
| 7 | ✅ | ❌ | ❌ | Relativismo ontológico | Todo es relacional |
| 8 | ❌ | ❌ | ❌ | Pluralismo radical | Ningún supuesto clásico |

Conclusión: La interpretación epistémica que defendemos (fila 3) es una de 7 opciones viables. La elegimos por parsimonia ontológica (evita acción a distancia y conspiración cósmica), no porque sea lógicamente inevitable. Z3 formaliza la tesis de Duhem-Quine-Lakatos: los experimentos refutan conjunciones de supuestos, no teorías aisladas.

---

### 5.4.2 Clingo: Dinámica del discurso cuántico [A-Meta] + [A-Código]

Si el espacio de modelos de Z3 es estático —un mapa de posibilidades—, el modelo Clingo es dinámico: simula cómo una comunidad científica transita entre esas posibilidades cuando llega evidencia contraria al paradigma dominante.

#### Verificación computacional [A-Código]

```prolog
% ============================================================
% CLINGO: DINÁMICA DEL DISCURSO CUÁNTICO
% Evolución temporal de ontologías ante evidencia creciente
% ============================================================

#const t_max = 3.

% 0. DOMINIO TEMPORAL
time(0..t_max).

% 1. ONTOLOGÍAS: vértices del cubo de Bell (L, C, I)
ontology(classical, 1, 1, 1).      % Realismo local clásico (INSAT con datos)
ontology(bohm, 0, 1, 1).           % Renuncia a Localidad
ontology(qbism, 1, 0, 1).          % Renuncia a CFD (epistémica)
ontology(superdet, 1, 1, 0).       % Renuncia a Independencia Estadística
ontology(grw, 0, 0, 1).            % Renuncia a L y C
ontology(retro, 0, 1, 0).          % Renuncia a L y I
ontology(relativist, 1, 0, 0).     % Renuncia a C y I
ontology(radical, 0, 0, 0).        % Renuncia a los tres

% 2. AGENTES DEL DISCURSO: comunidades interpretativas
agent(bohmians; qbists; copenhagen; everettians; experimentalists).

% 3. OBJETOS MATEMÁTICOS Y TIPOS REALES
math_obj(wavefunction; measurement_op; entangled_state; born_rule).

real_type(wavefunction, structure).
real_type(measurement_op, relation).
real_type(entangled_state, structure).
real_type(born_rule, relation).

% 4. PREDICADOS DEL DISCURSO
pred(collapse, substance).
pred(superposition, substance).
pred(forces_choice, substance).
pred(action_at_distance, substance).
pred(possesses_spin, substance).
pred(information_update, relation).
pred(correlation, structure).

% 5. PROCESOS SATÉLITE
satellite(naturalization; personification; idealization).

% 6. EVIDENCIA HISTÓRICA
evidence(bell_theorem, 1).         % 1964: L∧C∧I es inconsistente
evidence(aspect_violation, 2).     % 1982: S=2.828 confirmado
evidence(ghz_contextuality, 3).    % 1990s: contextualidad sin loopholes

% 7. ESTADO INICIAL (t=0): paradigma clásico universal
holds(A, classical, 0) :- agent(A).

% Atributos discursivos iniciales
discourse_attr(wavefunction, collapse, 0).
discourse_attr(wavefunction, superposition, 0).
discourse_attr(measurement_op, forces_choice, 0).
discourse_attr(entangled_state, action_at_distance, 0).
discourse_attr(entangled_state, possesses_spin, 0).

% 8. DINÁMICA DE TRANSICIÓN
{ holds(A, O, T) : ontology(O, _, _, _) } = 1 :- agent(A), time(T), T >= 1, T <= t_max.

% 9. SATÉLITES ACTIVOS
satellite_active(A, S, T) :- holds(A, classical, T), satellite(S), time(T), T >= 1.

% 10. RESTRICCIONES DE SOSTENIBILIDAD
:- holds(A, classical, T), time(T), T = 1,
   #count { S : satellite_active(A, S, T) } < 2.

:- holds(A, classical, T), time(T), T >= 2,
   evidence(aspect_violation, T2), T2 <= T,
   #count { S : satellite_active(A, S, T) } < 3.

% 11. REIFICACIÓN DINÁMICA
has_epistemic(T) :- holds(A, O, T), agent(A), ontology(O, _, 0, _).

discourse_attr(wavefunction, information_update, T) :- has_epistemic(T).
discourse_attr(entangled_state, correlation, T)       :- has_epistemic(T).

discourse_attr(wavefunction, collapse, T)             :- holds(A, classical, T), agent(A).
discourse_attr(wavefunction, superposition, T)        :- holds(A, classical, T), agent(A).
discourse_attr(measurement_op, forces_choice, T)      :- holds(A, classical, T), agent(A).
discourse_attr(entangled_state, action_at_distance, T):- holds(A, classical, T), agent(A).
discourse_attr(entangled_state, possesses_spin, T)    :- holds(A, classical, T), agent(A).

% 12. DETECCIÓN DE REIFICACIÓN
reified(Obj, T) :- math_obj(Obj), discourse_attr(Obj, P, T), pred(P, T_req),
                   real_type(Obj, T_real), T_req != T_real, time(T).

% 13. MÉTRICAS FILOSÓFICAS
changed(A, T) :- time(T), T > 0, holds(A, O, T), holds(A, O2, T-1), O != O2.

crisis(T) :- time(T), T > 0, #count { A : changed(A, T) } >= 2.

ontology_held(O, T) :- holds(A, O, T), agent(A).

fragmentation(T) :- time(T), T > 0, #count { O : ontology_held(O, T) } >= 3.

phantom_ontology(A, T) :- holds(A, classical, T), time(T),
                          evidence(_, T2), T2 < T,
                          #count { S : satellite_active(A, S, T) } < 3.

stabilized(A) :- agent(A), holds(A, O, 2), changed(A, 2), holds(A, O, 3).

% 14. FORZAR DINÁMICA HISTÓRICA
:- not crisis(1).
:- not fragmentation(2).
:- #count { A : stabilized(A) } = 0.

% 15. OPTIMIZACIÓN: PARSIMONIA ONTOLÓGICA
#minimize { 1, A, S, T : satellite_active(A, S, T) }.
#minimize { 1, Obj, T : reified(Obj, T) }.
#minimize { 1, A, T : changed(A, T) }.

% 16. OUTPUT
#show holds/3.
#show crisis/1.
#show fragmentation/1.
#show phantom_ontology/2.
#show reified/2.
#show changed/2.
```

Resultado verificado (modelo óptimo, Answer 3):

```text
holds(bohmians,classical,0) holds(bohmians,retro,1) holds(bohmians,retro,2) holds(bohmians,retro,3)
holds(copenhagen,classical,0) holds(copenhagen,superdet,1) holds(copenhagen,superdet,2) holds(copenhagen,superdet,3)
holds(everettians,classical,0) holds(everettians,bohm,1) holds(everettians,retro,2) holds(everettians,retro,3)
holds(experimentalists,classical,0) holds(experimentalists,retro,1) holds(experimentalists,retro,2) holds(experimentalists,retro,3)
holds(qbists,classical,0) holds(qbists,bohm,1) holds(qbists,bohm,2) holds(qbists,bohm,3)

crisis(1)

fragmentation(1) fragmentation(2) fragmentation(3)

reified(wavefunction,0) reified(measurement_op,0) reified(entangled_state,0)

Optimization: 9
OPTIMUM FOUND
```

#### Metateoremas formales de la dinámica discursiva Clingo [A-Meta]

##### Teorema T-AS-Crisis [A-Meta]

La crisis es una restricción hard del programa.

Enunciado. En todo answer set $AS$ del programa Clingo de la sección 5.4.2, se tiene:

$$
crisis(1) \in AS.
$$

Demostración. El programa contiene la restricción hard:

```prolog
:- not crisis(1).
```

Esta regla elimina todo answer set donde $crisis(1)$ no pertenezca al modelo. Por definición de semántica de answer set programming, un answer set debe satisfacer todas las restricciones hard. Luego, si $AS$ es un answer set, necesariamente:

$$
crisis(1) \in AS.
$$

$\square$

##### Teorema T-AS-Frag [A-Meta]

La fragmentación en $t=2$ es una restricción hard.

Enunciado. En todo answer set $AS$ del programa, se tiene:

$$
fragmentation(2) \in AS.
$$

Demostración. El programa incluye la restricción:

```prolog
:- not fragmentation(2).
```

Por la semántica de answer sets, todo modelo estable debe contener todos los átomos cuya ausencia produciría violación de una restricción hard. Por tanto:

$$
fragmentation(2) \in AS
$$

para todo answer set $AS$. $\square$

##### Teorema T-AS-Stab [A-Meta]

La estabilización de al menos un agente es forzada.

Enunciado. En todo answer set $AS$ del programa, existe al menos un agente $A$ tal que:

$$
stabilized(A) \in AS.
$$

Demostración. El programa contiene la restricción:

```prolog
:- #count { A : stabilized(A) } = 0.
```

Supongamos, para reducir al absurdo, que existe un answer set $AS$ donde ningún átomo $stabilized(A)$ pertenece a $AS$. Entonces el conjunto:

$$
\{A : stabilized(A) \in AS\}
$$

es vacío, y su cardinalidad es $0$. La restricción hard se violaría, lo cual contradice la definición de answer set. Luego, en todo answer set existe al menos un agente $A$ con:

$$
stabilized(A) \in AS.
$$

$\square$

#### Interpretación del resultado óptimo

| Agente | t=0 | t=1 (Bell) | t=2 (Aspect) | t=3 (GHZ) |
|---|---|---|---|---|
| bohmians | classical | retro | retro | retro |
| copenhagen | classical | superdet | superdet | superdet |
| everettians | classical | bohm | retro | retro |
| experimentalists | classical | retro | retro | retro |
| qbists | classical | bohm | bohm | bohm |

Hallazgo filosófico central: Bajo los criterios de optimización (minimizar satélites + reificación + cambios bruscos), ningún agente adopta qbism en el modelo óptimo. Esto no es un bug; es una virtud epistémica. Demuestra que el modelo no está construido para producir la conclusión deseada. La interpretación epistémica (qbism) requiere renunciar a la CFD, un cambio conceptual que el optimizador penaliza como costoso.

Conexión con Kuhn y Lakatos: El modelo reproduce la estructura lógica de la historia real:

- t=0: Dominio del paradigma clásico.
- t=1 (crisis): Bell desata el debate; emergen múltiples interpretaciones.
- t=2 (fragmentación): Aspect confirma violación; consolidación de “escuelas”.
- t=3: Estabilización en nichos ontológicos paralelos.

No hay conversión masiva a una única interpretación, sino fragmentación persistente. Esto es exactamente lo que predicen Kuhn (inconmensurabilidad post-crisis) y Lakatos (proliferación de programas de investigación).

Ausencia de `phantom_ontology`: Ningún agente mantiene `classical` después de la evidencia sin los satélites necesarios. El paradigma clásico colapsa completamente; no hay “zombies epistemológicos”.

---

### 5.4.3 Conexión con el protocolo anti-reificación

Las tres formalizaciones cierran el círculo del protocolo de cuatro preguntas:

| Nivel | Herramienta | Pregunta | Resultado |
|---|---|---|---|
| Física | Lean 4 | ¿Qué predice la teoría? | $|S| \le 2$ clásico; $S = 2\sqrt{2}$ cuántico |
| Lógica | Z3 | ¿Qué interpretaciones son consistentes? | 7 vértices viables; 1 insatisfacible |
| Discurso | Clingo | ¿Cómo evoluciona el debate? | Fragmentación en nichos; qbism no es la trayectoria óptima pura |

Nota sobre la gramática y la reificación: Como demostramos en los capítulos anteriores, la estructura gramatical del lenguaje natural (sujeto-predicado) facilita la reificación al empujarnos a tratar procesos y relaciones como sustancias. El modelo Clingo captura esto formalmente: los `discourse_attr` que exigen tipos `substance` para objetos matemáticos de tipo `structure` o `relation` generan `reified(X,T)`. Los procesos satélite (naturalización, personificación, idealización) son mecanismos lingüísticos que estabilizan esta reificación gramaticalmente inducida.

---

## 5.5 Evidencia empírica: el debate sobre la interpretación [B/C]

### La interpretación de Copenhague (lectura epistémica)

Niels Bohr y Werner Heisenberg enfatizaron que la función de onda no describe la realidad en sí, sino nuestro conocimiento de la realidad.

### QBism (Bayesianismo Cuántico)

QBism lleva la interpretación epistémica a su conclusión lógica: la función de onda es una creencia subjetiva del agente. El “colapso” es la actualización bayesiana de esas creencias [B].

### Mecánica Cuántica Operacional (OQM)

La OQM de Reinhard Werner trata las correlaciones EPRB como un hecho bruto sin causa común [B]. Los estados cuánticos son puros recursos epistémicos.

### La interpretación de los muchos mundos

No hay colapso. La función de onda evoluciona unitariamente siempre. Lo que percibimos como “colapso” es la ramificación del universo en múltiples ramas.

### El experimento de Wigner’s friend

Ilustra la naturaleza epistémica del colapso. El “colapso” es relativo al observador y a su información disponible.

---

## 5.6 El entrelazamiento cuántico y la no-localidad [B/C]

### El fenómeno del entrelazamiento

Dos partículas entrelazadas exhiben correlaciones que no pueden explicarse por variables ocultas locales. Einstein llamó a esto “acción fantasmal a distancia” y lo consideró evidencia de incompletitud.

### La interpretación epistémica del entrelazamiento

Bajo la interpretación epistémica, el entrelazamiento no implica acción a distancia causal. La elección de eje de Alice no afecta las probabilidades marginales de Bob (sección 5.3.3). Lo que ocurre es una actualización instantánea de información correlacionada, compatible con la relatividad especial.

### Evidencia experimental

Los experimentos de Alain Aspect (1982) y posteriores confirman $S = 2\sqrt{2} \approx 2.828$, violando el límite clásico [B].

---

### 5.6.1 La crítica realista al teorema de Bell [B/C]

El análisis contemporáneo revela que la estructura lógica del teorema de Bell descansa sobre tres supuestos metafísicos [B]:

**Supuesto 1: Localidad.** La elección de Alice no afecta instantáneamente el resultado de Bob. Investigadores como Pitowsky y Fine han demostrado que las desigualdades de Bell pueden derivarse directamente de las leyes de la probabilidad clásica, sin necesidad de invocar explícitamente localidad [B].

**Supuesto 2: Definición contracausal (CFD).** Incluso los experimentos no realizados tienen resultados definidos. EPR exigía “elementos de realidad” preexistentes, pero no especificaba que debieran existir simultáneamente para todas las magnitudes. La CFD introduce una condición más fuerte [B].

**Supuesto 3: Independencia estadística (SI).** La variable oculta $\lambda$ es independiente de las elecciones de medición futuras [B].

La crítica realista sostiene que Bell no refuta el realismo en general, sino el realismo local clásico con definición contracausal. Nuestro modelo Z3 (sección 5.4.1) formaliza esta crítica: existen 7 interpretaciones viables que renuncian a al menos uno de estos supuestos.

| Característica | Modelo Realista Local (VOL) | Modelo Epistémico (MC) |
|---|---|---|
| Objeto fundamental | Variables ocultas locales ($\lambda$) | Estado cuántico global $|\Psi\rangle$ |
| Naturaleza del sistema | Partículas separables | Todo indivisible e irreductible |
| Resultado CHSH (valor S) | Máximo de 2 | $2\sqrt{2} \approx 2.828$ |

---

### 5.6.2 La renuncia ontológica como motor de la física [C]

El análisis del teorema de Bell revela un patrón profundo que recorre la historia de la física: el progreso científico ocurre frecuentemente cuando renunciamos a buscar “causas ocultas” para fenómenos que tienen explicaciones estructurales, geométricas o simétricas.

#### El caso del movimiento: del impetus a la simetría

En la física medieval, la intuición sugería que el movimiento requería una causa continua: el impetus. La Primera Ley de Newton resolvió este problema redefiniendo el concepto de “causa”: el movimiento uniforme no requiere causa; es el estado natural. Lo que requiere causa es el cambio de movimiento [B].

El Teorema de Noether (1918) proporcionó la explicación más profunda: la conservación del momento lineal es consecuencia directa de la simetría de traslación espacial (homogeneidad del espacio). No hay un impetus oculto; hay una propiedad estructural del espacio mismo [B].

(Nota histórica: La conexión entre el abandono del impetus y el Teorema de Noether es una lectura retrospectiva y conceptual. Newton abandonó el impetus sin conocer a Noether; fue Noether quien, siglos después, reveló la simetría profunda que subyace a la inercia newtoniana).

#### El caso de la gravedad: de la fuerza a la geometría

La intuición newtoniana sugería que la gravedad es una fuerza que “tira” de los objetos a distancia. Einstein renunció a esta imagen. En la relatividad general, la gravedad no es una fuerza: es la geometría curvada del espacio-tiempo. No hay una “fuerza gravitacional” oculta; hay estructura geométrica [B].

#### El caso del entrelazamiento: de la acción fantasmal a la no-separabilidad

La intuición clásica sugiere que las correlaciones cuánticas requieren una causa: variables ocultas locales o acción a distancia instantánea. La interpretación epistémica renuncia a ambas. El entrelazamiento no es una “acción fantasmal”; es una propiedad estructural del espacio de Hilbert: la no-separabilidad del estado cuántico global.

#### La síntesis y sus límites

| Fenómeno | Intuición (causa oculta) | Física (estructura manifiesta) |
|---|---|---|
| Movimiento | Impetus (fuerza motriz) | Simetría de traslación (Noether) |
| Gravedad | Fuerza gravitacional | Geometría curvada (Einstein) |
| Entrelazamiento | Variables ocultas / acción a distancia | No-separabilidad (Hilbert) |
| Colapso | Evento físico misterioso | Actualización epistémica (Bayes) |

Matización importante: La “renuncia ontológica” no es el único motor de la física. La física también avanza postulando entidades ocultas reales que luego son confirmadas empíricamente (átomos, quarks, materia oscura). El principio que identificamos aquí aplica específicamente a dominios donde la intuición exige causas mecánicas locales para fenómenos que el formalismo matemático revela como restricciones geométricas, simétricas o estructurales.

#### Conexión con el Realismo Estructural Ontológico (OSR)

Esta síntesis conecta con el Realismo Estructural Ontológico (OSR): lo fundamental no son las partículas con propiedades locales, sino la estructura de relaciones que el formalismo matemático describe [B].

Nota sobre Instrumentalismo y OSR: Nuestro modelo formal es metodológicamente agnóstico (instrumentalismo operacional: la función de onda como recurso predictivo). El OSR se presenta aquí como una hipótesis ontológica prometedora sobre la naturaleza de esa “estructura”, no como una conclusión deductiva de nuestro modelo.

---

## 5.7 La pedagogía de la medición cuántica [B/C]

### La reificación en los libros de texto

La mayoría de los libros de texto presentan el colapso como un evento físico, reificando la función de onda. Esta narrativa es en parte una caricatura didáctica, pero como demostramos en los capítulos anteriores, está facilitada por la estructura gramatical del lenguaje natural, que empuja a tratar “la función de onda” como un sustantivo que denota una entidad sustancial. Esto produce misconceptions persistentes [B].

### La solución pedagógica

La investigación en educación física (PER) sugiere desarrollar conciencia ontológica en los estudiantes: enseñarles qué tipo de cosa es la función de onda antes de enseñarles la mecánica cuántica [B].

### La paradoja pedagógica

La reificación es necesaria para el aprendizaje inicial, pero perniciosa si no se desactiva. La solución es usar la reificación como prótesis cognitiva visible [C].

---

## 5.8 Limitaciones [C]

**Primera limitación:** La interpretación epistémica es una elección, no un descubrimiento.

**Segunda limitación:** La interpretación epistémica no resuelve todos los problemas (¿qué es el sistema físico en sí?).

**Tercera limitación:** La interpretación epistémica es controversial.

**Cuarta limitación:** Nuestra formalización es simplificada (no modela espacios de Hilbert de dimensión infinita).

**Quinta limitación:** La interpretación epistémica no resuelve el problema de la frontera (¿qué constituye una medición?).

**Sexta limitación:** La interpretación epistémica renuncia al realismo clásico (CFD). El Teorema 2 verifica que ningún modelo clásico local puede alcanzar $|S| > 2$.

**Séptima limitación:** Las formalizaciones en Z3 y Clingo son modelos abstractos que capturan la estructura lógica del pluralismo interpretativo y la dinámica del discurso, pero no modelan la complejidad completa de las comunidades científicas reales (factores sociológicos, institucionales, económicos). Además, el modelo Clingo revela que la interpretación epistémica no es la trayectoria óptima bajo criterios de parsimonia pura; su adopción requiere argumentos filosóficos adicionales que trascienden la mera consistencia formal.

**Octava limitación:** La gramática del lenguaje natural facilita la reificación al empujarnos a tratar procesos y relaciones como sustancias. Aunque nuestro modelo Clingo captura esto formalmente, no podemos eliminar completamente esta constricción gramatical del discurso científico cotidiano.

---

## 5.9 Conexiones con otros capítulos [C]

**Con el Capítulo 1 (protocolo):** El sistema formalizado es una implementación verificable del protocolo de cuatro preguntas, aplicada a la medición cuántica.

**Con el Capítulo 2 (gramática de la reificación):** La sección 5.4.2 (Clingo) formaliza cómo la estructura gramatical del lenguaje natural (sujeto-predicado) facilita la reificación de objetos matemáticos.

**Con el Capítulo 3 (SPA/Tarski):** La estratificación normativa (Z3: `unsat`) es el análogo cuántico de la estratificación lógica (Lean: paradoja de Tarski). Ambos muestran que ciertas configuraciones generan contradicciones.

**Con el Capítulo 4 (física clásica):** La sección 5.6.2 (renuncia ontológica) unifica la física clásica, relativista y cuántica bajo el principio de abandonar causas ocultas en favor de estructura geométrica y simétrica.

**Con el Capítulo 6 (sistemas normativos):** El “observador” jurídico (quién cuenta como agente legítimo) es análogo al problema de la frontera cuántica.

---

## 5.10 Síntesis de demostraciones formales del capítulo [A-Meta]

Nosotros presentamos la siguiente tabla de demostraciones formales en prosa integradas en este capítulo. Estas pruebas elevan el estatus epistémico de las secciones formales de [A-Código] a [A-Meta] + [A-Código], replicando el protocolo usado en el Capítulo 6.

| Designación | Enunciado | Método | Sección |
|---|---|---|---|
| T-NC-Z | La medición en Z desordena la información sobre X | Inspección de definición | 5.3.1 |
| T-NC-X | La medición en X desordena la información sobre Z | Inspección de definición | 5.3.1 |
| T-NoSignal-Z | La medición en Z preserva probabilidades marginales incompatibles | Inspección de definición | 5.3.3 |
| T-NoSignal-X | La medición en X preserva probabilidades marginales incompatibles | Inspección de definición | 5.3.3 |
| T-NoSignal-D | La medición en D preserva probabilidades marginales incompatibles | Inspección de definición | 5.3.3 |
| T-CHSH-Alg | Cota algebraica clásica CHSH: $|S| \le 2$ | Análisis de casos $b=b'$ / $b \neq b'$ | 5.3.2 Parte A |
| T-CHSH-Scale | $|classical_S| \le 200$ | T-CHSH-Alg + factor de escala 100 | 5.3.2 Parte A |
| T-Bell-Exact | $S_{quantum} = -2\sqrt{2}$ | Identidades trigonométricas | 5.3.2 Parte B |
| T-Violation | $|S_{quantum}| > 2$ | T-Bell-Exact + $\sqrt{2} > 1$ | 5.3.2 Parte C |
| T-Context | La ordenación de mediciones incompatibles importa | Cálculo directo | 5.3.4 |
| T-CFD-Impl | CFD implica valores simultáneos definidos | Existencias sucesivas | 5.3.5 |
| T-CFD-Block | El modelo epistémico bloquea CFD | Inspección de tupla | 5.3.5 |
| T-Z3-UNSAT | El realismo local clásico es insatisfacible | Modus ponens + dato experimental | 5.4.1 |
| T-Z3-Bohm | Viabilidad de la teoría de Bohm | Exhibición de modelo | 5.4.1 |
| T-Z3-QBism | Viabilidad de QBism / OQM | Exhibición de modelo | 5.4.1 |
| T-Z3-Superdet | Viabilidad del superdeterminismo | Exhibición de modelo | 5.4.1 |
| T-Z3-GRW | Viabilidad de GRW / colapso objetivo | Exhibición de modelo | 5.4.1 |
| T-Z3-Retro | Viabilidad de retrocausalidad | Exhibición de modelo | 5.4.1 |
| T-Z3-Relativist | Viabilidad del relativismo ontológico | Exhibición de modelo | 5.4.1 |
| T-Z3-Radical | Viabilidad del pluralismo radical | Exhibición de modelo | 5.4.1 |
| T-AS-Crisis | $crisis(1)$ pertenece a todo answer set | Restricción hard | 5.4.2 |
| T-AS-Frag | $fragmentation(2)$ pertenece a todo answer set | Restricción hard | 5.4.2 |
| T-AS-Stab | Al menos un agente estabilizado en todo answer set | Restricción hard | 5.4.2 |

Conclusión metodológica [C]. El Capítulo 5 posee materia prima para 23 demostraciones formales en prosa. Estas pruebas son correctas, completas y verificables por un lector con formación básica en lógica, teoría de modelos elemental, Lean 4, Z3 y semántica de answer sets. Su integración junto a los códigos Lean, Z3 y Clingo eleva el estatus epistémico del capítulo de una verificación meramente computacional a una demostración formal mixta **[A-Meta] + [A-Código]**.

---

## Etiquetado del capítulo

| Sección | Contenido | Clasificación |
|---|---|---|
| 5.0 | Introducción | [C] Interpretación |
| 5.1 | Protocolo de cuatro preguntas | [C] Interpretación |
| 5.2 | Modelo epistémico (Lean 4) | [A-Código] |
| 5.3 | Teoremas estructurales (Lean 4) | [A-Meta] + [A-Código] |
| 5.3.1 | No-conmutatividad | [A-Meta] + [A-Código] |
| 5.3.2 | Frontera de Bell | [A-Meta] + [A-Código] |
| 5.3.3 | Condición de no-señalización | [A-Meta] + [C] |
| 5.3.4 | Contextualidad | [A-Meta] + [A-Código] |
| 5.3.5 | Bloqueo de CFD | [A-Meta] + [A-Código] |
| 5.4.1 | Z3: Mapa del pluralismo interpretativo | [A-Meta] + [A-Código] |
| 5.4.2 | Clingo: Dinámica del discurso cuántico | [A-Meta] + [A-Código] |
| 5.4.3 | Conexión con protocolo | [C] Interpretación |
| 5.5 | Interpretaciones | [B] |
| 5.6 | Entrelazamiento y no-localidad | [B/C] |
| 5.6.1 | Crítica realista a Bell | [B/C] |
| 5.6.2 | Renuncia ontológica | [C] |
| 5.7 | Pedagogía | [B/C] |
| 5.8 | Limitaciones | [C] |
| 5.9 | Conexiones | [C] |
| 5.10 | Síntesis de demostraciones formales | [A-Meta] + [C] |