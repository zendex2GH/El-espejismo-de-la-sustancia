
# Capítulo 2: Herramientas formales para no especialistas

## 2.1 Por qué herramientas formales

En el Capítulo 1 presentamos el método de análisis de la reificación como error categorial y mostramos su aplicación a tres dominios: el espacio-tiempo en física, el Estado/nación/patria en ciencias sociales, y las leyes lógicas en filosofía. El método opera mediante un protocolo de cuatro preguntas que permite identificar cuándo el discurso atribuye propiedades a una entidad que no corresponden a su tipo formal.

Pero el método, tal como lo presentamos, tiene una limitación: opera en lenguaje natural. Y el lenguaje natural, como señalamos en el cierre del Capítulo 1, reifica por estructura gramatical. Cuando decimos "la reificación produce efectos de poder", estamos convirtiendo una categoría analítica en un sujeto con agencia. Cuando decimos "los procesos de estabilización operan", estamos atribuyendo causalidad a funciones sintácticas. El lenguaje natural nos obliga a reificar incluso cuando intentamos denunciar la reificación.

Para superar esta limitación, **nosotros utilizamos** herramientas formales de verificación: sistemas computacionales que **nos permiten** expresar afirmaciones en un lenguaje con sintaxis precisa, semántica definida y reglas de inferencia que garantizan la validez de las derivaciones. Estas herramientas no reemplazan el análisis conceptual; lo complementan. **Las usamos** como un microscopio: **nos permiten** ver con precisión lo que el ojo desnudo (el lenguaje natural) no puede distinguir.

La analogía del microscopio es útil pero limitada. **Con** un microscopio **observamos** estructuras que existen independientemente del instrumento. **Con** las herramientas formales, en cambio, **construimos** la precisión que **observamos**. La diferencia es crucial: las herramientas formales no muestran "la verdad"; **nos permiten demostrar** las consecuencias lógicas de ciertas premisas. Que un teorema compile en un asistente de pruebas garantiza que la conclusión se sigue de las premisas, pero no garantiza que las premisas sean verdaderas. La verdad de las premisas es una cuestión empírica o filosófica que las herramientas no pueden resolver.

En este capítulo presentamos las tres herramientas que **utilizaremos** en los capítulos siguientes: **Lean 4** (un asistente de pruebas interactivo), **Z3** (un solver SMT que verifica satisfacibilidad), y **Clingo** (un sistema de programación lógica que maneja razonamiento por defecto). Las presentaremos en ese orden: primero la herramienta más expresiva (Lean 4), luego la más automatizada (Z3), y finalmente la más adecuada para razonamiento con excepciones (Clingo). El objetivo no es convertir al lector en programador, sino proporcionarle el vocabulario conceptual necesario para entender qué **hacemos con** estas herramientas, qué tipo de resultados **obtenemos**, y cómo interpretar esos resultados en el contexto del método de análisis de la reificación.

## 2.2 Lean 4: Verificación interactiva de pruebas

### Qué es

Lean 4 es un asistente de pruebas interactivo desarrollado por Leonardo de Moura y colaboradores en Microsoft Research.¹ Es un sistema que **nos permite** escribir demostraciones matemáticas en un lenguaje formal y verificar automáticamente que cada paso sea lógicamente válido. Si la demostración compila, **sabemos formalmente** que el teorema se sigue de los axiomas según las reglas de inferencia definidas.

---
¹ de Moura, L., & Ullrich, S. (2021). "The Lean 4 Theorem Prover and Programming Language". *Proceedings of the 28th International Conference on Automated Deduction (CADE-28)*, Springer. El kernel de Lean 4 (la base de código computacionalmente confiable, o *Trusted Computing Base*, TCB) tiene aproximadamente 6000 líneas de código auditables.
---

La diferencia con una demostración en lenguaje natural es radical. En una demostración escrita en prosa, el lector debe confiar en que el autor no cometió errores, no omitió pasos, no incurrió en peticiones de principio. En una demostración en Lean 4, el **kernel del sistema** verifica cada paso. Si el kernel acepta la demostración, la probabilidad de error se reduce a la posibilidad de un fallo de hardware o un bug en el propio kernel (el TCB).

### Cómo funciona: un ejemplo introductorio

Lean 4 se basa en la **teoría de tipos dependientes**, un sistema lógico que **permite** expresar no solo proposiciones ("X es verdadero") sino también dependencias entre tipos ("para todo X de tipo T, existe Y de tipo U(X)"). Esto **nos permite** formalizar estructuras matemáticas complejas con precisión extrema.

Comenzamos con un ejemplo simple que ilustra la mecánica básica. El siguiente código define la estructura de la reificación como un cambio de tipo y demuestra una propiedad elemental:

