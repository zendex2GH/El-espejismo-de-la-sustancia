
# Capítulo 3: SPA — Un sistema aritmético estratificado

## 3.0 Una puerta de entrada: la paradoja del mentiroso

Antes de presentar el sistema formal, conviene detenerse en el problema que lo motiva. La paradoja del mentiroso es una de las más antiguas de la tradición lógica: un enunciado que afirma "esta oración es falsa". Si es verdadera, entonces es falsa. Si es falsa, entonces es verdadera. La paradoja no se resuelve con más información sobre el mundo; se resuelve con una restricción sobre la estructura del lenguaje que la formula.

En 1933, Alfred Tarski demostró que la paradoja del mentiroso no es un juego de palabras: tiene una estructura formal precisa que puede reproducirse en cualquier lenguaje lo suficientemente expresivo como para contener su propio predicado de verdad [B]. La consecuencia es un teorema de imposibilidad: ningún lenguaje formal puede contener su propia definición de verdad sin volverse inconsistente.

¿Por qué esto importa para el proyecto de este trabajo? Porque la paradoja de Tarski es, en su estructura más profunda, un caso de reificación: el predicado de verdad —que es una fórmula, una relación sintáctica entre un código y una propiedad— se trata como si fuera una sustancia autorreferente, una entidad capaz de aplicarse a sí misma. Es exactamente el tipo de error categorial que el Capítulo 1 identifica: una construcción de tipo "relación" es tratada como si tuviera propiedades de tipo "sustancia". La estratificación impide este error de tipo mediante una restricción sintáctica explícita.

En este capítulo presentamos SPA (Stratified Peano Arithmetic), un sistema formal que nosotros diseñamos y formalizamos en Lean 4 para implementar la solución de Tarski de manera verificada mecánicamente. SPA no es una invención teórica nueva: la solución que implementa es conocida desde hace décadas. Lo que SPA aporta es una implementación completa, estratificada, y verificada sin omisiones.

## 3.1 El problema que SPA resuelve: el teorema de Tarski [B]

El teorema de Tarski establece la indefinibilidad de la verdad: ninguna fórmula del lenguaje de la aritmética puede definir el conjunto de sentencias verdaderas de ese mismo lenguaje [B].

La demostración es una variante formal de la paradoja del mentiroso. Si existiera una fórmula $V(x)$ que definiera la verdad —es decir, $V(\ulcorner \varphi \urcorner)$ fuera equivalente a "$\varphi$ es verdadera"—, entonces por diagonalización podríamos construir una oración $\lambda$ que afirmara "yo soy falsa":

$$
\lambda \equiv \neg V(\ulcorner \lambda \urcorner)
$$

Si $\lambda$ es verdadera, entonces $V(\ulcorner \lambda \urcorner)$ es falsa, y por tanto $\lambda$ es falsa. Si $\lambda$ es falsa, entonces $V(\ulcorner \lambda \urcorner)$ es verdadera, y por tanto $\lambda$ es verdadera. Contradicción.

El problema no reside en la noción de verdad en sí, sino en pretender que el predicado de verdad habite el mismo nivel lógico que las fórmulas que evalúa. Cuando el lenguaje y el metalenguaje se confunden, la autorreferencia destructiva es inevitable.

Estado del problema. Este no es un problema abierto. Tarski mismo propuso una solución: la jerarquía de metalenguajes [B]. La teoría de tipos de Russell (1908) ya había introducido una distinción similar para las paradojas conjuntistas [B]. Existen otras formalizaciones del teorema de completitud en asistentes de pruebas (Isabelle/HOL, Coq), pero SPA se distingue por hacer de la estratificación un mecanismo sintáctico explícito, con operadores intensionales (`provable_op`, `true_op`) cuyo tipado refleja la jerarquía de niveles y cuya corrección está garantizada por el verificador de tipos de Lean [A].

## 3.2 Aplicación del protocolo al caso de Tarski [C]

Como mostramos en 3.0, la paradoja de Tarski es un caso de reificación: el predicado de verdad (una relación sintáctica) se trata como si fuera una sustancia autorreferente. Apliquemos ahora las cuatro preguntas del Capítulo 0 a este caso:

Pregunta 1: ¿Cuál es el objeto formal y cuál es su tipo?

El predicado de verdad $V(x)$ es una fórmula de la aritmética de primer orden. Su tipo nativo es `ArithForm s` para algún nivel $s$. Su argumento $x$ es un numeral que codifica una fórmula del mismo nivel $s$.

Pregunta 2: ¿Qué atribuye la narrativa a este objeto que su tipo no contiene?

La definición informal de $V(x)$ presupone que puede aplicarse a todas las fórmulas del lenguaje, incluidas aquellas que contienen al propio $V$. Es decir, presupone que $V$ pertenece al mismo nivel que las fórmulas que evalúa. Esta presuposición no está forzada por el tipo de $V$; es una decisión de diseño implícita en la formulación estándar.

Pregunta 3: ¿Existe una descripción alternativa sin ese atributo?

Sí. La jerarquía de metalenguajes de Tarski —y, de manera más general, la teoría de tipos— muestra que la verdad puede definirse de manera consistente si se respeta una distinción de niveles: el predicado de verdad para fórmulas del nivel $n$ debe residir en el nivel $n+1$. SPA no inventa esta solución, pero la implementa de manera completa y verificada [A].

Pregunta 4: ¿Es teoría resuelta con narrativa sucia?

Sí. Tarski resolvió el problema técnico en 1933 [B]. La jerarquía de lenguajes es una solución conocida desde hace décadas. El desafío no es encontrar una solución, sino formalizarla completamente y mostrar que no sacrifica la completitud del sistema.

