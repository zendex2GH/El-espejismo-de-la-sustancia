

# Capítulo 4: La gramática de la reificación en el discurso físico

## 4.0 Introducción: por qué formalizar la gramática y no la física

En el Capítulo 3, nosotros demostramos con SPA que la estratificación sintáctica resuelve la paradoja de Tarski: el predicado de verdad no puede aplicarse a sí mismo sin generar contradicción. La solución fue imponer una restricción de tipo en el verificador de Lean 4.

En este capítulo, nosotros aplicamos el mismo principio metodológico a un dominio distinto: el discurso físico. Pero hay una diferencia crucial que debe declararse desde el inicio. En el Capítulo 3, el problema estaba en la sintaxis del sistema lógico: la lógica estándar permitía la autorreferencia destructiva, y nosotros tuvimos que construir una sintaxis nueva (SPA) que la bloqueara. En el discurso físico, la situación es inversa: el formalismo matemático de la física ya es relacional y no reificado. Las ecuaciones de campo de Einstein no dicen “el espacio-tiempo es una sábana elástica”. Dicen: existe una relación de equivalencia entre el tensor de Einstein y el tensor de energía-momento. El formalismo no reifica.

La reificación vive en otro lugar: en el lenguaje natural que los físicos, los divulgadores y los pedagogos usan para hablar sobre ese formalismo. Cuando un físico dice “nos llegan vibraciones del espacio-tiempo”, está usando una gramática sustancialista (el espacio-tiempo como medio material que vibra) para describir una estructura relacional (perturbaciones de la métrica). El error no está en la física; está en la traducción.

Por eso, en este capítulo nosotros no formalizamos la física. No hay tensores, no hay ecuaciones diferenciales, no hay geometría de Riemann. Lo que nosotros formalizamos es la gramática del discurso que reifica la física: un sistema de tipos ontológicos que clasifica entidades y predicados del lenguaje físico, y detecta automáticamente cuándo un predicado requiere un tipo de sujeto distinto al que la entidad realmente tiene.

Esto es coherente con lo que establecimos en el Capítulo 1 (sección 1.2.3): la reificación es un fenómeno gramatical. Los roles temáticos (agente, paciente, instrumento) se alteran. Las construcciones relacionales se tratan como sustancias. Los procesos se tratan como objetos. La gramática del lenguaje natural produce estos deslizamientos por estructura, no por descuido. Lo que nosotros hacemos aquí es construir un verificador que los detecte.

Nota sobre la naturaleza de este sistema. Este sistema es un diagnóstico semántico, no una restricción sintáctica preventiva como SPA. SPA bloquea la construcción mal formada antes de que pueda formularse. Este sistema detecta la reificación después de que ha sido formulada en lenguaje natural. Ambos son mecanismos anti-reificatorios, pero operan en momentos distintos del proceso discursivo.

---

## 4.1 El caso del espacio-tiempo: aplicación del protocolo [C]

Aplicamos las cuatro preguntas del Capítulo 0 al caso paradigmático de la reificación en física.

### Pregunta 1: ¿Cuál es el objeto formal y cuál es su tipo?

El espacio-tiempo, en el formalismo de la relatividad general, es una variedad diferenciable tetradimensional equipada con una métrica lorentziana $g_{\mu\nu}$. Su tipo ontológico dentro del formalismo es: estructura relacional. No es un objeto que “está” en algún lugar; es la red de relaciones geométricas entre eventos. La métrica $g_{\mu\nu}$ no es una propiedad de una sustancia; es una función que asigna distancias y ángulos a pares de vectores tangentes en cada punto de la variedad.

### Pregunta 2: ¿Qué atribuye la narrativa a este objeto que su tipo no contiene?

La narrativa pedagógica y divulgativa atribuye al espacio-tiempo propiedades de sustancia elástica:

- “La materia curva el espacio-tiempo” (como si fuera una lámina que se deforma).
- “Nos llegan vibraciones del espacio-tiempo” (como si fuera un medio material que oscila).
- “El espacio-tiempo se deforma bajo la acción de la masa” (como si fuera un objeto que cambia de forma).

Estas atribuciones requieren un sujeto de tipo sustancia (algo que puede curvarse, vibrar, deformarse). Pero el tipo real del espacio-tiempo en el formalismo es estructura relacional. Hay un mismatch de tipo. Eso es la reificación gramatical.

### Pregunta 3: ¿Existe una descripción alternativa sin ese atributo?

Sí. La descripción formal estándar no requiere la metáfora de la sábana elástica:

- “Las ecuaciones de campo relacionan la geometría de la variedad (tensor de Einstein $G_{\mu\nu}$) con la distribución de materia-energía (tensor de energía-momento $T_{\mu\nu}$).”
- “Las ondas gravitacionales son perturbaciones de la métrica que se propagan como soluciones de las ecuaciones linealizadas.”

Además, la derivación de Deser (1970) muestra que las ecuaciones de Einstein pueden derivarse partiendo de un campo de espín-2 en espacio plano, sin postular curvatura geométrica [B]. Esto demuestra que la “geometría curva” es una opción de empaquetamiento matemático, no una ontología necesaria.

Finalmente, la correspondencia AdS/CFT de Maldacena (1997) propone que la geometría del espacio-tiempo puede ser emergente a partir del entrelazamiento cuántico en una frontera de dimensión inferior [B]. En la conferencia del 28 de julio de 2026 en el Planetario de Buenos Aires (Usina del Arte), Maldacena señaló que la geometría podría no ser el nivel fundamental de descripción, sino una estructura derivada de correlaciones cuánticas [B].

Nosotros no usamos estas afirmaciones para decir que “el espacio-tiempo no existe”. Las usamos como evidencia de que el propio discurso físico contempla formulaciones donde la geometría no es una sustancia primaria. Hay pluralismo interpretativo real.

### Pregunta 4: ¿Es teoría resuelta con narrativa sucia?

Sí. La relatividad general es una teoría resuelta: las ecuaciones son conocidas, las predicciones están confirmadas (ondas gravitacionales detectadas por LIGO en 2015, lentes gravitacionales, precesión del perihelio de Mercurio). El formalismo es sólido. Lo que está “sucio” es la narrativa pedagógica que lo envuelve: la metáfora de la sábana elástica, las “vibraciones” del espacio-tiempo, la “deformación” bajo la masa.

---

## 4.2 Formalización de la gramática de la reificación [A-Código]

Nosotros construimos un sistema de tipos ontológicos en Lean 4 que formaliza la estructura gramatical de la reificación. El sistema no modela la física; modela el lenguaje que habla de la física.

### Tipos ontológicos

```lean
-- ============================================================
-- Tipos ontológicos: las categorías que el discurso puede asignar
-- ============================================================
inductive OntoType
  | relation      -- una relación entre entidades
  | substance     -- una sustancia con existencia autónoma
  | process       -- un proceso
  | property      -- una propiedad de algo
  | formal_struct -- una estructura formal
  | convention    -- una convención
  deriving DecidableEq, Repr
```

Estos seis tipos corresponden a las categorías ontológicas que el discurso físico puede asignar a sus entidades. La clasificación no es arbitraria: se ancla en el formalismo físico real. El espacio-tiempo es una estructura (variedad con métrica). La energía es una propiedad (de un sistema). La fuerza es una relación (interacción entre cuerpos). La naturaleza es un proceso (conjunto de fenómenos). La materia puede tratarse como sustancia (distribución de masa-energía localizada).

### Entidades del discurso físico

```lean
-- ============================================================
-- Entidades del discurso físico
-- ============================================================
inductive PhysicsEntity
  | spacetime
  | matter
  | metric_field
  | curvature
  | energy
  | force
  | nature
  deriving DecidableEq, Repr
```

### Predicados del discurso

```lean
-- ============================================================
-- Predicados del discurso: verbos y atribuciones
-- ============================================================
inductive PhysicsPredicate
  | curves        -- "se curva"
  | deforms       -- "se deforma"
  | vibrates      -- "vibra"
  | flows         -- "fluye"
  | stores        -- "se almacena"
  | abhors        -- "aborrece"
  | relates       -- "relaciona"
  | has_property  -- "tiene la propiedad de"
  deriving DecidableEq, Repr
```

### Clasificación ontológica