```lean
-- Definición de tipos
inductive EntityKind
  | relation
  | regularity
  | convention
  | formal_struct
  | substance

-- Definición de la reificación como cambio de tipo
structure Reification where
  entity : String
  actual_kind : EntityKind
  attributed_kind : EntityKind
  h_not_substance : actual_kind ≠ EntityKind.substance
  h_attributed_substance : attributed_kind = EntityKind.substance

-- Teorema: la reificación es un error categorial
theorem reification_is_category_mistake
  (r : Reification) :
  r.actual_kind ≠ r.attributed_kind := by
  intro h
  have h_contra : r.actual_kind = EntityKind.substance := by
    rw [h]
    exact r.h_attributed_substance
  exact r.h_not_substance h_contra
```

Este código define:
1. Un tipo `EntityKind` con cinco valores posibles (relación, regularidad, convención, estructura formal, sustancia).
2. Una estructura `Reification` que representa el error categorial: una entidad cuyo tipo real no es sustancia, pero cuyo tipo atribuido sí lo es.
3. Un teorema que demuestra que, bajo estas definiciones, el tipo real y el tipo atribuido son distintos.

La línea `theorem reification_is_category_mistake` declara el teorema. La sección que comienza con `by` contiene la demostración paso a paso. Si la demostración es correcta, Lean 4 la acepta. Si hay un error, Lean 4 señala exactamente dónde está el problema.

**Nota importante sobre este ejemplo:** Este teorema es conceptualmente trivial: la conclusión ya está contenida en las hipótesis. Su propósito no es demostrar una tesis sustantiva sobre la reificación, sino ilustrar la mecánica básica de cómo se escribe y verifica una prueba en Lean 4. En la siguiente sección presentamos un teorema con contenido conceptual real.

### Un teorema sustantivo: La reificación destruye la accountability

El siguiente teorema demuestra formalmente que cuando un discurso reifica una construcción institucional (atribuyéndole agencia), ese discurso pierde la capacidad de identificar responsables concretos para sus decisiones. No es una opinión política: es una propiedad estructural demostrable.

```lean
-- ============================================================
-- Teorema: La reificación institucional destruye la accountability
-- ============================================================

-- Fuente de agencia: individual o institucional
inductive AgencySource (Person : Type) (Institution : Type) where
  | individual (p : Person)
  | institutional (i : Institution)

-- Una decisión tiene una fuente de agencia
structure Decision (Person : Type) (Institution : Type) where
  agency : AgencySource Person Institution

-- Un discurso es una lista de decisiones
-- IMPORTANTE: usamos `abbrev` en lugar de `def` para que
-- las instancias de type class de List se hereden correctamente
abbrev Discourse (Person : Type) (Institution : Type) :=
  List (Decision Person Institution)

-- Un discurso reifica una institución si todas sus decisiones
-- atribuyen agencia a esa institución
def is_reified {Person Institution : Type}
    (D : Discourse Person Institution) (inst : Institution) : Prop :=
  ∀ d ∈ D, d.agency = AgencySource.institutional inst

-- Una decisión es "accountable" si tiene un agente concreto responsable
def is_accountable {Person Institution : Type}
    (d : Decision Person Institution) : Prop :=
  ∃ p : Person, d.agency = AgencySource.individual p

-- Un discurso es plenamente accountable si todas sus decisiones
-- tienen un responsable concreto
def fully_accountable {Person Institution : Type}
    (D : Discourse Person Institution) : Prop :=
  ∀ d ∈ D, is_accountable d

-- Teorema 1: La reificación excluye la agencia individual
theorem reification_excludes_individual_agency
    {Person Institution : Type}
    (D : Discourse Person Institution) (inst : Institution) :
    is_reified D inst →
    ∀ (d : Decision Person Institution), d ∈ D → ¬ is_accountable d := by
  intro h_reif d hd_in
  have h_inst := h_reif d hd_in
  intro h_account
  obtain ⟨p, hp⟩ := h_account
  rw [hp] at h_inst
  nomatch h_inst

-- Teorema 2: La reificación destruye la accountability
theorem reification_destroys_accountability
    {Person Institution : Type}
    (D : Discourse Person Institution) (inst : Institution) :
    is_reified D inst →
    (∃ d : Decision Person Institution, d ∈ D) →
    ¬ fully_accountable D := by
  intro h_reif ⟨d, hd_in⟩ h_accountable
  have h_not_account := reification_excludes_individual_agency D inst h_reif d hd_in
  exact h_not_account (h_accountable d hd_in)
```

**Explicación conceptual del Teorema 1:**
1. Asumimos que el discurso reifica la institución (`h_reif`).
2. Tomamos una decisión `d` que pertenece al discurso.
3. Por definición de reificación, `d.agency = institutional inst`.
4. Asumimos (para reducir al absurdo) que `d` es accountable.
5. Obtenemos la persona concreta `p` responsable.
6. Reescribimos: ahora tenemos `individual p = institutional inst`.
7. Esto es imposible porque los constructores son distintos. Contradicción. ∎

**Explicación conceptual del Teorema 2:**
1. Usamos el Teorema 1 para mostrar que si el discurso reifica y tiene al menos una decisión, esa decisión no es accountable.
2. Pero `fully_accountable` exige que TODAS las decisiones sean accountable.
3. Contradicción. ∎