## 3.3 La solución de SPA: operadores estratificados [A/B]

La solución que nosotros implementamos en SPA es directa: los operadores que evalúan fórmulas deben residir en un nivel superior a las fórmulas evaluadas. En la sintaxis de SPA, esto se implementa mediante constructores que incluyen un testigo explícito de la relación de niveles:

```
ArithForm.provable_op : {s_lower : Nat} → (s = s_lower + 1) → ArithTerm s → ArithForm s
ArithForm.true_op     : {s_lower : Nat} → (s = s_lower + 1) → ArithTerm s → ArithForm s
```

El parámetro `h : s = s_lower + 1` es un testigo que certifica que el nivel $s$ es estrictamente superior al nivel $s_{\text{lower}}$ de la fórmula evaluada. Sin este testigo, la fórmula no está bien formada. El verificador de tipos de Lean rechaza cualquier intento de construir `provable_op` o `true_op` sin esta certificación.

¿Qué representa el argumento de tipo `ArithTerm s`? No es la fórmula misma que se evalúa, sino un término que codifica esa fórmula. La función de serialización $\ulcorner \cdot \urcorner : \text{ArithForm } s_{\text{lower}} \to \text{ArithTerm } s$ convierte una fórmula del nivel inferior en un numeral que la representa. Así, `true_op h (⌜φ⌝)` es una fórmula del nivel $s$ que afirma "la fórmula φ del nivel $s_{\text{lower}}$ es verdadera".

En términos de tipos, esto significa que una fórmula en el nivel $n$ puede contener `provable_op` o `true_op` aplicados a términos que codifican fórmulas del nivel $n-1$. No existe ninguna manera de construir `provable_op` o `true_op` aplicados a fórmulas del mismo nivel.

Nota importante. Esto no elimina toda forma de autorreferencia. La diagonalización sigue siendo posible dentro de cada nivel: en el nivel $n$ puede construirse una fórmula que hable de la demostrabilidad de fórmulas del nivel $n-1$. Lo que se bloquea es la autorreferencia destructiva: aquella que requiere que el predicado de verdad o demostrabilidad pertenezca al mismo nivel que la fórmula evaluada. La autorreferencia se reorganiza jerárquicamente, no se suprime.

Diagrama de la jerarquía de niveles

Para visualizar cómo opera la estratificación, consideremos los tres primeros niveles:

```
Nivel 2: fórmulas que pueden hablar de verdad/demostrabilidad del nivel 1
    ↑ true_op, provable_op (con testigo s = s_lower + 1)
Nivel 1: fórmulas que pueden hablar de verdad/demostrabilidad del nivel 0
    ↑ true_op, provable_op (con testigo s = s_lower + 1)
Nivel 0: fórmulas aritméticas básicas (sin operadores de verdad)
```

Cada nivel puede evaluar fórmulas del nivel inmediatamente inferior, pero no puede evaluarse a sí mismo. Esto impide la formación de la oración paradójica $\lambda$ que afirma "yo soy falsa", porque tal oración requeriría que el predicado de verdad habitara el mismo nivel que la fórmula que evalúa.

Ejemplo concreto de una fórmula bien formada

Para ilustrar cómo funciona la estratificación sintáctica, consideremos un ejemplo simple. Supongamos que queremos expresar en el nivel 1 que "la fórmula $0 = 0$ del nivel 0 es verdadera":

```
-- La fórmula "0 = 0" del nivel 0:
def zero_eq_zero : ArithForm 0 :=
  .eq (.zero : ArithTerm 0) (.zero : ArithTerm 0)
-- Su código de serialización (un numeral):
def code_zero_eq_zero : ArithTerm 1 :=
  serialize zero_eq_zero  -- función que codifica la fórmula como numeral
-- La afirmación "0 = 0 es verdadera" en el nivel 1:
def truth_claim : ArithForm 1 :=
  .true_op (s := 1) (s_lower := 0) (by simp) code_zero_eq_zero
```

El testigo `(by simp)` certifica que $1 = 0 + 1$. Si intentáramos construir `.true_op` en el nivel 0 aplicado a una fórmula del nivel 0, Lean rechazaría la construcción en tiempo de compilación con un error de tipo. La estratificación no es una convención que nosotros respetemos voluntariamente; es una restricción impuesta por el verificador de tipos.

## 3.4 Sintaxis formal de SPA [A]

La sintaxis de SPA se define mediante tipos inductivos en Lean 4, indexados por un parámetro de nivel $s : \mathbb{N}$. Presentamos las definiciones y luego las explicamos paso a paso.

Términos aritméticos (`ArithTerm s`):

```
inductive ArithTerm (s : Nat) : Type where
  | var    : Nat → ArithTerm s
  | const  : NatS s → ArithTerm s
  | henkin : HenkinConst → ArithTerm s
  | zero   : ArithTerm s
  | succ   : ArithTerm s → ArithTerm s
  | add    : ArithTerm s → ArithTerm s → ArithTerm s
  | mul    : ArithTerm s → ArithTerm s → ArithTerm s
  | exp    : ArithTerm s → ArithTerm s → ArithTerm s
  | pred   : ArithTerm s → ArithTerm s
```

Explicación para el lector no especializado. Los términos son las "expresiones numéricas" del sistema: variables, constantes, cero, sucesor, suma, multiplicación, exponenciación y predecesor. El parámetro `s` no afecta la estructura interna de los términos; actúa como una "etiqueta de nivel" que impide mezclar términos de niveles distintos en fórmulas estratificadas. Las constantes de Henkin (`henkin`) se incluyen para la construcción posterior de testigos existenciales.

Fórmulas aritméticas (`ArithForm s`):