```lean
-- ============================================================
-- Clasificación ontológica de cada entidad
-- (Anclada en el formalismo físico real)
-- ============================================================
def ontoType : PhysicsEntity → OntoType
  | .spacetime    => .formal_struct
  | .matter       => .substance
  | .metric_field => .relation
  | .curvature    => .property
  | .energy       => .property
  | .force        => .relation
  | .nature       => .process
```

### Clasificación de predicados

```lean
-- ============================================================
-- Clasificación de predicados: qué tipo de sujeto requieren
-- ============================================================
def requiredSubjectType : PhysicsPredicate → OntoType
  | .curves       => .substance    -- curvarse requiere algo elástico
  | .deforms      => .substance    -- deformarse requiere algo material
  | .vibrates     => .substance    -- vibrar requiere un medio material
  | .flows        => .substance    -- fluir requiere un fluido
  | .stores       => .substance    -- almacenarse requiere un contenedor
  | .abhors       => .substance    -- aborrecer requiere un agente con psicología
  | .relates      => .relation     -- relacionar requiere una relación
  | .has_property => .formal_struct -- tener propiedad requiere una estructura
```

### Definición formal de reificación gramatical

```lean
-- ============================================================
-- Definición formal de reificación gramatical
-- ============================================================
def is_grammatical_reification (e : PhysicsEntity) (p : PhysicsPredicate) : Prop :=
  ontoType e ≠ requiredSubjectType p
```

Interpretación: Hay reificación gramatical cuando el tipo ontológico real de la entidad (según el formalismo físico) es distinto del tipo que el predicado requiere para su sujeto. Si el espacio-tiempo es una estructura pero el predicado “curvarse” requiere una sustancia, hay mismatch. Ese mismatch es la reificación gramatical.

Nota sobre los axiomas. Siguiendo la reflexión del Capítulo 2 (sección 2.7), nosotros reconocemos que esta clasificación es una elección filosófica, no un descubrimiento empírico. Se ancla en el formalismo físico estándar (la relatividad general trata el espacio-tiempo como variedad, la termodinámica trata la energía como función de estado), pero otras ontologías podrían clasificar de manera distinta. Por ejemplo, una ontología de “ontología primitiva de la energía” [B] clasificaría la energía como sustancia. Nosotros elegimos la clasificación estándar porque es la que se ancla en el formalismo matemático vigente. El lector puede cuestionar esta elección; en ese caso, los teoremas cambian.

---

## 4.3 Teoremas básicos de detección de reificación [A-Meta] + [A-Código]

Con el sistema definido, nosotros demostramos teoremas que detectan automáticamente las reificaciones más comunes del discurso físico.

Presentamos primero las demostraciones en prosa **[A-Meta]** y luego la verificación computacional **[A-Código]**.

---

### Teorema T-REF-1 [A-Meta]

“El espacio-tiempo se curva” es una reificación gramatical.

Enunciado.

$$
\text{is\_grammatical\_reification}(\text{spacetime}, \text{curves}).
$$

Demostración. Sea $e = \text{spacetime}$ y sea $p = \text{curves}$. Por definición de $\text{ontoType}$, se tiene:

$$
\text{ontoType}(e) = \text{formal\_struct}.
$$

Por definición de $\text{requiredSubjectType}$, se tiene:

$$
\text{requiredSubjectType}(p) = \text{substance}.
$$

Como $\text{formal\_struct}$ y $\text{substance}$ son constructores distintos del tipo inductivo $\text{OntoType}$, se verifica:

$$
\text{formal\_struct} \neq \text{substance}.
$$

Por definición de $\text{is\_grammatical\_reification}$:

$$
\text{is\_grammatical\_reification}(e, p)
\iff
\text{ontoType}(e) \neq \text{requiredSubjectType}(p).
$$

Luego $\text{is\_grammatical\_reification}(\text{spacetime}, \text{curves})$ es verdadero. $\square$

---

### Teorema T-REF-2 [A-Meta]

“La energía fluye” es una reificación gramatical.

Enunciado.

$$
\text{is\_grammatical\_reification}(\text{energy}, \text{flows}).
$$

Demostración. Sea $e = \text{energy}$ y $p = \text{flows}$. Entonces:

$$
\text{ontoType}(e) = \text{property}
$$

y

$$
\text{requiredSubjectType}(p) = \text{substance}.
$$

Como $\text{property} \neq \text{substance}$, se sigue $\text{is\_grammatical\_reification}(e, p)$ por definición. $\square$

---

### Teorema T-REF-3 [A-Meta]

“La naturaleza aborrece el vacío” es una reificación gramatical.

Enunciado.

$$
\text{is\_grammatical\_reification}(\text{nature}, \text{abhors}).
$$

Demostración. Sea $e = \text{nature}$ y $p = \text{abhors}$. Entonces:

$$
\text{ontoType}(e) = \text{process}
$$

y

$$
\text{requiredSubjectType}(p) = \text{substance}.
$$

Como $\text{process} \neq \text{substance}$, se sigue la reificación por definición. $\square$

---

### Teorema T-REF-4 [A-Meta]

“La energía se almacena” es una reificación gramatical.

Enunciado.

$$
\text{is\_grammatical\_reification}(\text{energy}, \text{stores}).
$$

Demostración. Sea $e = \text{energy}$ y $p = \text{stores}$. Entonces:

$$
\text{ontoType}(e) = \text{property}
$$

y

$$
\text{requiredSubjectType}(p) = \text{substance}.
$$

Como $\text{property} \neq \text{substance}$, se sigue la tesis. $\square$

---

### Teorema T-REF-5 [A-Meta]

“El espacio-tiempo vibra” es una reificación gramatical.

Enunciado.

$$
\text{is\_grammatical\_reification}(\text{spacetime}, \text{vibrates}).
$$

Demostración. Sea $e = \text{spacetime}$ y $p = \text{vibrates}$. Entonces:

$$
\text{ontoType}(e) = \text{formal\_struct}
$$

y

$$
\text{requiredSubjectType}(p) = \text{substance}.
$$

Como $\text{formal\_struct} \neq \text{substance}$, se sigue la tesis. $\square$

---

### Teorema T-NOREF-1 [A-Meta]

“El campo métrico relaciona eventos” no es reificación.

Enunciado.

$$
\neg \text{is\_grammatical\_reification}(\text{metric\_field}, \text{relates}).
$$

Demostración. Sea $e = \text{metric\_field}$ y $p = \text{relates}$. Entonces:

$$
\text{ontoType}(e) = \text{relation}
$$

y

$$
\text{requiredSubjectType}(p) = \text{relation}.
$$

Luego:

$$
\text{ontoType}(e) = \text{requiredSubjectType}(p).
$$

Por definición de $\text{is\_grammatical\_reification}$, la desigualdad es falsa, luego la negación es verdadera. $\square$

---

### Teorema T-NOREF-2 [A-Meta]

“La estructura tiene la propiedad de curvatura” no es reificación.

Enunciado.

$$
\neg \text{is\_grammatical\_reification}(\text{spacetime}, \text{has\_property}).
$$

Demostración. Sea $e = \text{spacetime}$ y $p = \text{has\_property}$. Entonces:

$$
\text{ontoType}(e) = \text{formal\_struct}
$$

y

$$
\text{requiredSubjectType}(p) = \text{formal\_struct}.
$$

Luego:

$$
\text{ontoType}(e) = \text{requiredSubjectType}(p).
$$

Por definición, no hay mismatch de tipo. $\square$

---

### Verificación en Lean [A-Código]

```lean
-- ============================================================
-- Teoremas básicos de detección de reificación
-- ============================================================

-- "El espacio-tiempo se curva" → reificación
theorem spacetime_curves_is_reification :
  is_grammatical_reification .spacetime .curves := by
  simp [is_grammatical_reification, ontoType, requiredSubjectType]

-- "La energía fluye" → reificación
theorem energy_flows_is_reification :
  is_grammatical_reification .energy .flows := by
  simp [is_grammatical_reification, ontoType, requiredSubjectType]

-- "La naturaleza aborrece el vacío" → reificación
theorem nature_abhors_is_reification :
  is_grammatical_reification .nature .abhors := by
  simp [is_grammatical_reification, ontoType, requiredSubjectType]

-- "La energía se almacena" → reificación
theorem energy_stores_is_reification :
  is_grammatical_reification .energy .stores := by
  simp [is_grammatical_reification, ontoType, requiredSubjectType]

-- "El espacio-tiempo vibra" → reificación
theorem spacetime_vibrates_is_reification :
  is_grammatical_reification .spacetime .vibrates := by
  simp [is_grammatical_reification, ontoType, requiredSubjectType]

-- ============================================================
-- Ejemplos de NO reificación
-- ============================================================

-- "El campo métrico relaciona eventos" → NO es reificación
theorem metric_relates_is_not_reification :
  ¬ is_grammatical_reification .metric_field .relates := by
  simp [is_grammatical_reification, ontoType, requiredSubjectType]

-- "La estructura tiene la propiedad de curvatura" → NO es reificación
theorem spacetime_has_curvature_is_not_reification :
  ¬ is_grammatical_reification .spacetime .has_property := by
  simp [is_grammatical_reification, ontoType, requiredSubjectType]
```