**¿Por qué este teorema importa?** Formaliza exactamente lo que afirmamos en el Capítulo 1 sobre el Estado/nación/patria: cuando el discurso dice "el Estado decide", las responsabilidades de los agentes concretos se diluyen. El Teorema 2 demuestra que esa dilución no es accidental: es una **consecuencia lógica necesaria** de la reificación. Si un discurso reifica, entonces por definición no puede ser accountable. No hay forma de tener ambas cosas simultáneamente.

**Nota técnica sobre `abbrev`:** Usamos `abbrev` en lugar de `def` para definir `Discourse` porque en Lean 4, `def` crea un alias de tipo que no hereda automáticamente las instancias de type class del tipo original. Con `abbrev`, el alias es completamente transparente para el elaborador, lo que permite que la instancia de `Membership` de `List` se resuelva correctamente.

**Nota técnica sobre `nomatch`:** La táctica `nomatch h_inst` cierra el objetivo porque `h_inst` es una igualdad entre dos constructores distintos de un tipo inductivo (`AgencySource.individual p = AgencySource.institutional inst`). Lean reconoce que no hay forma de que esta igualdad sea verdadera y cierra el objetivo. Si `nomatch` no funciona en alguna versión de Lean, se puede reemplazar por `cases h_inst`.

> **Nota sobre la naturaleza del teorema:** Un lector atento podría señalar que este teorema es, en cierto sentido, una tautología definicional: si definimos la reificación como la exclusión de la agencia individual, y la *accountability* como su requisito, la conclusión se sigue por mera definición. La observación es correcta, pero el valor del teorema no reside en revelar una propiedad oculta del mundo, sino en hacer **explícita y computacionalmente verificable** la consecuencia estructural de nuestras definiciones. Al formalizarlo, demostramos que la dilución de responsabilidad no es un efecto secundario accidental o retórico de la reificación, sino su consecuencia lógica ineludible bajo este modelo. 
> 
> Asimismo, la exigencia de que la *accountability* recaiga en agentes individuales no es un capricho formal: se ancla en la tradición jurídica y política (desde el derecho romano hasta Kelsen y Hart) que establece que las construcciones institucionales no pueden ser castigadas, encarceladas ni moralmente responsables; en última instancia, solo las personas concretas pueden responder por sus actos.

### Qué obtenemos

**Con** Lean 4 **obtenemos** teoremas verificados. Cuando un teorema compila en Lean 4, **tenemos** la certeza formal de que la conclusión se sigue de las premisas según las reglas de inferencia del sistema. Esto no garantiza que las premisas sean verdaderas (eso es una cuestión empírica o filosófica), pero garantiza que la derivación es válida.

En el contexto de este trabajo, **usamos** Lean 4 para:
- Formalizar definiciones precisas de conceptos como "reificación", "estratificación", "competencia normativa".
- Demostrar teoremas sobre las propiedades de estos conceptos.
- Verificar que ciertas construcciones (como la Aritmética Estratificada de Peano en el Capítulo 3) son consistentes.

### Limitaciones

Lean 4 tiene dos limitaciones importantes:

**Primera:** requiere que el usuario escriba la demostración paso a paso. El sistema verifica, pero no inventa. Si el usuario no sabe cómo demostrar el teorema, Lean 4 no lo ayuda (aunque existen herramientas de automatización que pueden asistir en casos simples).

**Segunda:** la formalización en Lean 4 es laboriosa. Formalizar una página de matemática estándar puede requerir cientos de líneas de código. Esto significa que no todo lo que afirmamos en este trabajo está formalizado en Lean 4; solo los resultados centrales que justifican el esfuerzo.

## 2.3 Z3: Solvers SMT y núcleos insatisfacibles

### Qué es

Z3 es un solver SMT (Satisfiability Modulo Theories) desarrollado por Microsoft Research.² A diferencia de Lean 4, que verifica demostraciones escritas por humanos, **con** Z3 **buscamos** automáticamente asignaciones de valores que satisfagan un conjunto de fórmulas lógicas, o **demostramos** que tales asignaciones no existen.

---
² de Moura, L., & Bjørner, N. (2008). "Z3: An Efficient SMT Solver". *Proceedings of the 14th International Conference on Tools and Algorithms for the Construction and Analysis of Systems (TACAS)*, Springer.
---

SMT significa "satisfacibilidad módulo teorías". El solver verifica si un conjunto de fórmulas es satisfacible (existe una asignación de valores que las hace todas verdaderas) dentro de ciertas teorías de fondo (aritmética, arrays, lógica de primer orden, etc.).

### Cómo funciona

Un archivo Z3 típico tiene esta estructura:

```smt2
; Declaración de tipos
(declare-sort Agente)
(declare-sort Norma)
(declare-sort Estrato)

; Declaración de predicados
(declare-fun Obligatorio (Agente Norma Estrato) Bool)
(declare-fun Prohibido   (Agente Norma Estrato) Bool)

; Axioma: incompatibilidad deóntica
(assert (forall ((a Agente) (n Norma) (s Estrato))
  (not (and (Obligatorio a n s) (Prohibido a n s)))))

; Consulta: ¿es satisfacible este conjunto de axiomas?
(check-sat)
```