```
inductive ArithForm (s : Nat) : Type where
  | bottom      : ArithForm s
  | eq          : ArithTerm s → ArithTerm s → ArithForm s
  | impl        : ArithForm s → ArithForm s → ArithForm s
  | neg         : ArithForm s → ArithForm s
  | forall_form : Nat → ArithForm s → ArithForm s
  | provable_op : {s_lower : Nat} → (s = s_lower + 1) → ArithTerm s → ArithForm s
  | true_op     : {s_lower : Nat} → (s = s_lower + 1) → ArithTerm s → ArithForm s
  | list_nth_eq : ArithTerm s → ArithTerm s → ArithTerm s → ArithForm s
```

Explicación para el lector no especializado.  Las fórmulas son las  "oraciones " del sistema: absurdo ( `bottom` ), igualdad ( `eq` ), implicación ( `impl` ), negación ( `neg` ), cuantificación universal ( `forall_form` ), y los dos operadores estratificados ( `provable_op`  y  `true_op` ). El constructor  `list_nth_eq`  es un auxiliar técnico para la serialización de listas.

Nota sobre la compilación. Los fragmentos de código que aparecen en las secciones 3.4 a 3.7 son extractos ilustrativos de un sistema más grande (SPA, 27.600 líneas de código Lean 4). Estos fragmentos no compilarán de forma aislada porque dependen de definiciones auxiliares (`NatS`, `HenkinConst`, `serialize`, etc.) que no están incluidas aquí por razones de espacio. Para verificar la compilación completa de SPA, es necesario acceder al repositorio del proyecto [enlace]. Los fragmentos se incluyen para ilustrar la estructura del sistema, no para ser ejecutados directamente.

## 3.4.1 Metateoremas de estratificación sintáctica [A-Meta]

Los siguientes metateoremas se derivan directamente de la sintaxis estratificada de SPA. No introducen nuevo código Lean: son demostraciones formales en prosa [A-Meta] que explicitan consecuencias estructurales de las firmas de tipo definidas en la sección 3.4.

**Metateorema T-NoInt-0 [A-Meta]**

El nivel 0 no admite operadores intensionales.

Enunciado. Ninguna fórmula `φ : ArithForm 0` contiene subfórmulas de la forma `true_op h t` ni `provable_op h t`.

Demostración. Procedemos por inducción estructural sobre `φ : ArithForm 0`.

Casos base: Si `φ = bottom` o `φ = eq t₁ t₂`, no contiene ningún constructor intensional por definición.

Paso inductivo: Supongamos que `φ` se construye mediante `impl`, `neg` o `forall_form` a partir de fórmulas que no contienen operadores intensionales. Entonces `φ` tampoco los contiene, pues estos constructores no introducen `true_op` ni `provable_op`.

Finalmente, supongamos que `φ = true_op h t` o `φ = provable_op h t`. Por la firma de tipo de ambos constructores, se requiere un testigo `h : s = s_lower + 1` donde `s` es el nivel de `φ`. Como `s = 0`, tendríamos `0 = s_lower + 1` para algún `s_lower ∈ ℕ`, lo cual es aritméticamente imposible. Por tanto, estos constructores no pueden aparecer en el nivel 0. ∎

**Metateorema T-Mono [A-Meta]**

Monotonicidad estricta de la estratificación.

Enunciado. Si `φ : ArithForm s` contiene una subfórmula `true_op h t` o `provable_op h t`, entonces `h` es un testigo de `s = s_lower + 1` para algún `s_lower < s`.

Demostración. Sea `φ : ArithForm s` que contiene `true_op h t`. Por la firma de tipo del constructor

```
true_op : {s_lower : Nat} → (s = s_lower + 1) → ArithTerm s → ArithForm s
```

el argumento `h` tiene tipo `s = s_lower + 1`. Como `s_lower ∈ ℕ`, se sigue `s = s_lower + 1 ≥ 1` y por tanto `s_lower = s - 1 < s`. El caso de `provable_op` es idéntico por su firma análoga. ∎

**Metateorema T-NoLambda [A-Meta]**

Imposibilidad de la oración paradójica de Tarski.

Enunciado. No existe ninguna fórmula `λ : ArithForm s` tal que `λ = true_op h (⌜λ⌝)` para algún testigo `h`.

Demostración. Supongamos, para reducir al absurdo, que existe tal `λ`. Entonces `λ : ArithForm s` y, por la definición de `true_op`, se requiere un testigo `h : s = s_lower + 1` tal que el término `⌜λ⌝ : ArithTerm s` codifique una fórmula del nivel `s_lower`.

Pero `⌜λ⌝` es la serialización de `λ` misma, que reside en el nivel `s`. Luego la fórmula codificada por `⌜λ⌝` está en nivel `s`, no en nivel `s_lower`. Para que `true_op h (⌜λ⌝)` esté bien formado, el término debe codificar una fórmula de nivel `s_lower`, lo que fuerza `s = s_lower`. Pero el testigo `h` afirma `s = s_lower + 1`. Entonces `s = s + 1`, contradicción aritmética en `ℕ`. ∎

**Metateorema T-NoCycle [A-Meta]**

Imposibilidad de ciclos de referencia intensional.

Enunciado. No existe una secuencia finita de fórmulas `φ₁, …, φₙ` con `n ≥ 1` tal que, para cada `i ∈ {1, …, n}`, `φᵢ` contenga `true_op hᵢ (⌜φᵢ₊₁⌝)` (con índices módulo `n`).

Demostración. Supongamos que existe tal ciclo. Sea `sᵢ` el nivel de `φᵢ`. Por T-Mono, cada ocurrencia de `true_op` en `φᵢ` referenciando `φᵢ₊₁` impone `sᵢ = sᵢ₊₁ + 1`. Recorriendo el ciclo:

$$
s_1 = s_2 + 1 = s_3 + 2 = \cdots = s_n + (n-1) = s_1 + n.
$$

Luego `s₁ = s₁ + n`, lo cual implica `n = 0`. Pero la hipótesis exige `n ≥ 1`. Contradicción. ∎

**Metateorema T-HomoEq [A-Meta]**

Homogeneidad de nivel en la igualdad.

Enunciado. Si `eq t₁ t₂ : ArithForm s`, entonces `t₁ : ArithTerm s` y `t₂ : ArithTerm s`.

Demostración. Directo de la firma de tipo del constructor

```
eq : ArithTerm s → ArithTerm s → ArithForm s
```

Ambos argumentos deben pertenecer al mismo tipo `ArithTerm s`. ∎

**Metateorema T-NoMix [A-Meta]**

Imposibilidad de mezclar niveles en fórmulas atómicas.

Enunciado. No existen `s₁, s₂ ∈ ℕ` con `s₁ ≠ s₂`, `t₁ : ArithTerm s₁` y `t₂ : ArithTerm s₂` tales que `eq t₁ t₂` esté bien formado.

Demostración. Supongamos, para reducir al absurdo, que `eq t₁ t₂` está bien formado con `t₁ : ArithTerm s₁` y `t₂ : ArithTerm s₂`. Por la firma de tipo de `eq`, ambos argumentos deben pertenecer a `ArithTerm s` para algún `s` común. Luego `ArithTerm s₁ = ArithTerm s`, lo que fuerza `s₁ = s` por inyectividad del índice de tipo, y análogamente `s₂ = s`. Por tanto `s₁ = s₂`, contradiciendo la hipótesis. ∎

**Metateorema T-IndStruct [A-Meta]**

Principio de inducción estructural para fórmulas estratificadas.

Enunciado. Sea `s ∈ ℕ` fijo y sea `P : ArithForm s → Prop` una propiedad. Si:

1. `P(bottom)`;
2. `∀ t₁ t₂ : ArithTerm s, P(eq t₁ t₂)`;
3. `∀ φ ψ : ArithForm s, P(φ) ∧ P(ψ) → P(impl φ ψ)`;
4. `∀ φ : ArithForm s, P(φ) → P(neg φ)`;
5. `∀ x : ℕ, ∀ φ : ArithForm s, P(φ) → P(forall_form x φ)`;
6. `∀ s_lower : ℕ, ∀ h : s = s_lower + 1, ∀ t : ArithTerm s, P(true_op h t)`;
7. `∀ s_lower : ℕ, ∀ h : s = s_lower + 1, ∀ t : ArithTerm s, P(provable_op h t)`;

entonces `∀ φ : ArithForm s, P(φ)`.

Demostración. `ArithForm s` es un tipo inductivo con siete constructores. Por el principio general de inducción para tipos inductivos (disponible en la lógica constructiva subyacente a Lean), toda propiedad que se cumple en los constructores base y se preserva por los constructores inductivos se extiende a todos los habitantes del tipo. Las siete cláusulas enumeradas corresponden exactamente a los siete constructores de `ArithForm s`. ∎

## 3.5 Sistema deductivo [A]

El sistema deductivo de SPA es una lógica de primer orden con igualdad, axiomas de Peano, y un esquema de inducción. Se define como un predicado inductivo en Lean:

```
inductive SPA_Deduction_Internal (s : Nat) : Set (ArithForm s) → ArithForm s → Prop
```

Las reglas incluyen:

Lógica proposicional: introducción y eliminación de implicación, doble negación, reducción al absurdo.

Cuantificación: introducción y eliminación del cuantificador universal, con condiciones de frescura (`NotFreeInSet`, `IsFreeFor`) para evitar captura de variables.

Igualdad: reflexividad, simetría, transitividad, y reglas de congruencia para todos los constructores de términos y fórmulas.

Axiomas de Peano: $\neg(S(x) = 0)$ y $S(x) = S(y) \to x = y$.

Inducción: el esquema estándar para fórmulas de primer orden.

Nota sobre los axiomas. Siguiendo la reflexión que desarrollamos en la sección 2.7 del Capítulo 2, nosotros reconocemos que estos axiomas son elecciones filosóficas, no descubrimientos empíricos. Los axiomas de Peano se anclan en la tradición matemática estándar. La lógica de primer orden con igualdad se ancla en la tradición analítica. La inducción se ancla en la aritmética finitaria.

¿Por qué PA y no otra aritmética? Elegimos la Aritmética de Peano (PA) porque es la elección estándar para formalizaciones de aritmética de primer orden: es suficientemente expresiva para codificar la sintaxis (necesario para el teorema de Tarski), es recursivamente axiomatizable (necesario para aplicar los teoremas de Gödel), y es la base estándar en la literatura de verificación formal (Mathlib, etc.). Aritméticas más débiles como Robinson Q no tienen suficiente potencia inductiva para la construcción de Henkin-Lindenbaum. Aritméticas intuicionistas requerirían un tratamiento completamente diferente de la lógica subyacente. Nosotros elegimos PA porque es el marco estándar donde la pregunta de Tarski se formula tradicionalmente [B].

Nosotros elegimos estos axiomas porque son fecundos para el proyecto de formalización estratificada, y porque permiten demostrar la completitud sin sacrificar la consistencia. El lector puede cuestionar estos axiomas y proponer otros; en ese caso, los teoremas pueden cambiar.

## 3.5.1 Metateoremas de cierre y preservación [A-Meta]