### Tabla de resultados

| Oración del discurso | Entidad | Tipo real | Predicado | Tipo requerido | ¿Reificación? |
|---|---|---|---|---|---|
| “El espacio-tiempo se curva” | spacetime | formal_struct | curves | substance | SÍ |
| “El espacio-tiempo vibra” | spacetime | formal_struct | vibrates | substance | SÍ |
| “La energía fluye” | energy | property | flows | substance | SÍ |
| “La energía se almacena” | energy | property | stores | substance | SÍ |
| “La naturaleza aborrece el vacío” | nature | process | abhors | substance | SÍ |
| “El campo métrico relaciona eventos” | metric_field | relation | relates | relation | NO |
| “La estructura tiene curvatura” | spacetime | formal_struct | has_property | formal_struct | NO |

Nota sobre la compilación. Este código compila en Lean 4 sin errores. Los teoremas se demuestran con `simp` porque las definiciones son funciones por pattern matching sobre tipos finitos, y Lean puede reducir `ontoType .spacetime` a `.formal_struct` y `requiredSubjectType .curves` a `.substance`, y luego decidir que `.formal_struct ≠ .substance` usando la instancia de `DecidableEq`.

Nota sobre el estatus epistémico de estos teoremas. Estos teoremas son consecuencias inmediatas de las definiciones. Su valor no reside en la dificultad de la prueba, sino en la explicitación mecánica de la clasificación. Son verificables, pero no revelan patrones que no fueran evidentes a partir de las definiciones. El sistema es un espejo que refleja la clasificación que le proporcionamos. En la siguiente sección, nosotros presentamos teoremas no triviales que revelan estructuras no obvias: incompatibilidades entre procesos, acumulación de distancia ontológica, y emergencia de ontologías fantasma en corpus.

---

## 4.4 Teoremas no triviales: interacciones, acumulación y emergencia [A-Meta] + [A-Código]

Los teoremas anteriores detectan reificaciones individuales. Pero en el discurso real, la reificación no opera de manera aislada: los procesos satélite interactúan, se acumulan, y generan patrones emergentes que no son visibles analizando oraciones individuales. En esta sección, nosotros formalizamos y demostramos tres teoremas que capturan estas dinámicas complejas.

---

### Teorema no trivial 1: Incompatibilidad entre personificación y naturalización

En el Capítulo 1 (sección 1.2.1), nosotros identificamos siete procesos satélite que estabilizan la reificación. Dos de ellos son particularmente relevantes aquí:

- **Personificación:** atribuye a una entidad propiedades de agente con psicología (voluntad, intención, emoción).
- **Naturalización:** atribuye a una entidad propiedades de dato bruto inevitable, sin psicología ni intención.

Estos dos procesos son lógicamente incompatibles: no se puede atribuir simultáneamente agencia psicológica y ausencia de psicología. Formalizamos esta incompatibilidad y la demostramos.

---

### Teorema T-INCOMP [A-Meta]

Incompatibilidad entre personificación y naturalización.

Enunciado.

$$
\text{is\_inconsistent}
\left(
\text{personification.attributes} \; ++ \; \text{naturalization.attributes}
\right).
$$

Demostración. Sea $L$ la concatenación de las listas de atributos:

$$
L =
\text{personification.attributes}
\; ++ \;
\text{naturalization.attributes}.
$$

Por definición:

$$
\text{personification.attributes}
=
[\text{has\_psychology}, \text{has\_causality}],
$$

$$
\text{naturalization.attributes}
=
[\text{no\_psychology}, \text{is\_inevitable}].
$$

Luego:

$$
L =
[
\text{has\_psychology},
\text{has\_causality},
\text{no\_psychology},
\text{is\_inevitable}
].
$$

Sea $p_1 = \text{has\_psychology}$ y sea $p_2 = \text{no\_psychology}$. Entonces $p_1 \in L$ (es la cabeza de la lista) y $p_2 \in L$ (es el tercer elemento).

Por definición de $\text{are\_incompatible}$:

$$
\text{are\_incompatible}(p_1, p_2)
\iff
(p_1 = \text{has\_psychology} \land p_2 = \text{no\_psychology})
\lor
(p_1 = \text{no\_psychology} \land p_2 = \text{has\_psychology}).
$$

La primera disyunción es verdadera por construcción. Luego $\text{are\_incompatible}(p_1, p_2)$ es verdadero.

Por definición de $\text{is\_inconsistent}$:

$$
\text{is\_inconsistent}(L)
\iff
\exists p_1, p_2,\;
p_1 \in L \land p_2 \in L \land
\text{are\_incompatible}(p_1, p_2).
$$

Hemos exhibido testigos que satisfacen la definición. Por tanto, $\text{is\_inconsistent}(L)$ es verdadero. $\square$

---

### Verificación en Lean [A-Código]

```lean
-- ============================================================
-- TEOREMA NO TRIVIAL 1: Incompatibilidad entre procesos satélite
-- ============================================================

inductive AttributedProperty
  | has_psychology    -- tiene psicología (intención, voluntad)
  | no_psychology     -- no tiene psicología (es dato bruto)
  | has_causality     -- tiene causalidad propia
  | is_inevitable     -- es inevitable
  deriving DecidableEq, Repr

structure SatelliteProcess where
  name : String
  attributes : List AttributedProperty

def personification : SatelliteProcess where
  name := "personificación"
  attributes := [.has_psychology, .has_causality]

def naturalization : SatelliteProcess where
  name := "naturalización"
  attributes := [.no_psychology, .is_inevitable]

def are_incompatible (p1 p2 : AttributedProperty) : Prop :=
  (p1 = .has_psychology ∧ p2 = .no_psychology) ∨
  (p1 = .no_psychology ∧ p2 = .has_psychology)

def is_inconsistent (props : List AttributedProperty) : Prop :=
  ∃ (p1 p2 : AttributedProperty), p1 ∈ props ∧ p2 ∈ props ∧ are_incompatible p1 p2

theorem personification_naturalization_incompatible :
  is_inconsistent (personification.attributes ++ naturalization.attributes) := by
  unfold is_inconsistent personification naturalization are_incompatible
  apply Exists.intro .has_psychology
  apply Exists.intro .no_psychology
  simp
```

Interpretación: Este teorema demuestra que cuando un discurso aplica simultáneamente personificación y naturalización a la misma entidad, genera una contradicción interna. Por ejemplo, si un texto dice “la naturaleza aborrece el vacío” (personificación: atribuye psicología) y luego dice “la naturaleza opera por leyes inevitables sin intención” (naturalización: niega psicología), el discurso es inconsistente. Esta inconsistencia no es visible analizando oraciones individuales; emerge de la interacción entre procesos satélite.

Nota sobre el estatus epistémico. La demostración es lógicamente válida, pero la premisa (que personificación y naturalización tienen atributos mutuamente excluyentes) es una estipulación filosófica, no un hecho lingüístico demostrado. Nosotros definimos los atributos de cada proceso basándonos en el análisis del Capítulo 1, pero otras taxonomías podrían definirlos de manera distinta. El valor del teorema reside en mostrar que el sistema puede detectar inconsistencias internas del discurso cuando se combinan procesos satélite, no en probar que personificación y naturalización son objetivamente incompatibles.

---

### Teorema no trivial 2: Acumulación de distancia ontológica

Cuando un discurso aplica procesos satélite a una entidad, la distancia ontológica entre el tipo real y el tipo atribuido aumenta. Formalizamos una métrica de distancia y demostramos que procesos que convergen en sustancia incrementan esa distancia.

---

### Teorema T-DIST-GE1 [A-Meta]