Este código declara:
1. Tres tipos: `Agente`, `Norma`, `Estrato`.
2. Dos predicados: `Obligatorio` y `Prohibido`.
3. Un axioma: no puede ser simultáneamente obligatorio y prohibido para el mismo agente, norma y estrato.
4. Una consulta: ¿existe una asignación de valores que satisfaga este axioma?

Z3 **devuelve** `sat` (satisfacible) si existe tal asignación, o `unsat` (insatisfacible) si no existe.

### La herramienta clave: unsat cores

La funcionalidad más poderosa de Z3 para este trabajo es la generación de **núcleos insatisfacibles** (unsat cores). Cuando un conjunto de fórmulas es insatisfacible, **podemos usar** Z3 para **identificar** el subconjunto mínimo de fórmulas que genera la contradicción.

Por ejemplo, si tenemos diez axiomas y Z3 determina que el conjunto es insatisfacible, **podemos identificar** que solo tres de esos axiomas son responsables de la contradicción. Los otros siete son irrelevantes para el conflicto.

Esto es invaluable para el diagnóstico de errores. En lugar de revisar diez axiomas buscando el problema, **sabemos** exactamente cuáles tres están en conflicto.

### Ejemplo concreto: el juez incompetente

En el Capítulo 6 (sistemas normativos), **usaremos** Z3 para demostrar el principio *nemo iudex in causa sua* (nadie puede ser juez en su propia causa). El código tiene esta estructura:

```smt2
(set-option :produce-unsat-cores true)

; Axiomas del sistema
(assert (! (forall ((a Agente) (n Norma))
  (=> (exists ((s0 Estrato)) (Regula n a s0))
      (forall ((s2 Estrato)) (not (Competente a n s2)))))
  :named ax5-incompetencia-reflexiva))

(assert (! (forall ((alfa Acto) (C Contexto))
  (=> (= (Fuerza alfa) 0)
      (= (Valido alfa C)
         (and (CondFeliz alfa C)
              (exists ((s Estrato))
                (Competente (emisor alfa) (norma_aplicable alfa) s))))))
  :named ax3-validez-declarativo))

; Supuesto: un juez intenta juzgarse a sí mismo
(assert (! (= (emisor alfa1) a1) :named teo-juez-emisor))
(assert (! (= (norma_aplicable alfa1) n1) :named teo-juez-norma))
(assert (! (= (Fuerza alfa1) 0) :named teo-juez-fuerza))
(assert (! (Regula n1 a1 s1) :named teo-juez-regula))
(assert (! (CondFeliz alfa1 c1) :named teo-juez-cond))
(assert (! (Valido alfa1 c1) :named teo-juez-querido))

(check-sat)  ; Devuelve: unsat
(get-unsat-core)
```

**Con** Z3 **obtenemos** el siguiente resultado:

```
unsat
(ax3-validez-declarativo ax5-incompetencia-reflexiva
 teo-juez-emisor teo-juez-norma teo-juez-querido
 teo-juez-fuerza teo-juez-regula)
```

El núcleo insatisfacible muestra que:
- El juez emite un acto válido (`teo-juez-querido`)
- Que aplica una norma que lo regula (`teo-juez-regula`)
- Pero el axioma de incompetencia reflexiva (`ax5`) dice que si una norma regula a un agente, el agente es incompetente en todos los estratos
- Y el axioma de validez (`ax3`) exige que el emisor sea competente en algún estrato

La contradicción es inevitable. **Con** Z3 **la detectamos** y **la aislamos**.

### Ejemplo concreto: la inmunidad del crítico

En el mismo script, **formalizamos** el cálculo de reificación y movilización sacrificial (Σ_R). El teorema T1 establece que si un agente cree que una entidad es arbitraria (conoce su carácter construido), entonces no puede sacrificarse por ella:

```smt2
; Teorema T1: Si un agente cree que e es arbitrario, NO se sacrifica por e.
(push)
(declare-const agT Agente)
(declare-const eT Entidad)
(assert (! (Cree agT (EsArbitrario_prop eT)) :named t1-cree-arbitrario))
(assert (! (Sacrifica agT eT) :named t1-sacrifica))

(check-sat)  ; Devuelve: unsat
(get-unsat-core)
(pop)
```

Z3 **devuelve**:

```
unsat
(sig-A3-reificacion sig-A4-sagrado sig-A6-sacrificio-requiere-sagrado
 t1-sacrifica t1-cree-arbitrario)
```

La cadena lógica es:
1. El agente cree que la entidad es arbitraria (`t1-cree-arbitrario`).
2. Por `sig-A3`, para que la entidad esté reificada, el agente **no debe creer** que es arbitraria. Como sí lo cree, la entidad no está reificada.
3. Por `sig-A4`, lo sagrado equivale a lo reificado. Si no está reificada, no es sagrada.
4. Por `sig-A6`, el sacrificio requiere sacralidad. Si no es sagrada, no puede haber sacrificio.
5. Pero `t1-sacrifica` afirma que hay sacrificio. Contradicción. ∎