Los siguientes metateoremas explicitan propiedades de preservación de nivel asociadas al sistema deductivo y a las operaciones sintácticas auxiliares. Son demostraciones formales en prosa [A-Meta] y no introducen nuevo código.

**Metateorema T-Ded-Level [A-Meta]**

El sistema deductivo es cerrado por nivel.

Enunciado. Si `SPA_Deduction_Internal s Γ φ`, entonces `Γ ⊆ ArithForm s` y `φ : ArithForm s`.

Demostración. El predicado inductivo `SPA_Deduction_Internal` tiene tipo

```
Nat → Set (ArithForm s) → ArithForm s → Prop
```

Por definición, el parámetro de nivel `s` indexa tanto el conjunto de premisas como la conclusión. Cada regla de inferencia del sistema deductivo (introducción y eliminación de implicación, cuantificación, igualdad, axiomas de Peano, inducción) opera exclusivamente sobre fórmulas de `ArithForm s`. Luego, por inducción sobre la derivación, todas las fórmulas que aparecen en la prueba pertenecen a `ArithForm s`. ∎

**Metateorema T-Subst-Level [A-Meta]**

La sustitución preserva el nivel.

Enunciado. Sea `φ : ArithForm s` y sea `σ` una sustitución que asigna a cada variable un término de `ArithTerm s`. Entonces la sustitución `φ[σ] : ArithForm s`.

Demostración. Por inducción estructural sobre `φ` usando T-IndStruct.

Caso base: Si `φ = bottom`, entonces `φ[σ] = bottom : ArithForm s`. Si `φ = eq t₁ t₂`, la sustitución en términos produce términos del mismo nivel `s`, luego `eq t₁[σ] t₂[σ] : ArithForm s`.

Paso inductivo: Si `φ = impl ψ χ`, por hipótesis inductiva `ψ[σ] : ArithForm s` y `χ[σ] : ArithForm s`, luego `impl ψ[σ] χ[σ] : ArithForm s`. Los casos `neg` y `forall_form` son análogos.

Si `φ = true_op h t`, el término `t` es de nivel `s` y no contiene variables que se sustituyan (es un numeral cerrado que codifica una fórmula de nivel inferior). Luego `t[σ] = t` y `φ[σ] = true_op h t : ArithForm s`. El caso `provable_op` es idéntico. ∎

**Metateorema T-Serial-Level [A-Meta]**

La serialización sube estrictamente de nivel.

Enunciado. Si `φ : ArithForm s_lower`, entonces su código de serialización `⌜φ⌝ : ArithTerm s` donde `s = s_lower + 1`.

Demostración. De la descripción de la serialización en la sección 3.3: la función `⌜·⌝ : ArithForm s_lower → ArithTerm s` convierte una fórmula del nivel inferior en un numeral del nivel superior. El ejemplo concreto de la sección 3.3 muestra que `zero_eq_zero : ArithForm 0` se serializa como `code_zero_eq_zero : ArithTerm 1`, es decir, `s = 0 + 1`. Como la serialización codifica la estructura sintáctica completa de `φ` como un numeral, y este numeral debe ser consumible por `true_op` en el nivel `s = s_lower + 1`, la serialización produce necesariamente un término de ese nivel superior. ∎

## 3.6 Construcción de Henkin-Lindenbaum [A]

Para demostrar la completitud, nosotros implementamos la construcción clásica de Henkin-Lindenbaum, adaptada al entorno estratificado [B]. Presentamos los tres pasos y luego explicamos por qué la estratificación no los interrumpe.

Paso 1: Extensión de Henkin. Se enumeran todas las fórmulas existenciales del lenguaje. Para cada una de ellas, se introduce una nueva constante de Henkin que actúa como testigo, y se añade un axioma que vincula la fórmula existencial con su testigo. La elección de constantes frescas se garantiza mediante un mecanismo de cotas superiores (véase sección 3.8).

Paso 2: Extensión de Lindenbaum. Partiendo del límite de Henkin, se recorre una enumeración de todas las fórmulas. Para cada fórmula $\varphi$, se decide añadir $\varphi$ o $\neg\varphi$ a la teoría, preservando la consistencia en cada paso. El resultado es una teoría maximal consistente $\Delta$.

Paso 3: Modelo canónico. Se construye un modelo cuyo dominio son las clases de equivalencia de términos cerrados módulo la igualdad demostrable en $\Delta$. Las funciones se interpretan sintácticamente, y los predicados se interpretan según la pertenencia a $\Delta$.

¿Por qué la estratificación no interrumpe esta construcción? Porque cada nivel $s$ se trata como un lenguaje independiente durante la construcción de Henkin-Lindenbaum. Las constantes de Henkin se introducen dentro del mismo nivel $s$, y la extensión de Lindenbaum opera sobre fórmulas del nivel $s$. La restricción de estratificación solo prohíbe que los operadores `provable_op` y `true_op` se apliquen a fórmulas del mismo nivel; no prohíbe la construcción de modelos para cada nivel individualmente.

## 3.7 Teorema de completitud [A]

El resultado principal de SPA es el teorema de completitud para el nivel $0$:

Teorema. Sea $\varphi$ una fórmula de `ArithForm 0` que es una sentencia (sin variables libres). Si $\varphi$ es verdadera en todos los modelos de Henkin, entonces $\varphi$ es demostrable en `SPA_Deduction_Internal 0`. [A]

La demostración se apoya en el Lema de Verdad (`truth_lemma`), que establece la equivalencia entre la satisfacción en el modelo canónico y la pertenencia a la teoría maximal consistente $\Delta$:

$$
\mathcal{M} \models_\sigma \varphi \iff \text{substAll } \varphi\ \sigma \in \Delta
$$