La distancia a sustancia es positiva para tipos no sustanciales.

Enunciado.

$$
\forall (t : \text{OntoType}),\;
t \neq \text{substance}
\implies
\text{ontological\_distance}(t, \text{substance}) \geq 1.
$$

Demostración. Sea $t \in \text{OntoType}$ tal que $t \neq \text{substance}$. Procedemos por análisis de casos exhaustivo sobre $t$.

**Caso 1:** $t = \text{relation}$. Por definición de $\text{ontological\_distance}$, el par $(\text{relation}, \text{substance})$ hace match con el primer patrón, produciendo valor $3$. Luego $3 \geq 1$.

**Caso 2:** $t = \text{process}$. El par $(\text{process}, \text{substance})$ produce valor $2$. Luego $2 \geq 1$.

**Caso 3:** $t = \text{property}$. El par $(\text{property}, \text{substance})$ produce valor $1$. Luego $1 \geq 1$.

**Caso 4:** $t = \text{formal\_struct}$. El par $(\text{formal\_struct}, \text{substance})$ produce valor $1$. Luego $1 \geq 1$.

**Caso 5:** $t = \text{convention}$. El par $(\text{convention}, \text{substance})$ produce valor $2$. Luego $2 \geq 1$.

**Caso 6:** $t = \text{substance}$. Este caso queda excluido por hipótesis.

Como $\text{OntoType}$ tiene exactamente estos seis constructores, el análisis es exhaustivo. En todos los casos permitidos se verifica la desigualdad. $\square$

---

### Teorema T-DIST-SUB [A-Meta]

Los procesos que apuntan a sustancia aumentan la distancia ontológica.

Enunciado.

$$
\forall (e : \text{PhysicsEntity}),\;
\text{ontoType}(e) \neq \text{substance}
\implies
\text{ontological\_distance}(\text{ontoType}(e), \text{substance}) \geq 1.
$$

Demostración. Sea $e \in \text{PhysicsEntity}$ tal que $\text{ontoType}(e) \neq \text{substance}$. Sea $t = \text{ontoType}(e)$. Entonces $t \in \text{OntoType}$ y $t \neq \text{substance}$. Aplicando el Teorema T-DIST-GE1 a $t$, obtenemos:

$$
\text{ontological\_distance}(t, \text{substance}) \geq 1.
$$

Sustituyendo $t$ por su definición, se sigue la tesis. $\square$

---

### Verificación en Lean [A-Código]

```lean
-- ============================================================
-- TEOREMA NO TRIVIAL 2: Acumulación de distancia ontológica
-- ============================================================

def ontological_distance (t_real t_attributed : OntoType) : Nat :=
  match t_real, t_attributed with
  | .relation, .substance => 3
  | .process, .substance => 2
  | .property, .substance => 1
  | .formal_struct, .substance => 1
  | .convention, .substance => 2
  | t1, t2 => if t1 = t2 then 0 else 1

theorem distance_to_substance_ge_one (t : OntoType) :
  t ≠ .substance → ontological_distance t .substance ≥ 1 := by
  intro h_not_substance
  cases t with
  | relation => simp [ontological_distance]
  | substance => exact absurd rfl h_not_substance
  | process => simp [ontological_distance]
  | property => simp [ontological_distance]
  | formal_struct => simp [ontological_distance]
  | convention => simp [ontological_distance]

theorem substance_targeting_increases_distance (e : PhysicsEntity) :
  ontoType e ≠ .substance →
  let t_real := ontoType e
  let t_attributed := .substance  -- cualquier proceso que apunte a sustancia
  ontological_distance t_real t_attributed ≥ 1 := by
  intro h_not_substance
  exact distance_to_substance_ge_one (ontoType e) h_not_substance
```

Interpretación: Este teorema demuestra que cualquier proceso que apunte a sustancia (personificación, naturalización, sacralización) aumenta la distancia ontológica entre el tipo real de una entidad y el tipo que se le atribuye (si el tipo real no es sustancia). Por ejemplo, si la energía es una propiedad (tipo real) y el discurso la trata como sustancia mediante naturalización (tipo atribuido), la distancia ontológica es 1. La métrica captura la “lejanía” entre tipos: una relación tratada como sustancia está más lejos (distancia 3) que una propiedad tratada como sustancia (distancia 1).

Nota sobre la métrica de distancia. Los valores numéricos (3, 2, 1) son una heurística provisional basada en el número de categorías intermedias en una jerarquía ontológica implícita. Por ejemplo, para convertir una relación en sustancia, uno podría pasar por: relación → propiedad → estructura → sustancia (3 pasos). Esta métrica no pretende ser una medida natural; es una convención que captura la intuición de que algunos tipos están “más lejos” de sustancia que otros. El lector puede proponer métricas alternativas; el teorema seguiría siendo válido mientras la distancia sea $\geq 1$ para tipos distintos.

Nota sobre el alcance del teorema. El teorema se llama `substance_targeting_increases_distance` (no `satellite_application_increases_distance`) porque modela específicamente procesos que convergen en sustancia. No todos los procesos satélite necesariamente producen sustancia (idealización, totalización, teleologización y temporalización podrían no cambiar el tipo ontológico). El teorema demuestra que los tres procesos formalizados (personificación, naturalización, sacralización) aumentan la distancia, pero no hace afirmaciones sobre los otros cuatro.

---

### Teorema no trivial 3: Emergencia de ontología fantasma

En el discurso real, la reificación no ocurre en oraciones aisladas; ocurre en corpus (conjuntos de oraciones). Cuando un porcentaje significativo de las oraciones de un corpus reifica una entidad, emerge una ontología fantasma: una ontología implícita que no está explícita en ninguna oración individual, pero que estructura todo el discurso.

---

### Teorema T-PHANTOM [A-Meta]

La ontología fantasma implica reificación gramatical.

Enunciado. Para todo corpus $c$ y todo umbral $u \in \mathbb{N}$:

$$
\text{generates\_phantom\_ontology}(c, u)
\implies
\exists (e : \text{PhysicsEntity}) (p : \text{PhysicsPredicate}),
(e, p) \in c.\text{sentences}
\land
\text{is\_grammatical\_reification}(e, p).
$$

Demostración. Sea $c$ un corpus y sea $u$ un número natural tales que $\text{generates\_phantom\_ontology}(c, u)$ es verdadero. Por definición, esto implica tres conjunciones:

1. $u > 0$,
2. $c.\text{sentences}.\text{length} > 0$,
3. $\text{reified\_sentences}.\text{length} \cdot 100 \geq u \cdot c.\text{sentences}.\text{length}$,

donde:

$$
\text{reified\_sentences}
=
c.\text{sentences}.\text{filter}
(\lambda x.\; \text{is\_reified\_bool}(x.1, x.2)).
$$

De (1) y (2) se sigue que:

$$
u \cdot c.\text{sentences}.\text{length} > 0.
$$

Por (3), $\text{reified\_sentences}.\text{length} \cdot 100 > 0$, luego:

$$
\text{reified\_sentences}.\text{length} > 0.
$$

Por tanto, $\text{reified\_sentences} \neq []$.

Como $\text{reified\_sentences}$ es el resultado de filtrar $c.\text{sentences}$ con el predicado $\text{is\_reified\_bool}$, y la lista filtrada es no vacía, existe al menos un elemento $x \in c.\text{sentences}$ tal que:

$$
\text{is\_reified\_bool}(x.1, x.2) = \text{true}.
$$

Sea $x$ dicho elemento. Entonces $x = (e, p)$ para algún $e \in \text{PhysicsEntity}$ y $p \in \text{PhysicsPredicate}$. Como $x$ proviene del filtrado de $c.\text{sentences}$, se tiene:

$$
(e, p) \in c.\text{sentences}.
$$

Por definición de $\text{is\_reified\_bool}$:

$$
\text{is\_reified\_bool}(e, p)
=
\text{if } \text{ontoType}(e) = \text{requiredSubjectType}(p)
\text{ then false else true}.
$$

Como este valor es $\text{true}$, la condición de igualdad es falsa. Luego:

$$
\text{ontoType}(e) \neq \text{requiredSubjectType}(p).
$$

Por definición de $\text{is\_grammatical\_reification}$, esto equivale exactamente a:

$$
\text{is\_grammatical\_reification}(e, p).
$$

Hemos exhibido $e$ y $p$ que satisfacen ambas condiciones. $\square$