**Con** Z3 **demostramos** que la creencia en la arbitrariedad de una entidad y el acto de sacrificio por ella son lógicamente incompatibles. La "ilustración crítica" desactiva la movilización sacrificial.

### Qué obtenemos

**Con** Z3 **obtenemos** certificados de satisfacibilidad o insatisfacibilidad. Cuando Z3 **devuelve** `sat`, **sabemos** que existe un modelo que satisface las fórmulas. Cuando **devuelve** `unsat`, **sabemos** que no existe tal modelo. Y cuando **produce** un unsat core, **identificamos** el subconjunto mínimo responsable de la contradicción.

En el contexto de este trabajo, **usamos** Z3 para:
- Verificar la consistencia de conjuntos de axiomas.
- Demostrar teoremas por refutación (mostrar que la negación del teorema es insatisfacible).
- Diagnosticar contradicciones en sistemas normativos.

### Limitaciones

Z3 tiene limitaciones importantes:

**Primera:** opera en fragmentos decidibles de la lógica. Si las fórmulas caen fuera de estos fragmentos, Z3 puede no terminar o devolver "unknown" (desconocido).

**Segunda:** Z3 verifica satisfacibilidad, no verdad. Que un conjunto de axiomas sea satisfacible no significa que sea verdadero; significa que es lógicamente posible.

**Tercera:** Z3 no produce demostraciones legibles por humanos. Produce certificados que pueden ser verificados por otros sistemas, pero no explicaciones en lenguaje natural.

**Cuarta (limitación estructural):** En SMT-LIB2 (lógica de primer orden), no podemos cuantificar sobre fórmulas ni pasar una fórmula completa como argumento a un predicado como `Cree`. Para modelar creencias, creamos un tipo (o sort, en la terminología técnica de SMT-LIB) no interpretado llamado Prop y funciones que devuelven `Prop` (por ejemplo, `EsArbitrario_prop`). Z3 trata estos términos como tokens opacos: no evalúa su estructura lógica interna ni deduce consecuencias entre ellos. Esto significa que Z3 no modela la **clausura epistémica** (si un agente cree P, y P implica Q, entonces el agente cree Q). Para este trabajo, esa limitación es aceptable porque los axiomas definen las relaciones directamente sobre las creencias atómicas. Pero si en el futuro necesitamos modelar razonamiento deductivo de agentes, deberíamos axiomatizar explícitamente la lógica epistémica.

## 2.4 Clingo: Razonamiento por defecto y lógica deóntica

### Qué es

Clingo es un sistema de programación lógica con Answer Set Programming (ASP) desarrollado por la Universidad de Potsdam.³ A diferencia de Lean 4 (que verifica demostraciones) y Z3 (que verifica satisfacibilidad), **con** Clingo **generamos** modelos que satisfacen un conjunto de reglas lógicas, manejando especialmente bien el razonamiento por defecto y la negación por fallo.

---
³ Gebser, M., Kaminski, R., Kaufmann, B., & Schaub, T. (2019). "Multi-shot ASP Solving with clingo". *Theory and Practice of Logic Programming*, 19(1), 27-82.
---

### Cómo funciona

El siguiente código modela el principio *nemo iudex in causa sua* usando razonamiento por defecto:

```prolog
% Hechos
agente(juan).
agente(maria).
norma(n1).
norma(n2).
estrato(0).
estrato(1).
regula(n1, juan).

% Reglas
competente(A, N, S) :- agente(A), norma(N), estrato(S), not regulado(A, N).
regulado(A, N) :- regula(N, A).

% Restricción: nadie puede ser competente sobre una norma que lo regula
:- competente(A, N, S), regulado(A, N).

% Consulta
#show competente/3.
```

Este código declara:
1. **Hechos:** Juan y María son agentes. n1 y n2 son normas. Hay dos estratos (0 y 1). La norma n1 regula a Juan.
2. **Reglas:** Un agente es competente sobre una norma en un estrato si no está regulado por esa norma. Un agente está regulado por una norma si la norma lo regula.
3. **Restricción:** No puede ser que un agente sea competente y esté regulado por la misma norma.
4. **Consulta:** Mostrar todas las instancias del predicado `competente/3`.

### Resultado verificado

**Con** Clingo **obtenemos** el siguiente resultado:

```
SATISFIABLE
Answer: 1
competente(juan,n2,0) competente(juan,n2,1)
competente(maria,n1,0) competente(maria,n1,1)
competente(maria,n2,0) competente(maria,n2,1)
```

**Interpretación del modelo:**

| Agente | Norma | ¿Competente? | Razón |
|:---|:---|:---|:---|
| Juan | n1 | **NO** (ausente del modelo) | `regula(n1, juan)` → la condición `not regulado(juan, n1)` falla |
| Juan | n2 | SÍ | n2 no regula a Juan |
| María | n1 | SÍ | n1 no regula a María |
| María | n2 | SÍ | n2 no regula a María |

La ausencia de `competente(juan,n1,0)` y `competente(juan,n1,1)` es la demostración del principio *nemo iudex in causa sua*: **Juan no puede ser competente sobre la norma que lo regula**.