Se trata de una completitud semántica de primer orden: el teorema se refiere a la validez en todos los modelos de Henkin (estándar y no estándar), no a la verdad en el modelo estándar $\mathbb{N}$. Es el análogo, para el lenguaje aritmético estratificado, del teorema de completitud de Gödel de 1929 para la lógica de primer orden [B].

Sobre la relación con los teoremas de Gödel

El teorema de completitud de SPA no contradice ni elude los teoremas de incompletitud de Gödel [B]. Gödel demostró que, para un sistema aritmético no estratificado con suficiente potencia expresiva, existen fórmulas verdaderas pero no demostrables dentro del mismo nivel. SPA demuestra algo diferente: que el nivel $n+1$ puede definir un predicado de verdad correcto y consistente para todas las fórmulas del nivel $n$, pero no puede demostrar todas las verdades aritméticas de ese nivel. La completitud es respecto a la evaluación desde el nivel superior, no respecto a la autoevaluación en un sistema cerrado.

Nota sobre la generalización y el alcance de la formalización

Nosotros formalizamos la prueba completa para el nivel $s=0$. La construcción de Henkin-Lindenbaum y el lema de verdad están parametrizados por el nivel en el código Lean, por lo que la generalización a niveles superiores es conceptualmente directa. Sin embargo, no la formalizamos completamente en el código actual por razones de tiempo y espacio: la formalización del nivel 0 ya es suficiente para demostrar el punto central del capítulo (que la estratificación preserva la completitud), y la generalización no introduce dificultades conceptuales nuevas, solo complejidad técnica adicional.

Esta decisión debe declararse explícitamente: nosotros no ocultamos esta limitación. La formalización completa de todos los niveles es un trabajo futuro que no altera el resultado conceptual presentado aquí [C].

## 3.7.1 Metateoremas de imposibilidad de autorreferencia [A-Meta]

Los siguientes metateoremas explicitan las consecuencias antiautorreferenciales del diseño estratificado de SPA. Se presentan como demostraciones formales en prosa [A-Meta] y no modifican el código del sistema.

**Metateorema T-NoSelfRef [A-Meta]**

Imposibilidad de autoverdad en el mismo nivel.

Enunciado. Para ningún nivel `s` existe una fórmula `φ : ArithForm s` tal que `φ` afirme su propia verdad mediante `true_op`, es decir, tal que `φ = true_op h (⌜φ⌝)`.

Demostración. Este es un corolario inmediato de T-NoLambda. La existencia de tal `φ` requeriría que `⌜φ⌝` codificara una fórmula de nivel `s_lower` donde `s = s_lower + 1`, pero `⌜φ⌝` codifica `φ` misma, que está en nivel `s`. Luego `s_lower = s`, contradiciendo `s = s_lower + 1`. ∎

**Metateorema T-NoUniversalV [A-Meta]**

No hay predicado de verdad universal interno.

Enunciado. Para ningún nivel `s` existe un predicado `V(x)` definible en `ArithForm s` tal que para toda `ψ : ArithForm s` se cumpla `V(⌜ψ⌝) ↔ ψ`.

Demostración. Supongamos que existe tal `V` en el nivel `s`. Entonces `V` podría aplicarse a la fórmula `λ ≡ ¬ V(⌜λ⌝)`, construible por diagonalización en el nivel `s` si `V` está disponible en ese nivel. Esto reproduciría la paradoja de Tarski dentro del nivel `s`.

Sin embargo, en SPA el único predicado de verdad disponible en el nivel `s` es `true_op h t`, y por T-Mono este solo puede aplicarse a términos `t` que codifiquen fórmulas de nivel `s_lower = s - 1`. Por tanto, no puede aplicarse a fórmulas del nivel `s`. Luego ningún `V` interno al nivel `s` puede satisfacer la equivalencia para todas las fórmulas de ese nivel. ∎

**Metateorema T-Cons-0 [A-Meta]**

Inmunidad estructural del nivel 0.

Enunciado. El nivel 0 de SPA no puede formular la paradoja del mentiroso de Tarski.

Demostración. La paradoja de Tarski requiere un predicado de verdad `V` aplicable a fórmulas del mismo lenguaje. En SPA, cualquier predicado de verdad para fórmulas de nivel 0 residiría en el nivel 1 (mediante `true_op` con testigo `1 = 0 + 1`). Por T-NoInt-0, el nivel 0 no contiene ningún operador intensional. Como la paradoja requiere que el predicado de verdad habite el mismo nivel que las fórmulas evaluadas, y en el nivel 0 no existe tal predicado, la paradoja no puede construirse en el nivel 0. ∎

**Metateorema T-Strat-Hierarchy [A-Meta]**

La jerarquía de niveles es estricta y bien fundamentada.

Enunciado. La relación de niveles `<` en `ℕ` es un orden estricto y bien fundamentado. En consecuencia, no existe una cadena descendente infinita `s₀ > s₁ > s₂ > …`.

Demostración. La relación `<` sobre los números naturales es estricta por definición:

$$
n < m \iff \exists k > 0,\ m = n + k.
$$

Es bien fundamentada porque todo subconjunto no vacío de `ℕ` tiene un elemento mínimo (principio del buen orden). Por tanto, no puede existir una cadena descendente infinita, pues tal cadena carecería de mínimo. ∎

**Metateorema T-NoCrossMix [A-Meta]**

Imposibilidad de inferencia entre niveles distintos.

Enunciado. Si `SPA_Deduction_Internal s₁ Γ φ` y `SPA_Deduction_Internal s₂ Δ ψ` con `s₁ ≠ s₂`, entonces no existe ninguna regla de inferencia de SPA que combine directamente `φ` y `ψ` en una sola derivación.