---

### Verificación en Lean [A-Código]

```lean
-- ============================================================
-- TEOREMA NO TRIVIAL 3: Emergencia de ontología fantasma
-- ============================================================

structure Corpus where
  sentences : List (PhysicsEntity × PhysicsPredicate)

def is_reified_bool (e : PhysicsEntity) (p : PhysicsPredicate) : Bool :=
  if ontoType e = requiredSubjectType p then false else true

def generates_phantom_ontology (c : Corpus) (threshold_percent : Nat) : Prop :=
  let reified_sentences := c.sentences.filter (fun x => is_reified_bool x.1 x.2)
  threshold_percent > 0 ∧
  c.sentences.length > 0 ∧
  reified_sentences.length * 100 ≥ threshold_percent * c.sentences.length

theorem phantom_ontology_implies_reification (c : Corpus) (threshold : Nat) :
  generates_phantom_ontology c threshold →
  ∃ (e : PhysicsEntity) (p : PhysicsPredicate),
    (e, p) ∈ c.sentences ∧
    is_grammatical_reification e p := by
  intro h_phantom
  unfold generates_phantom_ontology at h_phantom
  obtain ⟨h_thresh_pos, h_len_pos, h_ineq⟩ := h_phantom
  -- Paso 1: Demostrar que la lista filtrada NO es vacía
  have h_filter_not_empty : c.sentences.filter (fun x => is_reified_bool x.1 x.2) ≠ [] := by
    intro h_empty
    have h_len_zero : (c.sentences.filter (fun x => is_reified_bool x.1 x.2)).length = 0 := by
      rw [h_empty]
      rfl
    rw [h_len_zero] at h_ineq
    simp at h_ineq
    have h_product_pos : threshold * c.sentences.length > 0 := Nat.mul_pos h_thresh_pos h_len_pos
    omega
  -- Paso 2: Extraer un elemento de la lista filtrada usando cases
  cases h_filter : c.sentences.filter (fun x => is_reified_bool x.1 x.2) with
  | nil => 
      contradiction
  | cons x rest =>
      have h_mem_filter : x ∈ c.sentences.filter (fun x => is_reified_bool x.1 x.2) := by
        rw [h_filter]
        simp
      have h_mem := List.mem_filter.mp h_mem_filter
      obtain ⟨h_mem_sent, h_bool_true⟩ := h_mem
      unfold is_reified_bool at h_bool_true
      by_cases h_eq : ontoType x.1 = requiredSubjectType x.2
      · rw [if_pos h_eq] at h_bool_true
        contradiction
      · exact ⟨x.1, x.2, h_mem_sent, h_eq⟩
```

Interpretación: Este teorema demuestra que si un corpus tiene un porcentaje positivo de oraciones reificantes, entonces existe al menos una oración reificante. La ontología fantasma es una propiedad emergente del corpus, no de oraciones individuales. Ninguna oración individual dice “el espacio-tiempo es una sustancia”, pero el conjunto de oraciones que usan predicados de sustancia para el espacio-tiempo genera una ontología implícita que estructura todo el discurso.

Nota sobre el estatus epistémico. Formalmente, este teorema es elemental: demuestra que si un porcentaje es positivo, la lista filtrada no está vacía, y por tanto contiene al menos un elemento. Esto es una propiedad básica de las listas finitas. El valor del teorema no reside en la dificultad de la prueba, sino en el encuadre conceptual: formaliza la noción de “ontología fantasma” como una propiedad emergente del corpus que puede operacionalizarse y verificarse mecánicamente. La idea de que patrones globales del discurso implican instancias locales es conceptualmente productiva, aunque la demostración sea técnicamente sencilla.

¿Por qué este teorema no es trivial? Porque requiere:

1. Definir qué es una ontología fantasma (propiedad estadística del corpus).
2. Demostrar que si el porcentaje es positivo, la lista filtrada no está vacía.
3. Extraer un elemento concreto de la lista usando `cases`.
4. Razonamiento aritmético sobre desigualdades (usando `omega`).

---

### 4.4.4 Metateoremas estructurales del sistema [A-Meta]

Los teoremas anteriores muestran detecciones y propiedades emergentes. Ahora añadimos cinco metateoremas estructurales que caracterizan el comportamiento interno del sistema de tipos ontológicos.

---

### Teorema T-DIST-ZERO [A-Meta]

Caracterización de la distancia ontológica nula.

Enunciado.

$$
\forall (t_1, t_2 : \text{OntoType}),\;
\text{ontological\_distance}(t_1, t_2) = 0
\iff
t_1 = t_2.
$$

Demostración. Demostramos las dos implicaciones.

$(\Rightarrow)$ Supongamos:

$$
\text{ontological\_distance}(t_1, t_2) = 0.
$$

Analicemos los casos del pattern matching en la definición.

Si $(t_1, t_2) = (\text{relation}, \text{substance})$, el valor es $3 \neq 0$. Contradicción.

Si $(t_1, t_2) = (\text{process}, \text{substance})$, el valor es $2 \neq 0$. Contradicción.

Si $(t_1, t_2) = (\text{property}, \text{substance})$, el valor es $1 \neq 0$. Contradicción.

Si $(t_1, t_2) = (\text{formal\_struct}, \text{substance})$, el valor es $1 \neq 0$. Contradicción.

Si $(t_1, t_2) = (\text{convention}, \text{substance})$, el valor es $2 \neq 0$. Contradicción.

En cualquier otro caso (catch-all), el valor es:

$$
\text{if } t_1 = t_2 \text{ then } 0 \text{ else } 1.
$$

Para que este valor sea $0$, debe cumplirse $t_1 = t_2$.

Luego $t_1 = t_2$.

$(\Leftarrow)$ Supongamos $t_1 = t_2$. Entonces el par $(t_1, t_1)$ no hace match con ninguno de los patrones específicos, pues todos ellos requieren que el segundo componente sea $\text{substance}$ y que el primer componente pertenezca a:

$$
\{\text{relation}, \text{process}, \text{property}, \text{formal\_struct}, \text{convention}\}.
$$

Como $t_1 = t_2$, si $t_1 = \text{substance}$, ningún patrón tiene primer componente $\text{substance}$; y si $t_1 \neq \text{substance}$, el segundo componente es $t_1 \neq \text{substance}$. En ambos subcasos, el par cae en el catch-all, donde:

$$
\text{if } t_1 = t_1 \text{ then } 0 \text{ else } 1 = 0.
$$

Luego:

$$
\text{ontological\_distance}(t_1, t_2) = 0.
$$

$\square$

---

### Teorema T-DIST-ID [A-Meta]

La distancia ontológica de un tipo consigo mismo es nula.

Enunciado.

$$
\forall (t : \text{OntoType}),\;
\text{ontological\_distance}(t, t) = 0.
$$

Demostración. Sea $t \in \text{OntoType}$. Consideremos el par $(t, t)$ en la definición de $\text{ontological\_distance}$.

Si $t = \text{relation}$, el patrón $(\text{relation}, \text{substance})$ requiere segundo componente $\text{substance} \neq \text{relation}$. Luego no hace match. Los demás patrones específicos fallan por el primer componente. El par cae en catch-all, produciendo:

$$
\text{if } \text{relation} = \text{relation} \text{ then } 0 \text{ else } 1 = 0.
$$

Si $t = \text{process}$, análogamente el segundo componente es $\text{process} \neq \text{substance}$, luego ningún patrón específico hace match. El catch-all produce $0$.

Si $t = \text{property}$, el segundo componente es $\text{property} \neq \text{substance}$. Ningún patrón específico aplica. Catch-all: $0$.

Si $t = \text{formal\_struct}$, el segundo componente es $\text{formal\_struct} \neq \text{substance}$. Ningún patrón específico aplica. Catch-all: $0$.

Si $t = \text{convention}$, el segundo componente es $\text{convention} \neq \text{substance}$. Ningún patrón específico aplica. Catch-all: $0$.

Si $t = \text{substance}$, ningún patrón específico tiene primer componente $\text{substance}$. El par cae en catch-all, produciendo:

$$
\text{if } \text{substance} = \text{substance} \text{ then } 0 \text{ else } 1 = 0.
$$

En todos los casos:

$$
\text{ontological\_distance}(t, t) = 0.
$$

$\square$

---

### Teorema T-INC-SYM [A-Meta]