**Verificación del Grounding Profile:**
- La regla `competente` tiene **6 instancias** (2 agentes × 2 normas × 2 estratos = 8 posibles, menos 2 por Juan×n1 = 6). ✓
- La restricción `:- competente(A,N,S), regulado(A,N).` tiene **3 matches pero 0 instancias**, lo que significa que fue verificada pero nunca violada. ✓
- `regulado` tiene **1 instancia** (solo `regulado(juan,n1)`). ✓

### La herramienta clave: negación por fallo

La funcionalidad distintiva de Clingo es la **negación por fallo** (negation as failure). La expresión `not P` se evalúa como verdadera si no hay evidencia de que `P` sea verdadero. Esto **nos permite** modelar razonamiento por defecto: "asumir P a menos que haya evidencia de lo contrario".

En el contexto de sistemas normativos, esto es crucial. Muchas normas operan por defecto: "los ciudadanos pueden circular libremente a menos que exista una restricción explícita". **Con** Clingo **manejamos** este tipo de razonamiento de manera natural.

### Qué obtenemos

**Con** Clingo **obtenemos** conjuntos de respuestas: modelos que satisfacen el programa lógico. Cada conjunto de respuestas representa una interpretación consistente del programa.

En el contexto de este trabajo, **usamos** Clingo para:
- Modelar sistemas normativos con excepciones y razonamiento por defecto.
- Verificar la consistencia de conjuntos de normas.
- Generar escenarios que satisfacen ciertas condiciones.

### Limitaciones

Clingo tiene limitaciones:

**Primera:** la semántica de ASP es diferente de la lógica clásica. Los conjuntos de respuestas no son modelos en el sentido de la teoría de modelos estándar.

**Segunda:** Clingo puede generar múltiples conjuntos de respuestas, y el usuario debe interpretar cuál es relevante para su análisis.

**Tercera:** ASP no maneja bien la cuantificación sobre fórmulas o la lógica de orden superior.

## 2.5 Matriz problema-herramienta

El Capítulo 0 estableció una matriz que asocia tipos de problemas con herramientas específicas. La reproducimos aquí con explicaciones:

| Tipo de problema | Herramienta | Justificación |
|:---|:---|:---|
| Consistencia lógica, teoremas con inducción | Lean 4 | Kernel pequeño, prueba verificable, lógica de primer orden con igualdad |
| Satisfactibilidad de conjuntos de axiomas en fragmentos decidibles | Z3 / SMT-LIB | Automático, produce modelos o unsat core |
| Normas con excepciones, razonamiento por defecto | Clingo / Deolingo | Answer Set Programming maneja negación por fallo y reglas defeasibles |
| Verificación de tipos, estructura de datos | Lean 4 | Teoría de tipos dependientes, chequeo en compilación |

La elección de herramienta se justifica en cada capítulo. No utilizamos una herramienta por inercia, sino porque es la adecuada para el problema concreto.

## 2.6 Cómo leer el código en este trabajo

Los capítulos siguientes (especialmente el 3, 5 y 6) incluyen fragmentos de código en Lean 4, Z3 y Clingo. El lector puede abordarlos a dos niveles:

**Nivel conceptual:** Ignorar el código y leer solo la prosa que lo explica. La prosa describe qué **hacemos con** el código, qué teorema **demostramos**, y qué implicaciones **tiene** para el argumento. Este nivel es suficiente para entender el argumento general.

**Nivel técnico:** Leer el código y verificar que efectivamente **hace** lo que la prosa afirma. Este nivel requiere familiaridad con los lenguajes, pero el código está disponible para quien quiera inspeccionarlo.

Para facilitar la lectura conceptual, cada fragmento de código va acompañado de:
1. **Descripción en prosa** de qué **hacemos con** el código.
2. **Explicación línea por línea** de las partes clave.
3. **Interpretación** de qué significa el resultado para el argumento.

El código no es decorativo. Cada fragmento que incluimos compila y produce el resultado que afirmamos. Ningún fragmento se incluye sin que haya sido verificado por nosotros.

### 2.7 El estatus filosófico de los axiomas: elecciones, no descubrimientos

Toda formalización matemática o lógica comienza con un acto fundacional que las herramientas computacionales no pueden auditar: la elección de los **axiomas**. Para comprender el alcance y los límites de lo que hacemos en este trabajo con Lean 4, Z3 y Clingo, es imperativo desarmar la anatomía de una demostración formal y ser radicalmente transparentes sobre el estatus filosófico de sus cimientos.

#### La anatomía de una demostración formal
En cualquier sistema formal, el conocimiento se estructura en una cadena de dependencias lógicas:
1. **Axiomas:** Son las premisas fundacionales, las reglas del juego que nosotros, los autores, decidimos adoptar sin demostrar dentro del sistema.
2. **Lemas:** Son teoremas auxiliares, pasos intermedios que demostramos para facilitar la prueba de resultados mayores.
3. **Teoremas:** Son las proposiciones sustantivas que nos interesa demostrar, derivadas lógicamente de los axiomas y lemas.
4. **Corolarios:** Son consecuencias inmediatas y directas de los teoremas.