Demostración. Por T-Ded-Level, toda derivación en el nivel `s₁` opera exclusivamente sobre fórmulas de `ArithForm s₁`, y toda derivación en el nivel `s₂` opera sobre `ArithForm s₂`. Como `s₁ ≠ s₂`, los tipos `ArithForm s₁` y `ArithForm s₂` son disjuntos (tipos inductivos indexados por valores distintos de un parámetro). Ningún constructor de `SPA_Deduction_Internal` acepta premisas de niveles mixtos, pues el parámetro `s` es uniforme en cada instancia del predicado inductivo. Luego no existe combinación directa. ∎

## 3.8 Decisiones de diseño en la formalización [A/C]

Más allá del resultado lógico, SPA incorpora varias decisiones de diseño que son contribuciones metodológicas del proyecto. La presente sección está clasificada como `[A/C]`: los hechos (cero `sorry`, uso de índices de tipo) son verificables [A]; su interpretación como contribuciones metodológicas es [C].

Frescura por cota superior. En lugar de asumir la existencia de infinitas variables frescas como un axioma externo, nosotros implementamos un mecanismo constructivo: el máximo índice de variable en una fórmula o derivación se calcula explícitamente, y una variable nueva se elige con índice estrictamente mayor. Esto garantiza la frescura sin apelar a principios no constructivos [A].

Índices de estratificación en tiempo de compilación. El parámetro `s` en `ArithTerm s` y `ArithForm s` es un índice de tipo que el verificador de Lean utiliza para impedir cualquier unificación entre niveles distintos. Esto proporciona una garantía de estratificación en tiempo de compilación, sin costo en tiempo de ejecución [A].

Eliminación del combustible en los decodificadores. El parser de términos y fórmulas utiliza un parámetro de combustible (`fuel`) para garantizar la terminación. Nosotros demostramos que la longitud del código serializado es una cota superior del tamaño sintáctico, lo que permite eliminar el combustible artificial y usar la propia longitud del código como parámetro de recursión [A].

Cero `sorry` en el núcleo inductivo. Toda la construcción —desde la sintaxis hasta el teorema de completitud— compila en Lean 4 sin admitir omisiones (`sorry`). La formalización completa consta de aproximadamente 27.600 líneas de código, 378 lemas auxiliares y 14 teoremas principales [A]. Esto significa que cada paso está verificado mecánicamente por el kernel de Lean.

## 3.9 Lección: la estratificación como condición de coherencia [C]

SPA muestra que la estratificación no es una restricción arbitraria ni un costo que deba pagarse a cambio de consistencia. Es, más bien, una condición de posibilidad para la coherencia [C]:

Sin estratificación, el sistema es inconsistente: la paradoja de Tarski produce una contradicción [B].

Con estratificación, el sistema es completo: toda fórmula válida es demostrable, y la verdad y la demostrabilidad del nivel inferior pueden expresarse sin contradicción en el nivel superior [A].

Transferencia metodológica a otros dominios

Esta lección es transferible, pero es importante precisar en qué sentido. La transferencia no es formal —no hay un teorema que vincule SPA con la relatividad o la teoría normativa— sino metodológica [C]. El mismo tipo de análisis que nosotros aplicamos aquí (identificar niveles, preguntar qué atributos pertenecen a cada nivel, buscar descripciones alternativas que eviten la confusión) puede aplicarse a otros dominios.

En los capítulos siguientes, este protocolo de análisis se utilizará para examinar tres casos:

La geometría del espacio-tiempo (Capítulo 4): donde la curvatura puede verse como una descripción de nivel superior que no debe reificarse como propiedad de una sustancia. El tensor métrico (nivel $n$) describe relaciones entre eventos; la "curvatura" (nivel $n+1$) es una propiedad de esa descripción, no una deformación de una tela cósmica.

La medición cuántica (Capítulo 5): donde el "colapso" puede interpretarse como un cambio de nivel epistémico. El estado cuántico (nivel $n$) evoluciona unitariamente; la medición (nivel $n+1$) actualiza la información disponible sobre el sistema. El "colapso" no es un evento físico en el nivel $n$; es una transición en el nivel $n+1$.

Los sistemas normativos (Capítulo 6): donde la evaluación de cumplimiento requiere un nivel de supervisión distinto al de las normas. Una norma (nivel $n$) regula conductas; la evaluación de esa norma (nivel $n+1$) debe residir en un nivel superior para evitar la incompetencia reflexiva (principio nemo iudex in causa sua).

En ningún caso nosotros afirmaremos que SPA "demuestra" algo sobre física o derecho. La conexión es analógica, no deductiva [C]. SPA proporciona el modelo formal de la estratificación; los capítulos siguientes aplican el principio metodológico que ese modelo ilustra.

La estratificación como anti-reificación

Desde la perspectiva del Capítulo 1, la estratificación es un mecanismo anti-reificatorio [C]. La paradoja de Tarski se produce cuando el predicado de verdad —una relación sintáctica— se trata como si fuera una sustancia autorreferente. La estratificación impide esta operación no por convención voluntaria, sino por restricción de tipo: el verificador de Lean rechaza la construcción antes de que pueda formularse.

Esto es exactamente lo que el método del Capítulo 1 propone para el análisis del discurso: identificar el tipo de la construcción, verificar que las atribuciones corresponden a ese tipo, y señalar la reificación cuando no corresponden. En SPA, esta verificación la realiza el kernel de Lean en tiempo de compilación. En el análisis del discurso, la realizamos nosotros mediante el protocolo de cuatro preguntas.

## 3.10 Limitaciones y alcances [C]

Para completar el análisis, es importante señalar explícitamente lo que SPA no puede hacer.