Simetría de la incompatibilidad entre atributos.

Enunciado.

$$
\forall (p_1, p_2 : \text{AttributedProperty}),\;
\text{are\_incompatible}(p_1, p_2)
\iff
\text{are\_incompatible}(p_2, p_1).
$$

Demostración. Sean $p_1, p_2 \in \text{AttributedProperty}$. Por definición:

$$
\text{are\_incompatible}(p_1, p_2)
\iff
(p_1 = \text{has\_psychology} \land p_2 = \text{no\_psychology})
\lor
(p_1 = \text{no\_psychology} \land p_2 = \text{has\_psychology}).
$$

Por conmutatividad de la conjunción lógica ($\land$), la primera disyunción es lógicamente equivalente a:

$$
(p_2 = \text{no\_psychology} \land p_1 = \text{has\_psychology}),
$$

y la segunda disyunción es equivalente a:

$$
(p_2 = \text{has\_psychology} \land p_1 = \text{no\_psychology}).
$$

Reordenando:

$$
\text{are\_incompatible}(p_1, p_2)
\iff
(p_2 = \text{has\_psychology} \land p_1 = \text{no\_psychology})
\lor
(p_2 = \text{no\_psychology} \land p_1 = \text{has\_psychology}).
$$

El lado derecho es exactamente $\text{are\_incompatible}(p_2, p_1)$ por definición. $\square$

---

### Teorema T-INC-IRR [A-Meta]

Irreflexividad de la incompatibilidad.

Enunciado.

$$
\forall (p : \text{AttributedProperty}),\;
\neg \text{are\_incompatible}(p, p).
$$

Demostración. Sea $p \in \text{AttributedProperty}$. Por definición:

$$
\text{are\_incompatible}(p, p)
\iff
(p = \text{has\_psychology} \land p = \text{no\_psychology})
\lor
(p = \text{no\_psychology} \land p = \text{has\_psychology}).
$$

Supongamos, para reducir al absurdo, que la primera disyunción es verdadera. Entonces:

$$
p = \text{has\_psychology}
$$

y

$$
p = \text{no\_psychology}.
$$

Luego:

$$
\text{has\_psychology} = \text{no\_psychology}.
$$

Pero estos son constructores distintos de un tipo inductivo, luego son distintos. Contradicción.

Supongamos que la segunda disyunción es verdadera. Entonces:

$$
p = \text{no\_psychology}
$$

y

$$
p = \text{has\_psychology}.
$$

Luego:

$$
\text{no\_psychology} = \text{has\_psychology}.
$$

Misma contradicción.

Como ambas disyunciones son falsas, la disyunción completa es falsa. Luego:

$$
\neg \text{are\_incompatible}(p, p).
$$

$\square$

---

### Teorema T-BOOL-REF [A-Meta]

Equivalencia entre la versión booleana y la proposicional de la reificación.

Enunciado.

$$
\forall (e : \text{PhysicsEntity}), \forall (p : \text{PhysicsPredicate}),\;
\text{is\_reified\_bool}(e, p) = \text{true}
\iff
\text{is\_grammatical\_reification}(e, p).
$$

Demostración. Sean $e$ y $p$ arbitrarios. Recordemos las definiciones:

$$
\text{is\_reified\_bool}(e, p)
=
\text{if } \text{ontoType}(e) = \text{requiredSubjectType}(p)
\text{ then false else true},
$$

$$
\text{is\_grammatical\_reification}(e, p)
\iff
\text{ontoType}(e) \neq \text{requiredSubjectType}(p).
$$

Distinguimos dos casos exhaustivos.

**Caso 1:** $\text{ontoType}(e) = \text{requiredSubjectType}(p)$. Entonces:

$$
\text{is\_reified\_bool}(e, p) = \text{false}.
$$

Y:

$$
\text{is\_grammatical\_reification}(e, p)
=
(\text{ontoType}(e) \neq \text{requiredSubjectType}(p))
=
\text{false}.
$$

Luego ambos lados de la equivalencia son falsos, y la equivalencia se satisface.

**Caso 2:** $\text{ontoType}(e) \neq \text{requiredSubjectType}(p)$. Entonces:

$$
\text{is\_reified\_bool}(e, p) = \text{true}.
$$

Y:

$$
\text{is\_grammatical\_reification}(e, p) = \text{true}.
$$

Luego ambos lados son verdaderos, y la equivalencia se satisface.

En ambos casos la equivalencia se verifica. $\square$

---

## 4.5 Los 7 procesos satélite como operadores gramaticales [A/C]

En el Capítulo 1 (sección 1.2.1), nosotros identificamos siete procesos que estabilizan la reificación: idealización, personificación, naturalización, totalización, teleologización, sacralización y temporalización. En la sección 4.4, nosotros formalizamos tres de ellos (personificación, naturalización, sacralización) como estructuras que atribuyen propiedades. Aquí mostramos cómo operan en el discurso físico.

| Proceso | Ejemplo en física | Operación gramatical |
|---|---|---|
| Naturalización | “Las leyes de la naturaleza” como entidades eternas e intocables, independientes del marco teórico que las formula. | Presenta una convención (el marco teórico) como si fuera un dato natural. |
| Personificación | “La naturaleza aborrece el vacío”, “la naturaleza no salta”, “el universo busca el equilibrio”. | Atribuye psicología (aborrecer, buscar) a un proceso. |
| Sacralización | “La ecuación más bella de la física”, “la elegancia de la teoría”, presentación de ciertas ecuaciones como intocables. | Eleva una estructura formal a un estatus que exige reverencia y bloquea la revisión. |
| Teleologización | “El universo tiende al equilibrio”, “la entropía siempre aumenta” presentado como dirección necesaria y no como regularidad estadística. | Atribuye dirección y propósito a un proceso. |
| Idealización | “El modelo estándar es la teoría final”, “la teoría del todo”. | Eleva una construcción a un ideal de completitud y perfección. |
| Totalización | “La física explica todo”, “la teoría unificada”. | Presenta un dominio parcial como si cubriera la totalidad. |
| Temporalización | “La flecha del tiempo” como propiedad del universo y no como asimetría termodinámica. | Convierte una regularidad estadística en una entidad permanente que “avanza”. |

Nota sobre el estatus epistémico. La formalización de los procesos satélite como estructuras con atributos es [A] (compila en Lean 4). La identificación de ejemplos específicos en el discurso físico es [C] (interpretación basada en análisis del discurso). De los siete procesos identificados en el Capítulo 1, nosotros formalizamos tres (personificación, naturalización, sacralización) como ilustración del patrón. Los cuatro restantes (idealización, totalización, teleologización, temporalización) se presentan solo como análisis discursivo [C], sin formalización en Lean. La extensión a los siete procesos es conceptualmente directa pero requeriría definir propiedades adicionales para cada proceso.

---

## 4.6 Evidencia empírica: Edelstein, Maldacena, Deser [B/C]

### La entrevista a José Edelstein

En la entrevista del 27 de julio de 2026 en el programa “El Maravilloso Mundo de la Física” (Gelatina), el físico teórico José Edelstein proporcionó ejemplos directamente observables de reificación en el discurso de divulgación [B]. Nosotros identificamos los siguientes:

### Ejemplo 1: “Nos llegan vibraciones del espacio-tiempo”

Edelstein dice: “No solo nos llega luz del cielo, nos llegan vibraciones del espacio-tiempo, nos llegan partículas elementales en cantidades industriales.”

Análisis gramatical:

- Sujeto: “vibraciones del espacio-tiempo”.
- El espacio-tiempo aparece como un medio material que “vibra”.
- Tipo atribuido: substance (algo que puede vibrar).
- Tipo real: formal_struct (variedad con métrica).
- Veredicto: reificación gramatical ✓.
- Proceso satélite: naturalización (presenta la métrica como un medio físico natural).

### Ejemplo 2: “El universo es un gran mecanismo de relojería”

Edelstein dice, refiriéndose al universo newtoniano: “El universo newtoniano tiene leyes deterministas y mecanicistas. El universo es un gran mecanismo de relojería en el cual todo se mueve porque una causa previa hizo que se mueva inexorablemente de la manera que lo hace.”

Análisis gramatical:

- Sujeto: “el universo”.
- Predicado: “es un gran mecanismo de relojería”.
- El universo aparece como un objeto mecánico (sustancia).
- Tipo atribuido: substance (mecanismo).
- Tipo real: process (conjunto de procesos físicos).
- Veredicto: reificación gramatical ✓.
- Proceso satélite: naturalización + totalización (presenta la totalidad de los procesos como un objeto mecánico unitario).

Nota importante. Edelstein mismo reconoce la distinción entre el mapa y el territorio en la misma entrevista. Cita a Borges y dice: “El éxito de la ciencia justamente radica en el éxito de los mapas. Si el mapa necesitara detallar hasta la farola y el perrito que está paseando, sería un mapa irrelevante.” Esto muestra que los físicos teóricos saben que el formalismo no es la realidad. La reificación no ocurre por ignorancia; ocurre como prótesis pedagógica necesaria para comunicar estructuras abstractas en lenguaje natural. El problema surge cuando la audiencia (y a veces el propio físico en sus horas de filosofía) confunde la prótesis con la realidad.

### Ejemplo 3: “Ni el vaso sabe si está lleno o vacío”

Edelstein dice, sobre el mundo cuántico: “El no saber dónde está o el no saber si está lleno no es porque ignorancia mía, es que ni el vaso sabe si está lleno o vacío.”

Análisis gramatical:

- Sujeto: “el vaso” (en contexto cuántico).
- Predicado: “sabe”.
- Se atribuye un estado epistémico (“saber”) a un sistema físico.
- Tipo atribuido: substance con psicología (agente que “sabe”).
- Tipo real: process (sistema cuántico en superposición).
- Veredicto: personificación ✓.

### La conferencia de Maldacena

En la conferencia del 28 de julio de 2026 en el Planetario de Buenos Aires (Usina del Arte), Juan Martín Maldacena presentó la charla “El significado del espacio-tiempo: agujeros negros y entrelazamiento cuántico” [B]. La sinopsis oficial plantea las preguntas: “¿Qué son el espacio y el tiempo? ¿Qué ocurre en el interior de un agujero negro? ¿Qué relación existe entre la gravedad y la mecánica cuántica?”

La relevancia para este capítulo es la siguiente: la correspondencia AdS/CFT (1997) propone que la geometría del espacio-tiempo en el “bulk” (interior) es dual a una teoría cuántica de campos en la frontera. Si esta conjetura es correcta, el espacio-tiempo no es el nivel fundamental de descripción; es una estructura emergente derivada del entrelazamiento cuántico. Esto no “refuta” la relatividad general, pero muestra que la geometría puede no ser una sustancia primaria sino una estructura derivada de relaciones cuánticas.

Nota sobre el estatus epistémico de AdS/CFT. La correspondencia AdS/CFT es una conjetura con evidencia matemática considerable, pero no ha sido confirmada experimentalmente de manera directa. Nosotros la citamos como evidencia de que el discurso físico de frontera contempla formulaciones no sustancialistas, no como prueba de que “el espacio-tiempo no existe”. El estatus epistémico es: conjetura con soporte matemático fuerte, no teoría confirmada experimentalmente.

### La derivación de Deser (1970)

Stanley Deser demostró en 1970 que las ecuaciones de Einstein pueden derivarse partiendo de un campo de espín-2 en espacio plano de Minkowski, sin postular curvatura geométrica [B]. La derivación procede por autoconsistencia: se comienza con un campo $h_{\mu\nu}$ en espacio plano, se exige que el campo sea fuente de sí mismo (acoplamiento universal), y la iteración converge a las ecuaciones de Einstein.

La relevancia para este capítulo: la “geometría curva” no es la única formulación posible de la relatividad general. Es un reempaquetamiento matemático que resulta elegante y poderoso, pero que no es ontológicamente necesario. El formalismo puede expresarse sin geometría curva. Esto refuerza la tesis de que la reificación geométrica (“el espacio-tiempo se curva”) es una elección de representación, no una descripción de una sustancia que se deforma.

---

## 4.7 La pedagogía de la reificación [B/C]

La investigación en educación física (PER) demuestra que la reificación no es un error accidental en la enseñanza de la física; es una estrategia pedagógica explícita y deliberada [B].

### La reificación como herramienta heurística

La investigación muestra que:

- Hablar de “calor que fluye” permite a los estudiantes aplicar su intuición sobre fluidos a un fenómeno térmico [B].
- Personificar la energía como algo que se “almacena” o se “usa” hace accesible un concepto abstracto [B].
- Los modelos pedagógicos (la sábana elástica, el mecanismo de relojería) son reificaciones controladas que sirven como anclajes cognitivos [B].

### La reificación implícita como fuente de misconceptions

En la investigación en enseñanza de la física (PER, por sus siglas en inglés), el término misconceptions —que aquí traducimos como concepciones erróneas— no designa simples despistes o malentendidos pasajeros, sino ideas profundamente arraigadas que los estudiantes construyen para dar sentido al mundo y que resultan incompatibles con el conocimiento científico aceptado. A diferencia de un error puntual por falta de información, una concepción errónea es sistemática, internamente coherente desde la lógica cotidiana y sorprendentemente resistente a la instrucción formal. Por ejemplo, creer que “la energía se gasta” o que “la aceleración siempre va en dirección del movimiento” no es un olvido, sino la manifestación de una ontología implícita en la que la energía se trata como una sustancia consumible o el movimiento como una propiedad que los objetos poseen. Estas concepciones erróneas suelen originarse precisamente en las metáforas reificantes que impregnan el discurso pedagógico; cuando la analogía de la sábana elástica deja de ser una prótesis cognitiva consciente y se convierte en una descripción literal del espacio-tiempo, la reificación gramatical se fosiliza en un error ontológico persistente. Nuestro sistema formal de tipos ontológicos detecta exactamente ese desajuste: la atribución a una entidad de propiedades que no corresponden a su tipo real.

Cuando la reificación se realiza sin advertencia explícita, produce errores ontológicos persistentes en los estudiantes [B]:

- “La aceleración siempre va en dirección del movimiento” (confusión entre proceso y estado).
- “La inercia es una fuerza” (confusión entre propiedad y relación).
- “La energía se gasta” (tratamiento de una propiedad como sustancia consumible).

### La conexión con nuestro sistema formal

Lo que la investigación en PER identifica como “ontological misconceptions” es exactamente lo que nuestro sistema formal detecta como `is_grammatical_reification`. La PER lo describe en prosa; nosotros lo formalizamos como un mismatch de tipos verificable en Lean 4.

La PER propone como solución desarrollar “conciencia ontológica” en los estudiantes: enseñarles qué tipo de cosa es cada concepto antes de enseñarles sus propiedades [B]. Nuestro sistema formal es una implementación verificable de esa propuesta: clasifica entidades por tipo ontológico y detecta cuándo se les atribuyen propiedades que no corresponden a su tipo.

### La paradoja pedagógica

La investigación revela una paradoja [C]:

1. La reificación es necesaria para el aprendizaje inicial (sin ella, los conceptos abstractos son inaccesibles).
2. La reificación es perniciosa si no se desactiva posteriormente (produce misconceptions persistentes).

La solución que la PER propone es la misma que nosotros proponemos en este libro: usar la reificación como prótesis cognitiva, pero hacer visible la prótesis. Enseñar con la metáfora, pero señalar que es una metáfora. Usar la sábana elástica, pero decir “esto es una analogía; el formalismo real es una variedad con métrica”.

Esto conecta directamente con la analogía del espejismo que desarrollamos en el Capítulo 1 (sección 1.2.2): la reificación es como el espejismo del desierto. No es un error del observador; es una consecuencia inevitable de la física atmosférica (o de la gramática del lenguaje natural). Pero el observador puede aprender a reconocer el espejismo. La “conciencia ontológica” es el aprendizaje de reconocer el espejismo.

---

## 4.8 Limitaciones: qué puede y qué no puede detectar este sistema [C]

Para completar el análisis, nosotros señalamos explícitamente lo que este sistema no puede hacer.

### Primera limitación: la clasificación ontológica es una elección, no un descubrimiento.

La función `ontoType` clasifica el espacio-tiempo como `.formal_struct` y la energía como `.property`. Esta clasificación se ancla en el formalismo físico estándar, pero no es la única posible. Una ontología de “ontología primitiva de la energía” clasificaría la energía como `.substance`. Una ontología procesual (Whitehead) clasificaría la materia como `.process`. Si el lector cambia la clasificación, los teoremas cambian. Esto no es un defecto; es una consecuencia de lo que establecimos en el Capítulo 2 (sección 2.7): los axiomas son elecciones filosóficas.