Las herramientas formales que presentamos en este capítulo (los *kernels* de Lean, los motores de Z3) son auditoras infalibles de los eslabones de esta cadena. Si nosotros afirmamos que un teorema se sigue de un lema, y el lema se sigue de un axioma, el software verifica que la deducción sea estructuralmente impecable. **Pero las herramientas son ciegas a los axiomas.** Ningún compilador puede verificar si un axioma es "verdadero" en el mundo empírico o "justo" en el mundo social; solo puede verificar que, *si* el axioma se asume como verdadero, las consecuencias se siguen necesariamente.

#### El riesgo de reificar los axiomas
Aquí es donde el método de este libro enfrenta su prueba de fuego más delicada. Si nosotros presentamos nuestros axiomas como "descubrimientos empíricos" o como "leyes naturales del comportamiento social", estaríamos cometiendo exactamente el mismo error de reificación que denunciamos en el Capítulo 1: estaríamos tratando una construcción discursiva (nuestra elección de premisas) como si fuera una sustancia con existencia autónoma.

La formalización no elimina la interpretación filosófica; la desplaza al nivel de los axiomas. Por lo tanto, para evitar la falacia de la herramienta (creer que lo formalizado es objetivamente verdadero), nosotros debemos declarar explícitamente que **nuestros axiomas no son descubrimientos, sino elecciones filosóficas**. Son compromisos que adoptamos porque resultan fecundos para el proyecto de análisis que estamos realizando, y porque se anclan en tradiciones de pensamiento específicas. 

#### El anclaje filosófico de nuestras elecciones
Para que el lector pueda evaluar críticamente nuestro trabajo, debemos transparentar el anclaje filosófico de los axiomas que utilizaremos en los capítulos subsiguientes. A modo de ejemplo:

*   **Sobre la agencia y la *accountability* (Capítulo 2 / Lean 4):** Nosotros definimos un tipo `AgencySource` con exactamente dos constructores: `individual` (personas físicas) e `institutional` (construcciones). ¿Por qué esta elección y no otra? Esta decisión no es una verdad universal; se ancla en la **tradición jurídica occidental** (desde el derecho romano hasta Kelsen y Hart), que establece que las construcciones institucionales pueden ser sancionadas o disueltas, pero solo las personas de carne y hueso pueden ser penalmente responsables o moralmente *accountable*. Si el lector prefiriera una ontología que incluya "agencia colectiva difusa" o "agencia ecológica", nuestros teoremas sobre la dilución de responsabilidad cambiarían.
*   **Sobre la jerarquía normativa (Capítulo 6 / Z3):** Nosotros axiomatizamos que si una norma regula a un agente, ese agente es incompetente para evaluar esa misma norma (el principio *nemo iudex in causa sua*). Esta elección se ancla en la **Teoría Pura del Derecho de Kelsen** y en la lógica deóntica, que exigen una estratificación jerárquica para evitar las paradojas de la autoevaluación. 
*   **Sobre la reificación y el sacrificio (Capítulo 6 / Z3):** Nosotros axiomatizamos que un agente no puede sacrificarse por una entidad si es plenamente consciente de su arbitrariedad constitutiva. Esta elección se ancla en la **sociología crítica de Pierre Bourdieu** y en la teoría de la violencia simbólica, que postulan que la dominación requiere el desconocimiento (la *misperception*) de su propia contingencia por parte del dominado.

#### La naturaleza condicional de los teoremas
Como consecuencia directa de lo anterior, todos los teoremas que demostramos en este trabajo son **estrictamente condicionales**. 

Cuando nosotros demostramos que "la reificación institucional destruye la *accountability*" o que "la creencia en la arbitrariedad bloquea el sacrificio", no estamos dictando leyes inmutables de la sociología. Estamos afirmando lo siguiente: *"Bajo los axiomas que nosotros hemos elegido, anclados en las tradiciones jurídica y sociológica mencionadas, estas propiedades se siguen necesariamente"*. 

El lector tiene absoluta libertad para cuestionar nuestros axiomas, rechazarlos y proponer otros. Si lo hace, las herramientas formales seguirán a su disposición para que verifique las nuevas consecuencias lógicas de sus propias premisas. Esta invitación a la refutación no es una debilidad de nuestro método; es su mayor fortaleza. Es la garantía de que estamos utilizando la formalización como una herramienta de higiene conceptual transparente, y no como un manto de autoridad matemática para ocultar decisiones ideológicas o filosóficas bajo la alfombra de la sintaxis.

## 2.8 Limitaciones y honestidad metodológica

Las herramientas formales son poderosas, pero no son mágicas. Tienen limitaciones que es importante reconocer:

**Primera limitación: las herramientas verifican derivaciones, no verdad.** Que un teorema compile en Lean 4 garantiza que la conclusión se sigue de las premisas, pero no garantiza que las premisas sean verdaderas. La verdad de las premisas es una cuestión empírica o filosófica que las herramientas no pueden resolver.