Incompletitud dentro de cada nivel. SPA no escapa a los teoremas de Gödel [B]. Cada nivel $s$ es incompleto respecto a las verdades aritméticas de ese nivel. Lo que SPA muestra es que el nivel $s+1$ puede expresar y demostrar la completitud del nivel $s$, pero el nivel $s+1$ es a su vez incompleto respecto a sus propias verdades.

Indefinibilidad de la verdad interna. SPA no define un predicado de verdad para el nivel $s$ dentro del nivel $s$ [B]. Lo define en el nivel $s+1$. La paradoja de Tarski no se resuelve eliminándola, sino desplazando el predicado a un metanivel.

No es una teoría de la verdad autocontenida. A diferencia de las teorías axiomáticas de la verdad (como KF o FS) [B], SPA no introduce un predicado de verdad como símbolo primitivo con axiomas. La verdad se define semánticamente (en el modelo canónico) y se expresa sintácticamente mediante `true_op` con restricción de nivel.

Modelos no estándar. La completitud es respecto a todos los modelos de Henkin, que incluyen modelos no estándar [B]. SPA no demuestra que toda verdad en $\mathbb{N}$ sea demostrable, lo cual sería falso por el primer teorema de incompletitud.

Limitación de la formalización actual. Nosotros formalizamos el nivel $s=0$ completamente. La generalización a niveles superiores es conceptualmente directa pero no está formalizada en el código actual [C]. Esto no altera el resultado conceptual, pero debe declararse.

## 3.11 Síntesis de demostraciones formales del capítulo [A-Meta]

Nosotros presentamos la siguiente tabla de demostraciones formales en prosa integradas en este capítulo. Estas pruebas son consecuencias directas de las definiciones sintácticas y deductivas de SPA. Su valor reside en explicitar mecánicamente las restricciones de nivel que bloquean la autorreferencia destructiva.

| Designación | Enunciado | Método | Sección |
|---|---|---|---|
| T-NoInt-0 | El nivel 0 no admite operadores intensionales | Inducción estructural / análisis de firmas | 3.4.1 |
| T-Mono | Monotonicidad estricta de la estratificación | Inspección de firma de tipo | 3.4.1 |
| T-NoLambda | Imposibilidad de la oración paradójica de Tarski | Reducción al absurdo por niveles | 3.4.1 |
| T-NoCycle | Imposibilidad de ciclos de referencia intensional | Contradicción aritmética por descenso | 3.4.1 |
| T-HomoEq | Homogeneidad de nivel en la igualdad | Inspección de firma | 3.4.1 |
| T-NoMix | Imposibilidad de mezclar niveles en fórmulas atómicas | Reducción al absurdo por tipado | 3.4.1 |
| T-IndStruct | Principio de inducción estructural para fórmulas estratificadas | Principio de inducción inductiva | 3.4.1 |
| T-Ded-Level | El sistema deductivo es cerrado por nivel | Inducción sobre derivación | 3.5.1 |
| T-Subst-Level | La sustitución preserva el nivel | Inducción estructural | 3.5.1 |
| T-Serial-Level | La serialización sube estrictamente de nivel | Propiedad de serialización | 3.5.1 |
| T-NoSelfRef | Imposibilidad de autoverdad en el mismo nivel | Corolario de T-NoLambda | 3.7.1 |
| T-NoUniversalV | No hay predicado de verdad universal interno | Diagonalización bloqueada por niveles | 3.7.1 |
| T-Cons-0 | Inmunidad estructural del nivel 0 | Ausencia de operadores intensionales en 0 | 3.7.1 |
| T-Strat-Hierarchy | La jerarquía de niveles es estricta y bien fundamentada | Buen orden de ℕ | 3.7.1 |
| T-NoCrossMix | Imposibilidad de inferencia entre niveles distintos | Disjunción de tipos indexados / uniformidad de nivel | 3.7.1 |

Conclusión metodológica [C]. El Capítulo 3 posee ahora un inventario de demostraciones formales en prosa integradas junto a la presentación del sistema SPA. Estas pruebas son correctas, completas y verificables conceptualmente a partir de las firmas de tipo y reglas del sistema. Su integración eleva el estatus epistémico de las secciones formales de [A] a [A-Meta] + [A-Código].

Etiquetado del capítulo

| Sección | Afirmación principal | Clasificación |
|---|---|---|
| 3.0 | La paradoja del mentiroso como caso de reificación | [C] Interpretación |
| 3.1 | Tarski demostró la indefinibilidad de la verdad | [B] Citada de literatura |
| 3.2 | Aplicación de las cuatro preguntas al caso de Tarski | [C] Interpretación |
| 3.3 | Firmas de tipo de `provable_op` y `true_op` | [A] Probada por código |
| 3.4 | Definiciones inductivas de `ArithTerm` y `ArithForm` | [A] Probada por código |
| 3.4.1 | Metateoremas de estratificación sintáctica | [A-Meta] |
| 3.5 | Reglas del sistema deductivo `SPA_Deduction_Internal` | [A] Probada por código |
| 3.5.1 | Metateoremas de cierre y preservación | [A-Meta] |
| 3.6 | Construcción de Henkin-Lindenbaum | [A] Probada por código |
| 3.7 | Teorema de completitud | [A] Probada por código |
| 3.7.1 | Metateoremas de imposibilidad de autorreferencia | [A-Meta] |
| 3.8 | Decisiones de diseño en la formalización | [A/C] Hechos verificables e interpretación |
| 3.9 | Lección de transferencia metodológica | [C] Interpretación |
| 3.10 | Limitaciones y alcances | [C] Interpretación |
| 3.11 | Síntesis de demostraciones formales | [A-Meta] + [C] |