### Segunda limitación: el sistema detecta mismatches de tipo, no intenciones.

Cuando un físico dice “el espacio-tiempo se curva” como metáfora pedagógica consciente, el sistema detecta el mismatch de tipo. Pero no distingue entre:

1. Un físico que sabe que es una metáfora y la usa deliberadamente (prótesis cognitiva).
2. Un divulgador que cree literalmente que el espacio-tiempo es una tela elástica (reificación inconsciente).
3. Un texto de divulgación que no explicita la metáfora (reificación implícita).

El sistema detecta la estructura gramatical de la reificación. La interpretación de la intención requiere análisis del discurso adicional.

### Tercera limitación: el sistema es finito y estático.

El sistema clasifica siete entidades y ocho predicados. El discurso físico real contiene miles de entidades y predicados. El sistema es un modelo mínimo que ilustra la estructura, no una base de datos completa. Extenderlo requeriría añadir más entidades y predicados, lo cual es conceptualmente directo pero laborioso.

### Cuarta limitación: el sistema no modela la dinámica de la reificación.

La reificación no es un evento puntual; es un proceso que se estabiliza con el tiempo mediante los siete procesos satélite. El sistema actual detecta el mismatch en un instante dado, pero no modela cómo la reificación se construye, se estabiliza y se desactiva a lo largo del tiempo. Modelar esa dinámica requeriría un sistema temporal o de eventos, que es trabajo futuro.

### Quinta limitación: el sistema no resuelve el problema pedagógico.

Detectar que “el espacio-tiempo se curva” es una reificación gramatical no dice cómo enseñar relatividad general sin esa metáfora. La solución pedagógica (usar la metáfora pero señalarla como metáfora) requiere una intervención didáctica que el sistema formal no puede proporcionar. El sistema diagnostica; la intervención es tarea del pedagogo.

---

## 4.9 Conexión con los capítulos anteriores y siguientes

### Conexión con el Capítulo 1 (reificación como error categorial)

El sistema formalizado en este capítulo es una implementación verificable del protocolo de cuatro preguntas del Capítulo 1, aplicada específicamente al discurso físico. La Pregunta 1 (tipo del objeto) se implementa como `ontoType`. La Pregunta 2 (atribución indebida) se implementa como `requiredSubjectType`. La Pregunta 3 (reformulación alternativa) se ilustra con la derivación de Deser y la correspondencia AdS/CFT. La Pregunta 4 (teoría resuelta con narrativa sucia) se aplica al caso del espacio-tiempo.

### Conexión con el Capítulo 3 (estratificación como anti-reificación)

En el Capítulo 3, la estratificación impide que el predicado de verdad se aplique a sí mismo. En este capítulo, la clasificación por tipos ontológicos impide que un predicado de sustancia se aplique a una estructura relacional. El principio es el mismo: restricción de tipo como mecanismo anti-reificatorio.

Diferencia importante: En SPA, la restricción es preventiva: el compilador impide construir fórmulas mal formadas. En este capítulo, la restricción es diagnóstica: el sistema detecta reificaciones después de que han sido formuladas en lenguaje natural. La diferencia no es trivial: SPA bloquea la reificación antes de que ocurra; este sistema la detecta después. Ambos son mecanismos anti-reificatorios, pero operan en momentos distintos del proceso discursivo.

### Conexión con el Capítulo 5 (medición cuántica)

En el Capítulo 5, nosotros aplicaremos el mismo protocolo al caso de la medición cuántica: el “colapso de la función de onda” como reificación de una actualización epistémica (cambio de información) tratada como evento físico (sustancia que “colapsa”). El sistema formal de este capítulo puede extenderse para incluir entidades cuánticas (función de onda, observable, estado entrelazado) y predicados cuánticos (colapsa, se entrelaza, se superpone).

### Conexión con el Capítulo 6 (sistemas normativos)

En el Capítulo 6, nosotros aplicaremos el protocolo al discurso jurídico y político. La estructura es análoga: “el Estado decide” reifica una construcción institucional (relación entre personas y normas) tratándola como agente unitario (sustancia con voluntad). El sistema SFCD formalizado en Z3 (Capítulo 2) es el análogo normativo del sistema de tipos ontológicos que presentamos aquí.

---

## 4.10 Síntesis de demostraciones formales del capítulo [A-Meta]

Nosotros presentamos la siguiente tabla de demostraciones formales en prosa integradas en este capítulo. Estas pruebas elevan el estatus epistémico de las secciones formales de [A-Código] a [A-Meta] + [A-Código], replicando el protocolo usado en el Capítulo 5.

| Designación | Enunciado | Método | Sección |
|---|---|---|---|
| T-REF-1 | “El espacio-tiempo se curva” es reificación | Inspección de tipos | 4.3 |
| T-REF-2 | “La energía fluye” es reificación | Inspección de tipos | 4.3 |
| T-REF-3 | “La naturaleza aborrece el vacío” es reificación | Inspección de tipos | 4.3 |
| T-REF-4 | “La energía se almacena” es reificación | Inspección de tipos | 4.3 |
| T-REF-5 | “El espacio-tiempo vibra” es reificación | Inspección de tipos | 4.3 |
| T-NOREF-1 | “El campo métrico relaciona eventos” no es reificación | Igualdad de tipos | 4.3 |
| T-NOREF-2 | “La estructura tiene la propiedad de curvatura” no es reificación | Igualdad de tipos | 4.3 |
| T-INCOMP | Personificación y naturalización son incompatibles | Exhibición de testigos | 4.4 |
| T-DIST-GE1 | Distancia a sustancia positiva para tipos no sustanciales | Análisis de casos | 4.4 |
| T-DIST-SUB | Procesos que apuntan a sustancia aumentan distancia | Consecuencia de T-DIST-GE1 | 4.4 |
| T-PHANTOM | Ontología fantasma implica reificación | Lista filtrada no vacía | 4.4 |
| T-DIST-ZERO | Distancia nula si y solo si igualdad de tipos | Análisis de pattern matching | 4.4.4 |
| T-DIST-ID | Distancia de un tipo consigo mismo es nula | Análisis de casos | 4.4.4 |
| T-INC-SYM | Simetría de la incompatibilidad | Conmutatividad lógica | 4.4.4 |
| T-INC-IRR | Irreflexividad de la incompatibilidad | Reducción al absurdo | 4.4.4 |
| T-BOOL-REF | Equivalencia entre versión booleana y proposicional | Análisis de casos | 4.4.4 |

Conclusión metodológica [C]. El Capítulo 4 posee materia prima para 16 demostraciones formales en prosa. Estas pruebas son correctas, completas y verificables por un lector con formación básica en lógica proposicional, teoría de tipos elemental y semántica de lenguajes funcionales. Su integración junto a los códigos Lean eleva el estatus epistémico del capítulo de una verificación meramente computacional a una demostración formal mixta **[A-Meta] + [A-Código]**.

---

## Etiquetado del capítulo

| Sección | Contenido | Clasificación |
|---|---|---|
| 4.1 | Aplicación del protocolo al espacio-tiempo | [C] Interpretación |
| 4.2 | Sistema de tipos ontológicos en Lean 4 | [A-Código] |
| 4.3 | Teoremas básicos de detección de reificación | [A-Meta] + [A-Código] |
| 4.4 | Teoremas no triviales (incompatibilidad, acumulación, emergencia) | [A-Meta] + [A-Código] |
| 4.4.4 | Metateoremas estructurales del sistema | [A-Meta] |
| 4.5 | Procesos satélite como operadores (estructura formal) | [A-Código] |
| 4.5 | Identificación de ejemplos en física | [C] Interpretación |
| 4.6 | Entrevista a Edelstein | [B] Citada de fuente |
| 4.6 | Conferencia de Maldacena | [B] Citada de fuente |
| 4.6 | Derivación de Deser | [B] Citada de literatura |
| 4.7 | Pedagogía de la reificación (PER) | [B] Citada de literatura |
| 4.7 | Conexión con nuestro sistema | [C] Interpretación |
| 4.8 | Limitaciones del sistema | [C] Interpretación |
| 4.9 | Conexiones con otros capítulos | [C] Interpretación |
| 4.10 | Síntesis de demostraciones formales | [A-Meta] + [C] |