**Segunda limitación: la formalización requiere elecciones.** Formalizar un concepto en lenguaje natural requiere decidir cómo representarlo en el lenguaje formal. Estas decisiones no son neutrales; pueden introducir sesgos o perder matices. Por ejemplo, formalizar "la patria exige sacrificio" como `Exige(Patria, Sacrificio)` pierde la ambigüedad del lenguaje natural, pero esa pérdida es el precio de la precisión.

**Tercera limitación: no todo es formalizable.** Hay aspectos del análisis de la reificación que no pueden formalizarse completamente. La interpretación de los efectos de poder, la evaluación de la relevancia histórica, la crítica ideológica: estos son juicios que operan en lenguaje natural y no pueden reducirse a código. Las herramientas formales complementan el análisis, no lo reemplazan.

**Cuarta limitación: las herramientas tienen bugs.** Aunque el kernel de Lean 4 es extremadamente pequeño y ha sido revisado exhaustivamente, el sistema completo (bibliotecas, tácticas, interfaz) tiene bugs. Z3 y Clingo también tienen bugs conocidos. Confiar ciegamente en las herramientas sería ingenuo. Por eso verificamos los resultados con múltiples métodos cuando es posible.

**Quinta limitación: la formalización no elimina la reificación, la desplaza.** Las herramientas formales también tienen sintaxis, y sus tipos y términos pueden cosificarse conceptualmente. La diferencia es que en un sistema formal la reificación está controlada por las reglas de inferencia, pero el significado último de los símbolos sigue dependiendo de la interpretación humana. Lo formal no escapa completamente de la reificación; la hace explícita y controlable.

**Advertencia metodológica:** Incluso al hablar de herramientas formales, el lenguaje natural nos obliga a usar formulaciones que atribuyen agencia a las herramientas ("Lean verifica", "el kernel acepta", "Z3 demuestra"). Esto es inevitable. Lo importante es recordar que estas formulaciones son abreviaturas de operaciones más complejas donde los agentes reales somos nosotros: nosotros escribimos el código, nosotros interpretamos los resultados, nosotros decidimos qué formalizar.

### El estatus epistémico de los resultados formales

Siguiendo el sistema de etiquetado establecido en el Capítulo 0, los resultados formales se clasifican como **[A] Probada por código**. Esto significa que el resultado ha sido verificado por una herramienta formal y compila sin errores.

Pero es crucial entender qué significa esto. Un resultado [A] no es "más verdadero" que un resultado [B] (citado de literatura) o [C] (interpretación). Significa que tiene un tipo diferente de respaldo: un respaldo computacional en lugar de empírico o hermenéutico.

Un teorema verificado en Lean 4 garantiza que, bajo ciertos axiomas y reglas de inferencia, la conclusión se sigue necesariamente. Pero los axiomas mismos son elecciones que requieren justificación filosófica. La herramienta verifica la derivación; nosotros justificamos las premisas.

## 2.9 Cierre: las herramientas como prótesis cognitiva

Las herramientas formales son, en última instancia, **prótesis cognitivas**. Así como **con** un telescopio **extendemos** nuestra capacidad para ver objetos lejanos, **con** las herramientas formales **extendemos** nuestra capacidad para detectar inconsistencias, verificar derivaciones y diagnosticar errores.

Pero una prótesis no reemplaza al órgano; lo complementa. **Con** el telescopio **no vemos** por sí mismo; **requerimos** interpretar lo que **observamos**. Del mismo modo, **con** las herramientas formales **no razonamos** por sí mismas; **requerimos** formular las preguntas, interpretar los resultados y integrarlos en un argumento más amplio.

**Nosotros usamos** herramientas formales porque el análisis de la reificación requiere precisión que el lenguaje natural no puede proporcionar por sí solo. Pero las herramientas no son este trabajo. Este trabajo es el argumento conceptual que **construimos con ayuda de** las herramientas. El lector que ignore el código perderá detalles técnicos, pero no perderá el argumento central. El lector que estudie el código ganará certeza sobre los resultados formales, pero seguirá necesitando interpretar su significado.

Las herramientas formales son el microscopio. Lo que **observamos** a través de él es lo que **mostramos** en este trabajo.


### Resumen de códigos verificados en este capítulo

| Herramienta | Código | Resultado | Verificado |
|:---|:---|:---|:---|
| Lean 4 | `reification_is_category_mistake` | Compila sin errores | ✓ |
| Lean 4 | `reification_excludes_individual_agency` | Compila sin errores | ✓ |
| Lean 4 | `reification_destroys_accountability` | Compila sin errores | ✓ |
| Z3 | SFCD (consistencia) | `sat` | ✓ |
| Z3 | Juez incompetente | `unsat` + unsat core | ✓ |
| Z3 | Σ_R (consistencia) | `sat` | ✓ |
| Z3 | T1 (inmunidad del crítico) | `unsat` + unsat core | ✓ |
| Clingo | Nemo iudex (competencia normativa) | `SATISFIABLE`, 6 instancias | ✓ |


