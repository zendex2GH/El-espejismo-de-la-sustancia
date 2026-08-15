
# Capítulo 6: La reificación de la conjunción en la recepción del teorema de Bell: axiomática, interpretación y reificación

## 6.0 Introducción: Bell es correcto, pero la recepción estándar extrae una conclusión más fuerte de lo que su demostración autoriza [C]

En el Capítulo 5, nosotros formalizamos la medición cuántica como cambio de nivel epistémico y mapeamos, mediante Z3, las siete interpretaciones viables que surgen al renunciar a al menos uno de los tres supuestos metafísicos del teorema de Bell (Localidad, Definición Contracausal, Independencia Estadística). En este capítulo, nosotros aislamos y formalizamos con precisión quirúrgica la operación lógica específica que opera en la recepción pedagógica y divulgativa estándar del teorema de Bell: la inferencia de que Bell “refutó el realismo local” cuando, estrictamente, Bell refutó una conjunción específica de tres supuestos separables bajo una estructura probabilística particular.

Debemos ser absolutamente claros desde el inicio sobre el alcance de nuestra crítica:

Lo que NO cuestionamos:

El desarrollo matemático de Bell es impecable. La derivación algebraica que conduce a la cota $|S| \le 2$ bajo la hipótesis de distribución conjunta es correcta.

Los datos experimentales de Aspect (1982), Weihs (1998) y Hensen (2015) confirman $S \approx 2{,}828$, violando esa cota [B].

Bell mismo fue cuidadoso en sus escritos (Bell 1964, 1981): su teorema refuta las teorías de variables ocultas locales bajo su definición específica [B].

Lo que SÍ cuestionamos:

La recepción pedagógica y divulgativa estándar opera mediante dos movimientos que este capítulo analiza:

Primero, la elisión axiomática. La recepción estándar trata como evidente que el realista local está forzado a formalizar los resultados de los detectores mediante una distribución de probabilidad conjunta $P(A, A', B, B')$ sobre las cuatro variables simultáneas. Esta asunción equivale, por el teorema de Fine (1982), a la Definición Contracausal (CFD): los experimentos no realizados tienen resultados definidos [B]. La recepción estándar presenta esta estructura como consecuencia necesaria del realismo local, cuando en realidad es un supuesto adicional separable.

Segundo, la totalización de la conjunción. La recepción estándar interpretó $\neg(R \wedge L \wedge DC)$ como $\neg(R \wedge L)$. Esa inferencia solo es válida si se acepta el lema adicional $(R \wedge L) \rightarrow DC$. Sin ese lema, la conclusión correcta es simplemente: “la conjunción de estos tres supuestos bajo esta estructura probabilística es insostenible”, no “el realismo y la localidad son insostenibles”.

Importante: Si se adopta la definición estándar de “realismo local” que Bell y EPR usaron (donde la CFD es constitutiva del realismo, no un supuesto separable), entonces el teorema de Bell SÍ refuta válidamente esa posición, y la inferencia de la recepción estándar es lógicamente correcta. Lo que este capítulo denuncia no es una falacia lógica formal en ese caso, sino una falacia pedagógica de totalización: presentar la conjunción $R \wedge L \wedge CFD$ como bloque monolítico (“el realismo local”), ocultando que CFD es un supuesto separable y que otras definiciones de realismo (como el realismo mínimo que adoptamos aquí) permiten preservar localidad sin CFD.

La reificación aquí opera exactamente como en los capítulos anteriores: se trata una conjunción de tres supuestos separables como si fuera una hipótesis unitaria e inseparable, y al refutar uno de sus componentes (CFD), se transfiere erróneamente la refutación a los otros dos (R y L).

Declaración de alcance. Este capítulo no propone un modelo físico alternativo que explique las correlaciones cuánticas desde primeros principios. Lo que hacemos es analizar la estructura lógica del argumento de Bell y de su recepción estándar, y mostrar, mediante formalización en Z3 y simulación en Clingo, que el espacio de posibilidades interpretativas es más amplio de lo que la narrativa estándar sugiere.

Nota sobre el tono. Este capítulo no “destruye” a Bell. Lo acota, y sobre todo acota a su recepción estándar. La contribución de Bell es enorme: mostró que la conjunción de esos tres supuestos bajo estructura clásica es insostenible. Nuestro aporte es mostrar que la conjunción no es una unidad indivisible, y que la recepción estándar reificó esa conjunción al presentarla como una sola hipótesis.

---

## 6.1 Aplicación del protocolo al teorema de Bell [C]

Aplicamos las cuatro preguntas del Capítulo 0 al caso del teorema de Bell y su recepción estándar.

Pregunta 1: ¿Cuál es el objeto formal y cuál es su tipo?

El objeto formal es la conjunción $R \wedge L \wedge CFD$ como estructura lógica compuesta. Su tipo real es: conjunción de tres supuestos independientes. No es una hipótesis unitaria; es una tríada separable donde cada componente puede ser afirmado o negado independientemente de los otros dos.

En el formalismo de Bell (1964), esta conjunción se expresa mediante:

Realismo (R): Las partículas poseen propiedades definidas independientemente de ser medidas. Los detectores revelan, no inventan.

Localidad (L): La elección de eje de medición en Alice no altera instantáneamente el resultado en Bob. No-señalización.

CFD (Definición Contracausal): Los experimentos no realizados tienen resultados definidos. Es decir, $A$ y $A'$ existen simultáneamente.

Estos tres supuestos son lógicamente independientes: se puede afirmar uno sin afirmar los otros. La conjunción es una estructura relacional entre proposiciones, no una sustancia unitaria.

Pregunta 2: ¿Qué atribuye la narrativa a este objeto que su tipo no contiene?

La narrativa estándar (recepción pedagógica y divulgativa) atribuye a la conjunción $R \wedge L \wedge CFD$ propiedades de hipótesis unitaria e inseparable:

“Bell demostró que el realismo local es falso” (totalización: trata la conjunción como bloque monolítico).

“La naturaleza es no-local” (inferencia inválida: de $\neg(R \wedge L \wedge CFD)$ se infiere $\neg L$, ignorando que la CFD podría ser el componente refutado).

“Einstein estaba equivocado” (personificación + simplificación: reduce un programa de investigación a una persona).

“No hay variables ocultas locales” (naturalización: presenta la ausencia de un tipo específico de modelo como ausencia de toda posibilidad realista).

Estas atribuciones requieren tratar la conjunción como una sustancia con identidad propia, algo que puede ser “refutado” en bloque. Pero el tipo real de la conjunción es una estructura relacional entre tres proposiciones separables. Hay un mismatch de tipo. Eso es la reificación.

Los procesos satélite que operan aquí son:

Totalización: Borrar la heterogeneidad interna de la conjunción, presentándola como “el realismo local” sin distinguir sus componentes.

Naturalización: Presentar el lema $(R \wedge L) \rightarrow CFD$ como si fuera una consecuencia lógica inevitable en lugar de una elección axiomática de la recepción estándar.

Sacralización: Elevar el teorema de Bell a un estatus intocable que bloquea la revisión de sus premisas.

Pregunta 3: ¿Existe una descripción alternativa sin ese atributo?

Sí. Existe una descripción donde la conjunción se presenta como lo que es: tres supuestos separables, cada uno con su propio estatus.

La descripción alternativa es el realismo contextual: un realismo mínimo donde los detectores no inventan los resultados (el resultado medido es real, no un artefacto del aparato), pero donde no se postulan valores simultáneos para mediciones no realizadas. Formalmente, esto equivale a:

$R = \text{true}$ (los detectores no inventan)

$L = \text{true}$ (no-señalización)

$CFD = \text{false}$ (no hay valores definidos para mediciones no realizadas)

Modelo estadístico: cuatro distribuciones separadas $P_{ab}$, $P_{ab'}$, $P_{a'b}$, $P_{a'b'}$, una por sub-experimento, sin distribución conjunta global.

Esta posición tiene anclaje en la literatura: Pitowsky (1989) demostró que las desigualdades de Bell son teoremas de la probabilidad clásica, no de la localidad [B]. Fine (1982) demostró la equivalencia CFD $\Leftrightarrow$ Distribución Conjunta [B]. Spekkens (2005) desarrolló modelos contextuales que preservan realismo y localidad [B].

Pregunta 4: ¿Es teoría resuelta con narrativa sucia?

Sí. El teorema de Bell es una teoría resuelta: la derivación algebraica es correcta, las predicciones están confirmadas experimentalmente con precisión extraordinaria, y hay consenso sobre los datos. Lo que está “sucio” es la narrativa que lo envuelve en su recepción estándar: la afirmación “Bell refutó el realismo local” cuando estrictamente Bell refutó $R \wedge L \wedge CFD$.

La narrativa sucia opera mediante totalización: presenta la conjunción como si fuera una hipótesis unitaria, y al refutarla, transfiere la refutación a todos sus componentes simultáneamente. El formalismo es sólido; la interpretación estándar de la recepción es la capa reificada.

---

## 6.2 Formalización en Z3: la estructura lógica de la elisión axiomática [A-Meta] + [A-Código]

Nosotros construimos un sistema formal en Z3 que captura la estructura lógica de la elisión axiomática en la recepción estándar del teorema de Bell. El sistema no modela la física cuántica; modela la estructura argumentativa del teorema y sus premisas ocultas.

Las demostraciones en prosa [A-Meta] se presentan junto con las verificaciones computacionales [A-Código]. Las pruebas en prosa no son reemplazadas por el código; el código verifica instancias concretas y controla errores de tipeo.

---

### 6.2.1 Ontología formal: tres niveles de compromiso

El sistema distingue tres niveles de compromiso:

Nivel ontológico (compromisos sobre la naturaleza de la realidad):

```lisp
; Realismo (R) = REALISMO MÍNIMO: los detectores revelan, no inventan.
; NO incluye CFD. Es la afirmación de que el resultado medido es real,
; no un artefacto del aparato. No afirma que las mediciones NO realizadas
; tengan valores definidos simultáneamente.
(declare-const Realism Bool)

; Localidad (L): la elección de eje de medición en Alice no altera
; instantáneamente el resultado en Bob. No-señalización.
(declare-const Locality Bool)

; Definición Contracausal (CFD): los experimentos no realizados
; tienen resultados definidos. Es decir, A y A' existen simultáneamente.
; Nota: Fine (1982) demostró que CFD ⇔ Distribución Conjunta.
(declare-const CFD Bool)

; Distribución Conjunta Clásica (DC): existe una única medida de
; probabilidad P(A, A', B, B') sobre las 4 variables simultáneas.
(declare-const JointDist Bool)
```

Nivel epistemológico (el terreno neutral del estadístico):

```lisp
; FourSubexperiments: los datos provienen de 4 corridas físicamente
; distintas. En cada una solo se miden 2 observables, nunca 4.
(declare-const FourSubexperiments Bool)

; OnlyDetectorData: el estadístico solo tiene acceso a los registros
; de los medidores (+1/-1), no a "propiedades subyacentes".
(declare-const OnlyDetectorData Bool)
```

Nivel metodológico (elecciones del modelado estadístico):

```lisp
; StatisticianImposesJoint: el estadístico postula una distribución
; conjunta P(A,A',B,B') como modelo subyacente.
; NOTA: esto es una ELECCIÓN DE MODELO, no una consecuencia de los datos.
(declare-const StatisticianImposesJoint Bool)

; StatisticianUsesContextual: el estadístico usa 4 distribuciones
; separadas P_ab, P_ab', P_a'b, P_a'b', una por sub-experimento.
(declare-const StatisticianUsesContextual Bool)
```

Parámetro empírico:

```lisp
(declare-const S_value Real)
```

---

### 6.2.2 Axiomas del sistema formal

```lisp
; AXIOMA 1 (Metodológico): Si los datos provienen de 4 experimentos
; separados y solo observamos detectores, no hay base empírica para
; postular una distribución conjunta sobre 4 variables no medidas
; simultáneamente.
(assert (! (=> (and FourSubexperiments OnlyDetectorData)
               (not StatisticianImposesJoint))
         :named A1_NoEmpiricalBasisForJoint))

; AXIOMA 2 (Elección de Bell): Bell identificó su modelo formal con
; el realismo local. Pero JointDist es una elección metodológica,
; no una consecuencia ontológica.
(assert (! (= JointDist StatisticianImposesJoint)
         :named A2_JointIsMethodologicalChoice))

; AXIOMA 3 (Teorema de Fine): CFD es matemáticamente equivalente
; a la existencia de una distribución de probabilidad conjunta.
(assert (! (= CFD JointDist)
         :named A3_Fine_Equivalence))

; AXIOMA 5 (Teorema de Bell, matemáticamente correcto):
; Si se acepta Realismo ∧ Localidad ∧ DistribuciónConjunta,
; entonces necesariamente |S| ≤ 2.
(assert (! (=> (and Realism Locality JointDist) (<= S_value 2.0))
         :named A5_CHSH_Correct))

; AXIOMA 6 (Dato experimental): Aspect, Weihs, Hensen et al.
(assert (! (= S_value 2.828) :named A6_Experimental_Data))

; POSTULADO DE VIABILIDAD (verificado algebraicamente en 6.2.4):
; Un realista local que renuncia a la Distribución Conjunta puede usar
; un modelo contextual que es lógicamente compatible con S = 2.828.
; NOTA: Este postulado se verifica como consistencia algebraica en la 
; Sección 6.2.4 mediante el script contextual_model_z3.smt2.
(assert (! (=> (and Realism Locality StatisticianUsesContextual)
               (and (not JointDist) (= S_value 2.828)))
         :named A7_ContextualRealism_FitsData))

; AXIOMA 8 (Exclusión metodológica): el estadístico o impone
; distribución conjunta o usa modelo contextual, no ambos.
(assert (! (xor StatisticianImposesJoint StatisticianUsesContextual)
         :named A8_MutualExclusion))
```

---

### 6.2.3 El lema de la recepción estándar como definición, no como axioma global

Esta es la decisión metodológica más importante del script. El lema que la recepción estándar asume implícitamente —que el realismo y la localidad implican la CFD— se define como proposición pero no se aserta globalmente. Se invoca selectivamente para mostrar su efecto destructivo:

```lisp
; La recepción estándar asume implícitamente que Realismo ∧ Localidad
; implica CFD. Por Fine (A3), esto equivale a imponer Distribución Conjunta.
; Definimos A4 como proposición, pero NO lo asertamos globalmente.
(declare-const A4_Reception_Fallacious_Lemma Bool)
(assert (! (= A4_Reception_Fallacious_Lemma (=> (and Realism Locality) CFD))
         :named A4_Definition))
```

Nota sobre los axiomas. Siguiendo la reflexión del Capítulo 2 (sección 2.7), nosotros reconocemos que el Axioma 1 es una elección filosófica, no un descubrimiento empírico. Se ancla en el empirismo metodológico: los datos de cuatro sub-experimentos separados no fuerzan una distribución conjunta sobre variables no medidas simultáneamente. Esta es una posición defendible pero no es una verdad lógica necesaria. El lector puede cuestionar esta elección; en ese caso, los teoremas cambian.

Nota sobre la elección de Z3. Z3 es la herramienta adecuada porque el problema es de satisfacibilidad (¿existe un modelo donde $R \wedge L$ sea consistente con $S = 2{,}828$?), no de demostración deductiva pura. Z3 produce modelos concretos o núcleos insatisfacibles, que es exactamente lo que necesitamos.

---

### 6.2.4 Verificación algebraica del modelo contextual [A-Meta] + [A-Código]

El Postulado de Viabilidad (A7) afirma que existe un modelo contextual compatible con los datos. Para verificar esto, construimos un script Z3 que verifica la consistencia algebraica de las correlaciones cuánticas.

Definición 6.2.4 (Modelo Contextual Realista-Local). Un Modelo Contextual $\mathcal{M}_{ctx}$ para el experimento EPRB-CHSH es una tupla de cuatro espacios de probabilidad clásicos separados, uno por sub-experimento:

$$
\mathcal{M}_{ctx} = \left\{ (\Omega_{ab}, \mathcal{F}_{ab}, P_{ab}, A_{ab}, B_{ab}), (\Omega_{ab'}, \mathcal{F}_{ab'}, P_{ab'}, A_{ab'}, B_{ab'}), (\Omega_{a'b}, \mathcal{F}_{a'b}, P_{a'b}, A_{a'b}, B_{a'b}), (\Omega_{a'b'}, \mathcal{F}_{a'b'}, P_{a'b'}, A_{a'b'}, B_{a'b'}) \right\}
$$

donde para cada par de orientaciones $(x,y) \in \{(a,b), (a,b'), (a',b), (a',b')\}$:

$(\Omega_{xy}, \mathcal{F}_{xy}, P_{xy})$ es un espacio de probabilidad clásico.

$A_{xy}: \Omega_{xy} \to \{-1, +1\}$ y $B_{xy}: \Omega_{xy} \to \{-1, +1\}$ son variables aleatorias.

Localidad contextual: $P_{xy}(A_{xy}=u, B_{xy}=v) = P_{xy}(A_{xy}=u) \cdot P_{xy}(B_{xy}=v)$ para todo $u,v \in \{-1,+1\}$. Dentro de cada sub-experimento, los resultados son estadísticamente independientes.

Realismo mínimo: Para cada $\omega \in \Omega_{xy}$, los valores $A_{xy}(\omega)$ y $B_{xy}(\omega)$ existen independientemente de los detectores. Los detectores revelan, no inventan.

Ajuste empírico: $E_{xy} = \int_{\Omega_{xy}} A_{xy}(\omega) B_{xy}(\omega) dP_{xy}(\omega) = -\cos(\theta_x - \theta_y)$.

No existencia de distribución conjunta: No se postula ningún espacio $(\Omega, \mathcal{F}, P)$ ni variables $A, A', B, B'$ definidas simultáneamente sobre $\Omega$ tales que las cuatro distribuciones $P_{xy}$ sean marginales de $P$.

Verificación algebraica (Teorema 6.2.5). El script `contextual_model_z3.smt2` verifica que las cuatro correlaciones cuánticas predichas por la regla de Born ($E_{ab} = -\sqrt{2}/2$, $E_{ab'} = +\sqrt{2}/2$, $E_{a'b} = -\sqrt{2}/2$, $E_{a'b'} = -\sqrt{2}/2$) son mutuamente consistentes como números reales y satisfacen $S_{ctx} = -2\sqrt{2} \approx -2{,}828$, violando la cota CHSH clásica $|S| \le 2$.

Resultados verificados del script contextual_model_z3.smt2:

Z3 devuelve `sat` con el siguiente modelo algebraico:

| Símbolo Z3 | Expresión root-obj | Valor exacto | Significado |
|---|---|---|---|
| sqrt2 | root-obj(x² - 2, 2) | $+\sqrt{2} \approx 1{,}4142$ | La constante que definimos |
| E_ab | root-obj(2x² - 1, 1) | $-\sqrt{2}/2 \approx -0{,}7071$ | Correlación cuántica $(a,b)$ |
| E_abp | root-obj(2x² - 1, 2) | $+\sqrt{2}/2 \approx +0{,}7071$ | Correlación cuántica $(a,b')$ |
| E_apb | root-obj(2x² - 1, 1) | $-\sqrt{2}/2 \approx -0{,}7071$ | Correlación cuántica $(a',b)$ |
| E_apbp | root-obj(2x² - 1, 1) | $-\sqrt{2}/2 \approx -0{,}7071$ | Correlación cuántica $(a',b')$ |
| S_ctx | root-obj(x² - 8, 1) | $-2\sqrt{2} \approx -2{,}828$ | Combinación CHSH |
| CHSH_bound | 2.0 | $2{,}0$ | Cota clásica |

Verificación: $|S_{ctx}| = 2\sqrt{2} \approx 2{,}828 > 2{,}0 = CHSH_bound$. ✅

#### Teoremas algebraicos integrados [A-Meta]

Teorema T-Alg [A-Meta]

Valor exacto de la combinación CHSH contextual.

Enunciado. Sean $E_{ab} = -\frac{\sqrt{2}}{2}$, $E_{ab'} = +\frac{\sqrt{2}}{2}$, $E_{a'b} = -\frac{\sqrt{2}}{2}$, $E_{a'b'} = -\frac{\sqrt{2}}{2}$. Defínase $S_{ctx} = E_{ab} - E_{ab'} + E_{a'b} + E_{a'b'}$. Entonces $S_{ctx} = -2\sqrt{2}$ y $|S_{ctx}| > 2$.

Demostración. Sustituimos los valores:

$$
S_{ctx} =
\left(-\frac{\sqrt{2}}{2}\right)
-
\left(+\frac{\sqrt{2}}{2}\right)
+
\left(-\frac{\sqrt{2}}{2}\right)
+
\left(-\frac{\sqrt{2}}{2}\right)
=
-4 \cdot \frac{\sqrt{2}}{2}
=
-2\sqrt{2}.
$$

Como $\sqrt{2} > 1{,}414$, tenemos $|S_{ctx}| = 2\sqrt{2} > 2 \cdot 1{,}414 = 2{,}828 > 2$. $\square$

Teorema T-Fine [A-Meta]

Imposibilidad de distribución conjunta en el modelo contextual.

Enunciado. Bajo $\Sigma$, si $|S_{ctx}| > 2$ y $Realism \land Locality$ es verdadero, entonces $\neg JointDist$ (y por $A3$, $\neg CFD$).

Demostración. Supóngase $JointDist$ verdadero. Entonces $Realism \land Locality \land JointDist$. Por $A5$, $|S| \leq 2$. Pero por T-Alg, $|S_{ctx}| = 2\sqrt{2} > 2$. Como el modelo contextual ajusta los datos ($A6$), la variable $S_value$ toma el valor $2{,}828 = 2\sqrt{2}$. Luego $|S_value| \leq 2$ es falso. Contradicción. Por tanto $\neg JointDist$. Por $A3$ (equivalencia), $\neg CFD$. $\square$

Nota. Este teorema es la reconstrucción formal del Corolario 6.2.6. No demuestra el teorema de Fine (que es citado como [B] y postulado como $A3$), sino que usa $A3$ para derivar la consecuencia lógica dentro del sistema del capítulo.

Nota sobre el alcance de esta verificación. El script verifica la consistencia algebraica de las correlaciones cuánticas y su violación de CHSH. No construye explícitamente las distribuciones de probabilidad $P_{xy}$ con variables aleatorias $A_{xy}(\omega), B_{xy}(\omega) \in \{-1,+1\}$ que produzcan esos valores esperados manteniendo independencia local. La construcción explícita de tales distribuciones excede el alcance lógico-epistemológico de este capítulo.

La consistencia del modelo contextual como descripción epistemológica se sostiene porque la mecánica cuántica misma calcula cada correlación por separado mediante la regla de Born sobre el estado singlete $|\Psi^-\rangle$, sin postular una distribución conjunta $P(A,A',B,B'|\Psi^-)$. Por el teorema de Fine (1982), la violación de CHSH implica que no existe una distribución conjunta clásica de la cual las cuatro correlaciones sean marginales. El modelo contextual es consistente precisamente porque renuncia a postular tal distribución.

Observación crucial. El Modelo Contextual no es una teoría física que compita con la mecánica cuántica como descripción fundamental. Es una descripción epistemológica de los datos: el estadístico que solo tiene acceso a los registros de los detectores puede describir cada sub-experimento con su propio espacio de probabilidad, sin necesidad de postular un espacio común que unifique los cuatro.

Corolario 6.2.6 (Verificación algebraica del Postulado de Viabilidad). El Postulado de Viabilidad (A7) se verifica como consistencia algebraica: el script confirma que los cuatro valores cuánticos son mutuamente consistentes como números reales y violan la cota CHSH, lo cual (por Fine 1982) implica que no requieren una distribución conjunta. El script no construye explícitamente las distribuciones $P_{xy}$ con variables $\pm 1$; eso excede el alcance lógico-epistemológico de este capítulo.

---

### 6.2.5 Metateoremas del sistema axiomático Z3 [A-Meta]

Para mantener la higiene epistémica, nosotros separamos explícitamente lo demostrable de lo no-demostrable con los materiales del capítulo. Todo lo que aquí enunciamos se deriva exclusivamente de los axiomas A1–A8, las definiciones 6.2.4, los hechos del programa Clingo y las reglas de agregación del capítulo. No añadimos datos empíricos, interpretaciones sociológicas ni física cuántica externa.

#### Lo que NO admite demostración formal [A-Meta] a partir del Capítulo 6

| Enunciado del capítulo | Razón |
|---|---|
| “La recepción estándar reifica la conjunción” | Tesis sociológica/interpretativa [C] |
| “Fine (1982) demostró la equivalencia CFD⇔JD” | Cita de literatura [B]; en el capítulo es axioma A3 |
| “Pitowsky demostró que Bell es teorema de probabilidad, no de localidad” | Cita [B] |
| “Spekkens desarrolló modelos contextuales” | Cita [B] |
| “La pedagogía de Bell opera mediante totalización” | Análisis discursivo [B/C] |
| “El realismo mínimo es una posición filosófica legítima” | Tesis filosófica [C] |
| “El modelo Clingo no es historia real” | Advertencia metodológica [C] |
| Cualquier afirmación sobre “mensajes instantáneos” o “acción a distancia” | Interpretación física [C] |

#### Familia I: Metateoremas del sistema axiomático Z3

Teorema T-Cons [A-Meta]

Consistencia del sistema base.

Enunciado. Sea $\Sigma = \{A1, A2, A3, A5, A6, A7, A8\}$ el conjunto de axiomas del sistema formal de la sección 6.2. Entonces $\Sigma$ es consistente.

Demostración. Exhibimos un modelo $\mathcal{M}$. Sea el dominio de interpretación el conjunto de valores booleanos y reales estándar. Definimos:

$Realism^{\mathcal{M}} = \top$, $Locality^{\mathcal{M}} = \top$, $CFD^{\mathcal{M}} = \bot$, $JointDist^{\mathcal{M}} = \bot$.

$FourSubexperiments^{\mathcal{M}} = \top$, $OnlyDetectorData^{\mathcal{M}} = \top$.

$StatisticianImposesJoint^{\mathcal{M}} = \bot$, $StatisticianUsesContextual^{\mathcal{M}} = \top$.

$S_value^{\mathcal{M}} = 2{,}828$.

$A4^{\mathcal{M}}$ puede definirse arbitrariamente (por ejemplo, $\bot$).

Verificación axioma por axioma:

A1: Antecedente $FourSub \land OnlyData$ es $\top$; consecuente $\neg StatisticianImposesJoint$ es $\neg\bot = \top$. La implicación es $\top$.

A2: $JointDist = StatisticianImposesJoint$ se satisface: $\bot = \bot$.

A3: $CFD = JointDist$ se satisface: $\bot = \bot$.

A5: Antecedente $Realism \land Locality \land JointDist = \top \land \top \land \bot = \bot$. La implicación es vacuamente $\top$.

A6: $S_value = 2{,}828$ por asignación.

A7: Antecedente $Realism \land Locality \land StatisticianUsesContextual = \top \land \top \land \top = \top$. Consecuente $\neg JointDist \land (S_value = 2{,}828) = \top \land \top = \top$. La implicación es $\top$.

A8: $StatisticianImposesJoint \oplus StatisticianUsesContextual = \bot \oplus \top = \top$.

Como todo axioma de $\Sigma$ es verdadero en $\mathcal{M}$, $\Sigma$ es satisfacible, luego consistente. $\square$

Teorema T-Ind [A-Meta]

Independencia del lema A4.

Enunciado. El lema $A4 : (Realism \land Locality) \rightarrow CFD$ es independiente de $\Sigma$. Es decir, ni $A4$ ni $\neg A4$ son teoremas de $\Sigma$.

Demostración. Debemos exhibir dos modelos de $\Sigma$ que difieran en el valor de verdad de $A4$.

Modelo $\mathcal{M}_1$ donde $A4$ es verdadero: Modificamos $\mathcal{M}$ de T-Cons fijando $Realism^{\mathcal{M}_1} = \bot$. Entonces el antecedente de $A4$ es $\bot$, luego $A4$ es $\top$ en $\mathcal{M}_1$. Los demás axiomas se siguen satisfaciendo porque $A5$ y $A7$ tienen antecedentes que se vuelven $\bot$ o se mantienen $\top$ según corresponda, y los demás axiomas no dependen de $Realism$.

Modelo $\mathcal{M}_2$ donde $A4$ es falso: Tomamos $\mathcal{M}$ de T-Cons tal cual. Allí $Realism = \top$, $Locality = \top$, $CFD = \bot$. El antecedente de $A4$ es $\top$ y el consecuente $\bot$, luego $A4$ es $\bot$ en $\mathcal{M}_2$.

Como $\Sigma$ tiene modelos donde $A4$ es verdadero y modelos donde es falso, $A4$ es independiente de $\Sigma$. $\square$

Teorema T-NDev [A-Meta]

No-derivabilidad de la inferencia estándar.

Enunciado. $\Sigma \not\vdash (Realism \land Locality) \rightarrow JointDist$.

Demostración. Por reducción al absurdo semántico. Supóngase que la fórmula fuera teorema de $\Sigma$. Entonces sería verdadera en todo modelo de $\Sigma$. Pero en el modelo $\mathcal{M}_2$ de T-Ind (que es modelo de $\Sigma$), tenemos $Realism = \top$, $Locality = \top$, $JointDist = \bot$. Luego $(Realism \land Locality) \rightarrow JointDist$ es $\bot$ en $\mathcal{M}_2$. Contradicción. $\square$

Nota. Este metateorema formaliza exactamente la “falacia estructural” que el capítulo atribuye a la recepción estándar: la inferencia de que realismo y localidad implican distribución conjunta no es válida en el sistema axiomático base.

Teorema T-Equiv [A-Meta]

La inferencia estándar ES válida bajo A4.

Enunciado. $\Sigma \cup \{A4\} \vdash \neg(Realism \land Locality)$.

Demostración. Supóngase $Realism \land Locality$. Por $A4$, se sigue $CFD$. Por $A3$ ($CFD \leftrightarrow JointDist$), se sigue $JointDist$. Entonces $Realism \land Locality \land JointDist$. Por $A5$, se sigue $S_value \leq 2$. Por $A6$, $S_value = 2{,}828$. Luego $2{,}828 \leq 2$, una contradicción aritmética. Por tanto, la suposición $Realism \land Locality$ es imposible en $\Sigma \cup \{A4\}$. Se sigue $\neg(Realism \land Locality)$. $\square$

Nota. Este teorema demuestra formalmente la concesión honesta del capítulo: si se adopta la definición estándar donde $A4$ es analítico (es decir, si $Realism$ incluye $CFD$ por definición), entonces la recepción estándar es lógicamente correcta. La crítica del capítulo no es a la validez lógica bajo esas premisas, sino a la presentación de $A4$ como inevitable cuando es una elección definitorial.

---

## 6.3 Los siete teoremas: verificación de la elisión axiomática [A-Meta] + [A-Código]

Con el sistema axiomático definido, nosotros planteamos siete teoremas que exploran el espacio de consistencia. Cada teorema corresponde a una pregunta específica sobre la estructura lógica del argumento de Bell y su recepción estándar.

---

### Teorema 1 (UNSAT): Bell es matemáticamente correcto dentro de su marco [A-Meta] + [A-Código]

Enunciado [A-Meta]. $\Sigma \cup \{Realism, Locality, JointDist\} \vdash \bot$.

Demostración [A-Meta]. Supóngase $Realism \land Locality \land JointDist$. Por el axioma $A5$:

$$
(Realism \land Locality \land JointDist) \rightarrow (S_value \leq 2).
$$

Por modus ponens, $S_value \leq 2$. Por el axioma $A6$, $S_value = 2{,}828$. Luego $2{,}828 \leq 2$. Esta desigualdad aritmética es falsa. Se deriva $\bot$. $\square$

Verificación computacional [A-Código]:

```lisp
(push)
(assert (! (and Realism Locality JointDist) :named T1_Bell_Target))
(check-sat)
(get-unsat-core)
(pop)
```

Resultado verificado:

```text
unsat
(T1_Bell_Target A5_CHSH_Correct A6_Experimental_Data)
```

Interpretación: Si se acepta $R \wedge L \wedge JointDist$, por A5 se obtiene $S \le 2$, pero A6 dice $S = 2{,}828$. Contradicción. Z3 identifica el núcleo insatisfacible mínimo: exactamente tres axiomas están en tensión. Esto confirma que Bell es matemáticamente correcto dentro de su marco. Nadie refuta el álgebra.

---

### Teorema 2 (UNSAT): La incompatibilidad surge al invocar A4 [A-Meta] + [A-Código]

Enunciado [A-Meta]. $\Sigma \cup \{A4, Realism, Locality\} \vdash \bot$.

Demostración [A-Meta]. Supóngase $A4 \land Realism \land Locality$. Por $A4$, $(Realism \land Locality) \rightarrow CFD$. Por modus ponens con las dos últimas premisas, $CFD$. Por $A3$ ($CFD \leftrightarrow JointDist$), $JointDist$. Entonces $Realism \land Locality \land JointDist$. Por T1, esto implica $\bot$. $\square$

Verificación computacional [A-Código]:

```lisp
(push)
(assert (! A4_Reception_Fallacious_Lemma :named A4_Invoked))
(assert (! Realism :named R_T2))
(assert (! Locality :named L_T2))
(assert (! A6_Experimental_Data :named Data_T2))
(check-sat)
(get-unsat-core)
(pop)
```

Resultado verificado:

```text
unsat
(L_T2 A3_Fine_Equivalence A5_CHSH_Correct A6_Experimental_Data
 A4_Definition R_T2 A4_Invoked)
```

Interpretación: Al invocar A4 (el lema $R \wedge L \rightarrow CFD$), el sistema se vuelve inconsistente. El núcleo insatisfacible incluye explícitamente `A4_Invoked`.

Nota sobre la función diagnóstica de T2. Matemáticamente, T2 es equivalente a T1 dado A3 (Fine: $CFD \Leftrightarrow JointDist$). Su función no es revelar una contradicción nueva, sino diagnosticar la etiología de la contradicción: mostrar que el núcleo insatisfacible incluye explícitamente el lema A4. Es análogo a un médico que, sabiendo que el paciente tiene fiebre, hace una prueba para confirmar que la causa es la bacteria X y no la Y.

---

### Teorema 3 (SAT): El escape realista existe [A-Meta] + [A-Código]

Enunciado [A-Meta]. $\Sigma \cup \{Realism, Locality, StatisticianUsesContextual, \neg JointDist, A6\}$ es consistente.

Demostración [A-Meta]. Exhibimos el modelo $\mathcal{M}$ de T-Cons. Allí:

$Realism = \top$, $Locality = \top$, $StatisticianUsesContextual = \top$.

$\neg JointDist = \neg\bot = \top$.

$A6$ se satisface con $S_value = 2{,}828$.

Todos los axiomas de $\Sigma$ se satisfacen (por T-Cons), y las fórmulas adicionales son verdaderas en $\mathcal{M}$. Luego el conjunto es consistente. $\square$

Verificación computacional [A-Código]:

```lisp
(push)
(assert (! Realism :named R_T3))
(assert (! Locality :named L_T3))
(assert (! StatisticianUsesContextual :named SUC_T3))
(assert (! (not JointDist) :named NotJD_T3))
(assert (! A6_Experimental_Data :named Data_T3))
(check-sat)
(get-model)
(pop)
```

Resultado verificado:

```text
sat
(define-fun Realism () Bool true)
(define-fun Locality () Bool true)
(define-fun StatisticianUsesContextual () Bool true)
(define-fun JointDist () Bool false)
(define-fun CFD () Bool false)
(define-fun S_value () Real (/ 707.0 250.0))
```

Interpretación: Z3 encontró un modelo concreto donde:

$Realism = true$

$Locality = true$

$JointDist = false$

$CFD = false$

$S_value = 2{,}828$

Este es el núcleo de la demostración: existe un mundo posible donde el realista local preserva ambos compromisos usando un modelo contextual. El realista no está obligado a usar distribución conjunta.

---

### Teorema 4 (SAT): El terreno neutral no fuerza distribución conjunta [A-Meta] + [A-Código]

Enunciado [A-Meta]. $\{A1, A8\} \cup \{FourSubexperiments, OnlyDetectorData, StatisticianUsesContextual, \neg StatisticianImposesJoint\}$ es consistente.

Demostración [A-Meta]. Sea $\mathcal{M}_4$ la restricción de $\mathcal{M}$ (de T-Cons) a las variables relevantes. Allí $FourSub = \top$, $OnlyData = \top$, $SUC = \top$, $SIJ = \bot$. Verificamos:

$A1$: $\top \rightarrow \neg\bot = \top$.

$A8$: $\bot \oplus \top = \top$.

Las demás fórmulas son verdaderas por asignación. $\square$

Verificación computacional [A-Código]:

```lisp
(push)
(assert (! FourSubexperiments :named FS_T4))
(assert (! OnlyDetectorData :named ODD_T4))
(assert (! StatisticianUsesContextual :named SUC_T4))
(assert (! (not StatisticianImposesJoint) :named NotSIJ_T4))
(check-sat)
(get-model)
(pop)
```

Resultado verificado:

```text
sat
(define-fun FourSubexperiments () Bool true)
(define-fun OnlyDetectorData () Bool true)
(define-fun StatisticianUsesContextual () Bool true)
(define-fun StatisticianImposesJoint () Bool false)
```

Interpretación: El terreno empírico neutral (4 sub-experimentos separados, solo datos de detectores) no fuerza al estadístico a postular distribución conjunta. Los datos no obligan a elegir un modelo sobre otro.

---

### Teorema 5 (SAT): R∧L sin A4 es viable [A-Meta] + [A-Código]

Enunciado [A-Meta]. $\Sigma \cup \{Realism, Locality, A6\} \vdash \neg JointDist$.

Demostración [A-Meta]. Supóngase, para reducir al absurdo, que $JointDist$ es verdadero. Entonces $Realism \land Locality \land JointDist$. Por $A5$, $S_value \leq 2$. Pero $A6$ exige $S_value = 2{,}828$. Contradicción. Luego $\neg JointDist$. $\square$

Corolario inmediato [A-Meta]. Bajo las mismas premisas, $StatisticianUsesContextual$ es verdadero y $StatisticianImposesJoint$ es falso (por $A8$).

Verificación computacional [A-Código]:

```lisp
(push)
(assert (! Realism :named R_T5))
(assert (! Locality :named L_T5))
(assert (! A6_Experimental_Data :named Data_T5))
(check-sat)
(get-model)
(pop)
```

Resultado verificado:

```text
sat
(define-fun Realism () Bool true)
(define-fun Locality () Bool true)
(define-fun JointDist () Bool false)
(define-fun CFD () Bool false)
(define-fun StatisticianUsesContextual () Bool true)
(define-fun S_value () Real (/ 707.0 250.0))
```

Interpretación: Sin el lema que la recepción estándar asumió (A4), $R \wedge L$ es perfectamente consistente con $S = 2{,}828$. La estructura axiomática fuerza $JointDist = false$ y $StatisticianUsesContextual = true$ como vía de escape.

---

### Teorema 6 (SAT): La invalidez de la inferencia estándar [A-Meta] + [A-Código]

Enunciado [A-Meta]. El conjunto $\{\neg(Realism \land Locality \land JointDist), Realism, Locality, A6\} \cup \Sigma$ es consistente.

Demostración [A-Meta]. Exhibimos el modelo $\mathcal{M}$ de T-Cons. Evaluamos:

$\neg(R \land L \land JD) = \neg(\top \land \top \land \bot) = \neg\bot = \top$.

$Realism = \top$, $Locality = \top$.

$A6$ satisfecho.

Luego existe un modelo donde la conjunción de la tríada es falsa, pero $Realism$ y $Locality$ son verdaderos. Esto prueba que $\neg(R \land L \land JD)$ no implica $\neg(R \land L)$. $\square$

Verificación computacional [A-Código]:

```lisp
(push)
(assert (! (not (and Realism Locality JointDist)) :named NotRLJD_T6))
(assert (! Realism :named R_T6))
(assert (! Locality :named L_T6))
(assert (! A6_Experimental_Data :named Data_T6))
(check-sat)
(get-model)
(pop)
```

Resultado verificado:

```text
sat
(define-fun Realism () Bool true)
(define-fun Locality () Bool true)
(define-fun JointDist () Bool false)
(define-fun S_value () Real (/ 707.0 250.0))
```

Interpretación: Aceptar $\neg(R \wedge L \wedge JD)$ y mantener $R \wedge L$ es lógicamente consistente. Esto formaliza exactamente la invalidez de la inferencia estándar: de $\neg(A \wedge B \wedge C)$ no se sigue $\neg(A \wedge B)$ a menos que se asuma $(A \wedge B) \rightarrow C$.

Nota sobre la analogía del triángulo equilátero rojo. Una forma común de ilustrar esta estructura lógica es: “Bell demostró que no existe un triángulo equilátero rojo; la recepción estándar concluyó que no existe un triángulo equilátero. La conclusión solo sigue si se asume que todo triángulo equilátero debe ser rojo.”

Advertencia sobre la analogía: Esta analogía ilustra nuestra posición (donde CFD es contingente respecto al realismo), pero no prueba su corrección. Para Bell y para la definición estándar de realismo local, CFD era constitutiva del realismo (el “rojo” no era contingente sino esencial). Bajo esa definición, la inferencia de la recepción estándar es lógicamente válida. La analogía es pedagógicamente útil para mostrar la estructura de la elisión axiomática, pero la corrección de nuestra posición depende de cuál definición de realismo se adopte, no de la analogía.

---

### Teorema 7 (SAT): Fine + rechazo de A4 = realismo local contextual viable [A-Meta] + [A-Código]

Enunciado [A-Meta]. $\Sigma \cup \{\neg A4, Realism, Locality, StatisticianUsesContextual, A6\}$ es consistente.

Demostración [A-Meta]. En el modelo $\mathcal{M}$ de T-Cons, tenemos $Realism = \top$, $Locality = \top$, $CFD = \bot$. Evaluamos $A4 = (R \land L) \rightarrow CFD = \top \rightarrow \bot = \bot$. Luego $\neg A4 = \top$. Los demás axiomas se satisfacen como en T-Cons. $\square$

Verificación computacional [A-Código]:

```lisp
(push)
(assert (! (not A4_Reception_Fallacious_Lemma) :named NotA4_T7))
(assert (! Realism :named R_T7))
(assert (! Locality :named L_T7))
(assert (! StatisticianUsesContextual :named SUC_T7))
(assert (! A6_Experimental_Data :named Data_T7))
(check-sat)
(get-model)
(pop)
```

Resultado verificado:

```text
sat
(define-fun Realism () Bool true)
(define-fun Locality () Bool true)
(define-fun A4_Reception_Fallacious_Lemma () Bool false)
(define-fun StatisticianUsesContextual () Bool true)
(define-fun JointDist () Bool false)
(define-fun CFD () Bool false)
(define-fun S_value () Real (/ 707.0 250.0))
```

Interpretación: Aceptando la equivalencia de Fine (A3: $CFD \Leftrightarrow JointDist$) pero rechazando explícitamente el lema que la recepción estándar asumió (A4), Z3 construye un modelo donde el realista local preserva todos sus compromisos ontológicos usando modelo contextual. La consistencia algebraica de este modelo está verificada por el script `contextual_model_z3.smt2` (Sección 6.2.4), que demuestra que las cuatro correlaciones cuánticas satisfacen $S_{ctx} = -2\sqrt{2} \approx -2{,}828$ violando la cota CHSH.

---

### Tabla resumen de los siete teoremas

| Teorema | Resultado | Núcleo / Modelo clave | Interpretación |
|---|---|---|---|
| T1 | unsat | T1_Bell_Target + A5_CHSH_Correct + A6_Experimental_Data | Bell es matemáticamente correcto: $R \wedge L \wedge DC$ es incompatible con $S = 2{,}828$ |
| T2 | unsat | Incluye A4_Invoked | La incompatibilidad surge al invocar el lema A4 (función diagnóstica) |
| T3 | sat | $R=true$, $L=true$, $SUC=true$, $JD=false$, $S=2{,}828$ | El núcleo de la demostración: el realista local contextual es perfectamente viable |
| T4 | sat | $FourSub=true$, $OnlyData=true$, $SUC=true$, $SIJ=false$ | El terreno común no fuerza distribución conjunta |
| T5 | sat | $R=true$, $L=true$, $JD=false$, $S=2{,}828$ | Sin A4, $R \wedge L$ encaja con los datos |
| T6 | sat | $R=true$, $L=true$, $JD=false$, $S=2{,}828$ | Aceptar $\neg(R \wedge L \wedge DC)$ y mantener $R \wedge L$ es consistente |
| T7 | sat | $R=true$, $L=true$, $\neg A4$, $SUC=true$, $JD=false$, $S=2{,}828$ | Fine + rechazo de A4 = realismo local contextual viable (consistencia algebraica verificada en 6.2.4) |

---

### La elisión axiomática en una línea

La recepción estándar demostró (correctamente): $\neg(R \wedge L \wedge DC)$.

Pero concluyó (inválidamente sin A4): $\neg(R \wedge L)$.

Esto es lógicamente inválido sin el lema $(R \wedge L) \rightarrow DC$.

Pitowsky y Fine demostraron que $DC$ se deriva de la CFD, no de la localidad.

Por tanto, la elisión axiomática en la recepción estándar es una petición de principio estadístico: impone una estructura de probabilidad conjunta como si fuera consecuencia ontológica de la localidad, cuando es solo una elección metodológica.

Importante: Si se adopta la definición estándar de “realismo local” (donde CFD es constitutiva), entonces $R \rightarrow CFD$ es analítico, A4 es verdadero por definición, y la inferencia de la recepción estándar es lógicamente válida. La “elisión axiomática” que denunciamos es pedagógica y retórica: la totalización de la conjunción que ocultó que CFD es un supuesto separable bajo otras definiciones de realismo.

---

## 6.4 Clingo: Dinámica epistémica de la comunidad científica [A-Meta] + [A-Código]

Si el espacio de modelos de Z3 es estático —un mapa de posibilidades lógicas—, el modelo Clingo es dinámico: simula cómo una comunidad de agentes con compromisos ontológicos explícitos transitaría entre modelos estadísticos ante la evidencia.

---

### 6.4.1 Estructura del modelo

El código Clingo modela:

5 agentes con compromisos ontológicos declarados:

`locality_first_realists` (comprometidos con R + L)

`realism_first_realists` (comprometidos con R)

`bellian_orthodox` (comprometidos con R + L, pero usan joint_model)

`epistemic_pragmatists` (comprometidos con L)

`experimental_neutrals` (ningún compromiso ontológico previo)

4 modelos estadísticos con propiedades declaradas:

`joint_model`: requiere CFD, no ajusta $S = 2{,}828$

`contextual_model`: no viola localidad ni realismo, ajusta $S = 2{,}828$

`epistemic_model`: viola realismo, ajusta $S = 2{,}828$

`bohm_model`: viola localidad, ajusta $S = 2{,}828$

Restricciones de coherencia ontológica:

Un agente comprometido con localidad NO puede adoptar un modelo que viole localidad.

Un agente comprometido con realismo NO puede adoptar un modelo que viole realismo.

Optimización multiobjetivo:

Prioridad 1 (peso 4): minimizar costo ontológico (satélites activos)

Prioridad 2 (peso 3): minimizar uso de joint_model post-t=0

Prioridad 3 (peso 2): maximizar ajuste empírico

Prioridad 4 (peso 1): minimizar violaciones de compromiso

Prioridad 5 (peso 0): minimizar cambios bruscos

---

### 6.4.2 Resultado verificado (OPTIMUM FOUND, Answer 23)

```text
Optimization: 5 0 -15 6
OPTIMUM FOUND
```

| Métrica | Valor | Significado |
|---|---|---|
| Costo ontológico | 5 | Solo satélites heredados de t=0. Post-crisis: cero entidades no medidas postuladas |
| Uso de joint_model | 0 | Nadie usa el modelo de Bell después de t=0 |
| Ajuste empírico | -15 | Máximo absoluto: los 5 agentes ajustan los datos en los 3 tiempos |
| Cambios | 6 | Mínimo necesario para escapar del paradigma conjunto |

---

### 6.4.3 Trayectoria de cada agente en el óptimo

| Agente | Compromisos | t=0 | t=1 | t=2 | t=3 | Destino final |
|---|---|---|---|---|---|---|
| locality_first_realists | L + R | joint | contextual | contextual | contextual | Única opción viable |
| bellian_orthodox | L + R | joint | contextual | contextual | contextual | Única opción viable |
| realism_first_realists | R | joint | contextual | contextual | contextual | Preferido sobre Bohm |
| epistemic_pragmatists | L | joint | contextual | epistemic | epistemic | Contextual como puente |
| experimental_neutrals | (ninguno) | joint | bohm | bohm | bohm | Libre elección |

---

### 6.4.4 Interpretación del resultado

1. El realista local es forzado al modelo contextual.  
`locality_first_realists` y `bellian_orthodox` tienen compromisos con ambos principios (R y L). Las restricciones de coherencia los bloquean:

❌ `bohm_model` → viola localidad (acción a distancia)

❌ `epistemic_model` → viola realismo (no hay valores preexistentes)

❌ `joint_model` → inconsistente con datos (requiere CFD)

✅ `contextual_model` → única opción restante

2. El modelo contextual es preferido incluso por realistas puros.  
`realism_first_realists` (solo comprometidos con realismo, podrían aceptar no-localidad) igual eligen `contextual_model` sobre `bohm_model`. El optimizador penaliza el costo ontológico: Bohm postula una ontología más extravagante (onda piloto no-local). El contextual es más parsimonioso.

3. El paradigma de la recepción estándar es históricamente inestable.  
Cero agentes permanecen en `joint_model` post-t=0. La ortodoxía de la recepción estándar no es un atractor del sistema. La evidencia de 4 sub-experimentos + el teorema de Fine la desestabilizan irreversiblemente.

4. Fragmentación post-crisis con un núcleo contextual.  
Aunque la comunidad se fragmenta (`fragmentation(2,3)`), el `contextual_model` emerge como el atractor dominante: 3 de 5 agentes se estabilizan allí.

Nota sobre el estatus de esta simulación. El modelo Clingo muestra qué ocurriría bajo ciertos criterios de racionalidad (parsimonia ontológica, coherencia, ajuste empírico). No es una reconstrucción histórica de cómo evolucionó realmente el debate sobre Bell. La historia real involucra factores sociológicos, institucionales y económicos que el modelo no captura.

Conexión con el protocolo anti-reificación: La simulación demuestra que si la comunidad científica operara con compromisos ontológicos explícitos y parsimonia (minimizar entidades no medidas postuladas), la interpretación contextual emergería naturalmente como la opción dominante para los realistas locales —sin necesidad de renunciar ni al realismo ni a la localidad. La reificación de la conjunción $R \wedge L \wedge CFD$ como “el realismo local” es lo que impide ver esta tercera vía.

---

### 6.4.5 Metateoremas formales de la dinámica Clingo [A-Meta]

Teorema T-Coh [A-Meta]

Coherencia ontológica fuerza el modelo contextual.

Enunciado. En el programa Clingo de la sección 6.4, sea $a$ un agente cuyos compromisos ontológicos incluyan $Realism$ y $Locality$. Sea $AS$ un answer set que satisfaga las restricciones de coherencia ontológica del programa. Entonces para todo tiempo $t>0$: $adopta(a, contextual_model, t) \in AS$, y $adopta(a, M, t) \notin AS$ para $M \in \{bohm_model, epistemic_model, joint_model\}$.

Demostración. Análisis de casos exhaustivo sobre los cuatro modelos disponibles.

Caso 1: $M = bohm_model$. El programa declara que $bohm_model$ viola $Locality$. La restricción de coherencia ontológica del programa elimina (mediante regla de restricción `:-`) todo answer set donde un agente comprometido con $Locality$ adopte $bohm_model$. Luego $adopta(a, bohm_model, t) \notin AS$.

Caso 2: $M = epistemic_model$. El programa declara que $epistemic_model$ viola $Realism$. Análogamente, la restricción de coherencia elimina esta opción para agentes comprometidos con $Realism$. Luego $adopta(a, epistemic_model, t) \notin AS$.

Caso 3: $M = joint_model$. El programa asocia a $joint_model$ la propiedad de requerir $CFD$ (equivalente a $JointDist$ por $A3$). Por la dinámica del programa y las weak constraints de ajuste empírico, un agente que adopte $joint_model$ en $t>0$ incurre en costo por no ajustar los datos (o directamente viola restricciones de optimalidad). Más aún, el answer set óptimo verificado tiene costo 0 en joint_model post-t=0, lo cual implica que ningún agente lo adopta. Luego $adopta(a, joint_model, t) \notin AS$ en el óptimo.

Caso 4: $M = contextual_model$. Este modelo no viola $Realism$ ni $Locality$ según la declaración del programa, y ajusta los datos. No está bloqueado por ninguna restricción de coherencia.

Como la choice rule del programa fuerza a cada agente a adoptar exactamente un modelo, y los casos 1–3 son imposibles, necesariamente $adopta(a, contextual_model, t) \in AS$. $\square$

Teorema T-Opt [A-Meta]

Optimalidad lexicográfica del answer set 23.

Enunciado. Sea $AS_{23}$ el answer set con vector de costo $(5, 0, -15, 6)$ reportado en la sección 6.4.2. Entonces $AS_{23}$ es óptimo bajo el orden lexicográfico de weak constraints del programa.

Demostración. Análisis por prioridades.

Prioridad 2 (peso 3, minimizar uso de joint_model post-t=0): El valor 0 significa que ningún agente adopta $joint_model$ en $t>0$. Este es el mínimo absoluto posible, ya que el costo es una suma de penalizaciones no negativas. Cualquier answer set con valor $>0$ en esta prioridad es estrictamente dominado por $AS_{23}$.

Prioridad 3 (peso 2, maximizar ajuste empírico): El valor $-15$ corresponde a 5 agentes $\times$ 3 tiempos ($t=1,2,3$) de ajuste perfecto, cada uno con costo $-1$. Este es el mínimo (más negativo) posible. Cualquier answer set con valor $>-15$ es estrictamente dominado en esta prioridad.

Como $AS_{23}$ alcanza los óptimos absolutos en las prioridades 2 y 3, ningún answer set puede dominarlo lexicográficamente. Las prioridades 1 y 4 solo desempatizan entre answer sets que empatan en 2 y 3; por tanto, $AS_{23}$ es globalmente óptimo. $\square$

Teorema T-NoAtr [A-Meta]

Inestabilidad del joint_model.

Enunciado. En la dinámica definida por el programa Clingo, $joint_model$ no pertenece a ningún answer set óptimo en tiempo $t>0$.

Demostración. Por la weak constraint de prioridad 2, cada instancia de $adopta(A, joint_model, t)$ con $t>0$ contribuye con costo estrictamente positivo al vector de optimización. Sin embargo, por T-Opt, existe un answer set ($AS_{23}$) con costo 0 en esta prioridad. Por definición de optimalidad lexicográfica en Clingo, cualquier answer set con costo mayor en la prioridad más alta dominante es estrictamente peor. Luego ningún answer set que contenga $joint_model$ en $t>0$ puede ser óptimo. $\square$

Teorema T-Frag [A-Meta]

Fragmentación epistémica en el óptimo.

Enunciado. En $AS_{23}$, para $t=3$, existen al menos dos agentes $a_1, a_2$ tales que los modelos adoptados son distintos.

Demostración. Inspección de la trayectoria reportada en la sección 6.4.3:

$locality_first_realists$ adopta $contextual_model$ en $t=3$.

$experimental_neutrals$ adopta $bohm_model$ en $t=3$.

Sean $a_1 = locality_first_realists$ y $a_2 = experimental_neutrals$. Entonces $adopta(a_1, contextual_model, 3) \in AS_{23}$ y $adopta(a_2, bohm_model, 3) \in AS_{23}$. Como $contextual_model \neq bohm_model$, la comunidad está fragmentada. El programa deriva el átomo $fragmentation(2,3)$ porque el conteo de modelos distintos en $t=3$ es mayor o igual que 2. $\square$

---

## 6.5 Evidencia y anclaje en la literatura [B]

La tesis de este capítulo no es una invención del autor. Tiene anclaje en la filosofía de la física contemporánea. Presentamos estos autores como antecedentes de nuestra formalización, no como posiciones a refutar.

Fine (1982): Arthur Fine demostró que las desigualdades de Bell son condiciones necesarias y suficientes para la existencia de una distribución de probabilidad conjunta sobre todas las variables de medición involucradas [B]. La equivalencia $CFD \Leftrightarrow JointDist$ es el fundamento matemático de nuestra formalización (Axioma 3).

Pitowsky (1989): Itamar Pitowsky demostró que las desigualdades de Bell son teoremas de la probabilidad clásica, no de la localidad [B]. La derivación de la cota CHSH requiere exclusivamente la existencia de una distribución conjunta; la localidad no aparece en la demostración algebraica. Esto confirma que el verdadero supuesto insostenible es la CFD, no la localidad.

Spekkens (2005): Robert Spekkens desarrolló modelos de variables ocultas contextuales que preservan realismo y localidad [B]. Estos modelos demuestran que existe un espacio lógico para un realismo local sin CFD.

Werner y Griffiths: Reinhard Werner (OQM) y Robert Griffiths (Historias Consistentes) argumentan que la violación de las desigualdades de Bell no ataca directamente la localidad, sino que demuestra que la mecánica cuántica es una teoría no-clásica [B]. La ruptura es con la estructura probabilística clásica, no con la localidad per se.

Bell (1964, 1981): En el paper original, Bell formula su “vital assumption” como la condición de localidad: “the result B for particle 2 does not depend on the setting $\vec{b}$ of the magnet for particle 1, nor A on $\vec{b}$” [B]. Sin embargo, la estructura de la ecuación (2) —$P(\vec{a}, \vec{b}) = \int d\lambda, \rho(\lambda) A(\vec{a}, \lambda) B(\vec{b}, \lambda)$— ya presupone que $A$ y $B$ están definidos para todo $\lambda$, lo cual es CFD implícita [B]. Bell fue cuidadoso en sus propios escritos al referirse a “teorías de variables ocultas locales” bajo su definición específica. La elisión axiomática que este capítulo denuncia es de la recepción estándar que simplificó su resultado a “Bell refutó el realismo local”.

Invariant Set Theory (Palmer): Tim Palmer propone que ciertas mediciones no pueden realizarse simultáneamente debido a principios nomológicos que restringen el conjunto de estados físicamente posibles [B]. Esto ofrece una vía para violar la Independencia Estadística sin caer en superdeterminismo, mediante una “restricción contracausal” donde el contrafactual es físicamente imposible en lugar de simplemente desconocido.

Nota sobre el estatus epistémico. Estos autores proporcionan anclaje [B] para la tesis central. Nuestra contribución no es descubrir algo nuevo, sino hacer explícito con Z3 lo que ellos intuyeron en prosa: que la conjunción $R \wedge L \wedge CFD$ no es una unidad indivisible, y que el realista puede renunciar a CFD sin renunciar a R ni a L.

---

## 6.6 La pedagogía del teorema de Bell: cómo se enseña la totalización [B/C]

La investigación en educación física (PER) y el análisis de libros de texto revelan que la reificación de la conjunción de Bell no es un accidente; es una estrategia pedagógica sistemática [B].

Frases típicas de libros de texto

| Frase estándar | Operación de reificación |
|---|---|
| “Bell demostró que el realismo local es falso” | Totalización: trata la conjunción como bloque monolítico |
| “La naturaleza es no-local” | Inferencia inválida: de $\neg(R \wedge L \wedge CFD)$ se infiere $\neg L$ |
| “Einstein estaba equivocado” | Personificación + simplificación |
| “No hay variables ocultas locales” | Naturalización: presenta la ausencia de un tipo específico de modelo como ausencia de toda posibilidad realista |
| “El entrelazamiento implica acción a distancia” | Reificación de la correlación como mecanismo causal |

El proceso pedagógico estándar

Se presenta $R \wedge L$ como bloque unitario (“el realismo local”).

Se deriva la desigualdad CHSH.

Se muestra la violación experimental ($S = 2{,}828$).

Se concluye “el realismo local es falso” (sin distinguir qué componente cayó).

La alternativa pedagógica

Presentar R, L y CFD como supuestos separables.

Derivar la desigualdad.

Mostrar la violación.

Concluir: “la conjunción de estos tres supuestos es insostenible; elija cuál abandonar”.

Mostrar que existen 7 interpretaciones viables (como en la sección 5.4.1 del Capítulo 5).

La paradoja pedagógica

La reificación es necesaria para el aprendizaje inicial: presentar “el realismo local” como bloque permite al estudiante entender el teorema sin manejar tres supuestos simultáneamente. Pero la reificación es perniciosa si no se desactiva: produce la misconception persistente de que “Bell refutó el realismo” cuando solo refutó una versión específica que incluye CFD.

La solución es la misma que proponemos en el Capítulo 4: usar la reificación como prótesis cognitiva, pero hacer visible la prótesis. Enseñar con la simplificación, pero señalar que es una simplificación.

Conexión con Edelstein

En la entrevista del 27 de julio de 2026 en el programa “El Maravilloso Mundo de la Física” (Gelatina), el físico teórico José Edelstein dice sobre el entrelazamiento: “Tiene que haber un mensaje instantáneo... resulta que efectivamente ocurre esto” [B]. Esta frase reifica la correlación estadística como mecanismo causal (“mensaje”). El propio Edelstein, en la misma entrevista, invoca la metáfora de Borges sobre el mapa y el territorio, mostrando que sabe que el formalismo no postula “mensajes”. La reificación opera como prótesis pedagógica inevitable, no como error por ignorancia.

---

## 6.7 El debate filosófico: realismo mínimo vs. realismo-CFD [C]

Debemos abordar honestamente la objeción principal: ¿tiene derecho el autor a llamar “realista” a una posición que niega la CFD?

La definición estándar (Bell/EPR)

En la tradición de Bell, “realismo” se define como: las partículas poseen valores definidos para todas las magnitudes medibles, independientemente de si se miden o no. Bajo esta definición, la CFD es parte constitutiva del realismo, y A4 se vuelve analítico (verdadero por definición). Si se adopta esta definición, la recepción estándar no puede ser cuestionada lógicamente: el realismo local, así definido, implica CFD, y CFD implica distribución conjunta, y distribución conjunta implica $|S| \le 2$.

Consecuencia importante: Bajo la definición estándar de realismo local (la de Bell, que incluye CFD como constitutiva), el teorema de Bell SÍ refuta válidamente esa posición, y no hay falacia lógica en la inferencia de la recepción estándar. La “elisión axiomática” que denunciamos es pedagógica y retórica: la totalización de la conjunción como bloque monolítico, que ocultó que CFD es un supuesto separable y que otras definiciones de realismo (como el realismo mínimo) permiten preservar localidad sin CFD.

La definición mínima (este libro)

Nosotros adoptamos una definición más débil de realismo: los detectores no inventan los resultados; miden algo que es independiente del medidor. Bajo esta definición:

El resultado que obtuve no fue inventado por el aparato.

No afirmo que todos los resultados que podría haber obtenido ya estaban definidos simultáneamente.

“El resultado que obtuve no fue inventado” ≠ “Todos los resultados posibles ya estaban definidos”.

Esta distinción es real y filosóficamente legítima. Un termómetro mide la temperatura real de una habitación (realismo mínimo) sin que eso implique que la temperatura de todas las habitaciones posibles del universo está definida simultáneamente.

La objeción y la respuesta

Objeción: Si se define “realismo” como incluyendo CFD por definición, entonces A4 es analítico y la recepción estándar no puede ser cuestionada lógicamente.

Respuesta: Correcto. Pero esa es una elección terminológica, no un hecho lógico. La pregunta es: ¿es la definición estándar la única legítima? Nosotros sostenemos que no. La definición mínima (detectores no inventan) es una posición filosófica coherente y defendible. No es la posición que Bell atacó; Bell atacó el realismo-CFD bajo su definición específica. Pero eso no la vuelve ilegítima.

Posición del libro

Adoptamos “realismo contextual” como posición legítima, citando a Spekkens y la tradición de realismo estructural [B]. No pretendemos que sea la única definición de realismo; pretendemos mostrar que la definición estándar no es la única posible, y que la elección de definición no puede resolver el debate por sí sola.

Concesión honesta: Un defensor de la definición estándar puede rechazar nuestro “realismo mínimo” como insuficiente. Esto es legítimo. Nuestro punto no es que la definición estándar sea incorrecta, sino que no es la única, y que la narrativa “Bell refutó el realismo” es ambigua porque no especifica qué definición de “realismo” está usando.

---

## 6.8 Limitaciones [C]

Para completar el análisis, nosotros señalamos explícitamente lo que este capítulo no puede hacer.

Primera limitación: Las variables booleanas son simplificaciones.  
“Realismo”, “localidad” y “CFD” tienen formulaciones mucho más matizadas en la literatura. El modelo captura la estructura lógica, no toda la riqueza del debate. El nivel de abstracción es adecuado para el propósito (mostrar la estructura de la elisión axiomática), pero no modela la física completa.

Segunda limitación: El modelo contextual es una descripción epistemológica, no una teoría física.  
El script `contextual_model_z3.smt2` verifica la consistencia algebraica de las correlaciones cuánticas; no proporciona un modelo físico completo de variables contextuales que derive las correlaciones cuánticas desde principios más fundamentales. El MC es una descripción epistemológica, no una teoría física alternativa. La pregunta “¿por qué las correlaciones tienen los valores cuánticos?” sigue abierta para el realista contextual; la respuesta es “porque así lo dicta la mecánica cuántica mediante la regla de Born”, pero eso es aceptar la MC como descripción, no como explicación fundamental.

Tercera limitación: A1 es una elección filosófica, no un teorema.  
La afirmación “4 sub-experimentos separados no fuerzan distribución conjunta” es defendible pero no es una verdad lógica necesaria. Un defensor de la distribución conjunta puede argumentar que la CFD es una consecuencia ontológica del realismo, no una elección metodológica. Esta objeción es legítima; nuestro punto es que la elección debe ser explícita, no implícita.

Cuarta limitación: No resolvemos el problema físico.  
No proponemos un mecanismo que explique las correlaciones cuánticas desde primeros principios. Solo mostramos que la inferencia estándar en la recepción del teorema de Bell es más débil de lo que se presenta.

Quinta limitación: La definición de “realismo” es disputada.  
Un defensor de la definición estándar puede rechazar nuestro “realismo mínimo” como insuficiente. Esto es legítimo; nuestro punto es que la elección de definición no puede resolver el debate por sí sola.

Sexta limitación: El modelo Clingo es una simulación normativa, no historia real.  
Muestra qué pasaría bajo ciertos criterios de racionalidad (parsimonia, coherencia ontológica); no predice ni explica la historia real de la recepción de Bell. La historia real involucra factores sociológicos, institucionales y económicos que el modelo no captura.

Séptima limitación: No modelamos poder coercitivo ni dinámicas institucionales.  
La razón por la cual la narrativa estándar persiste a pesar de las críticas de Fine y Pitowsky involucra factores de poder académico, inercia institucional y pedagogía que trascienden la lógica formal.

---

## 6.9 Conexiones con otros capítulos [C]

| Capítulo | Conexión |
|---|---|
| Cap 0 (Protocolo) | Aplicación directa de las 4 preguntas al teorema de Bell y su recepción |
| Cap 1 (Reificación) | La conjunción $R \wedge L \wedge CFD$ tratada como sustancia unitaria = totalización (proceso satélite identificado en 1.2.1) |
| Cap 2 (Herramientas) | Z3 para satisfacibilidad (sección 2.3), Clingo para dinámica (sección 2.4); justificación de la elección |
| Cap 3 (SPA/Tarski) | Análogo: SPA estratifica niveles para evitar autorreferencia; aquí estratificamos supuestos para evitar inferencias inválidas. El lema A4 es el análogo normativo de la autorreferencia: una premisa que se aplica a sí misma sin justificación |
| Cap 4 (Gramática) | La reificación gramatical: “el realismo local es falso” trata una conjunción como sujeto unitario de un predicado. La gramática exige un sujeto sustancial para el verbo “ser refutado”, aunque el formalismo describa una conjunción separable |
| Cap 5 (Medición cuántica) | Nota conectiva importante: El Capítulo 5 mapeó 7 interpretaciones viables usando un cubo de 8 vértices (combinaciones de L, C, I). El vértice $(L=true, C=false, I=true)$ se etiquetó allí como “QBism / OQM / Copenhague estricto” (todos epistémicos, no realistas). El modelo contextual de este capítulo ocupa ese mismo vértice con realismo recuperado. ¿Por qué no aparecía en el cubo del Capítulo 5? Porque el cubo asumía implícitamente que renunciar a CFD implica renunciar al realismo —precisamente la elisión axiomática que este capítulo desmonta. El modelo contextual es el vértice $(L=true, C=false, I=true)$ con realismo mínimo preservado, una posibilidad que el cubo del Capítulo 5 no capturaba porque operaba bajo la definición estándar de realismo. |
| Cap 7 (Normativo) | Análogo estructural: la “soberanía popular” como conjunción reificada de decisiones individuales. El Teorema de Incompetencia Reflexiva (Cap 7) es el análogo normativo de A4: un lema que se impone sin demostración |

Conexión con la tesis central del libro

La elisión axiomática en la recepción estándar del teorema de Bell es un caso paradigmático de reificación de una conjunción lógica. El discurso trata $R \wedge L \wedge CFD$ como si fuera una sola cosa (“el realismo local”), y al refutar uno de los componentes (CFD), transfiere la refutación a los otros dos (R y L). Esto es exactamente la estructura del protocolo: atribuir a una estructura relacional (conjunción) propiedades de sustancia (hipótesis unitaria inseparable).

La des-reificación consiste en restaurar la transitividad canónica:

Oración reificada: “Bell refutó el realismo local.”

Oración des-reificada: “Bell demostró que la conjunción de realismo, localidad y definición contracausal bajo estructura probabilística clásica es insostenible; el realista puede preservar realismo y localidad renunciando a la definición contracausal.”

Conexión con la renuncia ontológica (Cap 5, sección 5.6.2)

El Capítulo 5 identificó un patrón: el progreso científico ocurre cuando renunciamos a buscar “causas ocultas” para fenómenos que tienen explicaciones estructurales. El caso de Bell es una instancia de este patrón: la intuición exige una distribución conjunta (una “tabla de valores” oculta) para explicar las correlaciones. La renuncia ontológica aquí es renunciar a esa tabla, aceptando que las correlaciones cuánticas no requieren una distribución conjunta clásica.

| Fenómeno | Intuición (causa oculta) | Física (estructura manifiesta) |
|---|---|---|
| Movimiento | Impetus (fuerza motriz) | Simetría de traslación (Noether) |
| Gravedad | Fuerza gravitacional | Geometría curvada (Einstein) |
| Entrelazamiento | Variables ocultas / acción a distancia | No-separabilidad (Hilbert) |
| Correlaciones Bell | Distribución conjunta (CFD) | Modelo contextual (4 distribuciones separadas) |

---

## 6.10 Síntesis de demostraciones formales del capítulo [A-Meta]

Nosotros presentamos la siguiente tabla de demostraciones formales en prosa integradas en este capítulo. Estas pruebas elevan el estatus epistémico de las secciones 6.2–6.4 de [A-Código] a [A-Meta] + [A-Código], replicando el protocolo del Capítulo 8.

| Designación | Enunciado | Método | Sección |
|---|---|---|---|
| T-Cons | Consistencia del sistema base $\Sigma$ | Exhibición de modelo | 6.2.5 |
| T-Ind | Independencia de A4 respecto a $\Sigma$ | Dos modelos | 6.2.5 |
| T-NDev | $\Sigma \not\vdash (R \land L) \rightarrow JD$ | Reducción al absurdo semántico | 6.2.5 |
| T-Equiv | $\Sigma \cup \{A4\} \vdash \neg(R \land L)$ | Cadena de implicaciones + T1 | 6.2.5 |
| T1 | Inconsistencia de $R \land L \land JD$ | Modus ponens + aritmética | 6.3 |
| T2 | Inconsistencia con A4 invocado | Modus ponens + T1 | 6.3 |
| T3 | Existencia del escape contextual | Exhibición de modelo | 6.3 |
| T4 | Neutralidad epistemológica | Exhibición de modelo | 6.3 |
| T5 | $\Sigma \cup \{R,L,A6\} \vdash \neg JD$ | Reducción al absurdo | 6.3 |
| T5-Cor | Bajo $\Sigma \cup \{R,L,A6\}$, se sigue $SUC$ y $\neg SIJ$ | A2 + A8 | 6.3 |
| T6 | Invalidez de la inferencia estándar | Exhibición de modelo | 6.3 |
| T7 | Viabilidad con $\neg A4$ | Exhibición de modelo | 6.3 |
| T-Alg | $S_{ctx} = -2\sqrt{2}$ y $|S_{ctx}| > 2$ | Sustitución algebraica directa | 6.2.4 |
| T-Fine | $|S_{ctx}|>2 \land R \land L \Rightarrow \neg JD$ | Reducción al absurdo + A3/A5 | 6.2.4 |
| T-Coh | Coherencia fuerza contextual para $R \land L$ | Análisis de casos (4 modelos) | 6.4.5 |
| T-Opt | Optimalidad de $AS_{23}$ | Análisis de costos lexicográficos | 6.4.5 |
| T-NoAtr | $joint_model$ no es atractor | Dominancia lexicográfica | 6.4.5 |
| T-Frag | Fragmentación en $t=3$ | Inspección constructiva | 6.4.5 |

Conclusión metodológica [C]. El Capítulo 6 posee materia prima para las demostraciones formales en prosa que ahora aparecen integradas junto a los outputs de Z3/Clingo. Estas pruebas son correctas, completas y verificables por un lector con formación básica en lógica proposicional, teoría de modelos elemental y análisis de optimización lexicográfica.

---

## Etiquetado del capítulo

| Sección | Contenido | Clasificación |
|---|---|---|
| 6.0 | Introducción | [C] Interpretación |
| 6.1 | Protocolo de cuatro preguntas | [C] Interpretación |
| 6.2 | Formalización Z3 (axiomas y metateoremas) | [A-Meta] + [A-Código] |
| 6.2.4 | Verificación algebraica del modelo contextual | [A-Meta] + [A-Código] |
| 6.2.5 | Metateoremas del sistema axiomático Z3 | [A-Meta] |
| 6.3 | Siete teoremas Z3 | [A-Meta] + [A-Código] |
| 6.4 | Clingo: dinámica epistémica | [A-Meta] + [A-Código] |
| 6.4.5 | Metateoremas de la dinámica Clingo | [A-Meta] |
| 6.5 | Literatura (Fine, Pitowsky, Spekkens, Bell) | [B] Citada de fuente |
| 6.6 | Pedagogía de Bell | [B/C] |
| 6.7 | Debate filosófico (realismo mínimo vs. CFD) | [C] Interpretación |
| 6.8 | Limitaciones | [C] Interpretación |
| 6.9 | Conexiones | [C] Interpretación |
| 6.10 | Síntesis de demostraciones formales | [A-Meta] + [C] |

---

## Resumen de códigos verificados en este capítulo

| Herramienta | Código | Resultado | Verificado |
|---|---|---|---|
| Z3 | T1: $R \wedge L \wedge JD$ | unsat + unsat core | ✓ |
| Z3 | T2: $A4 \wedge R \wedge L$ | unsat + unsat core (incluye A4_Invoked) | ✓ |
| Z3 | T3: $R \wedge L \wedge SUC \wedge \neg JD$ | sat con modelo concreto | ✓ |
| Z3 | T4: $FourSub \wedge OnlyData \wedge SUC$ | sat | ✓ |
| Z3 | T5: $R \wedge L \wedge S=2{,}828$ | sat con $JD=false$ | ✓ |
| Z3 | T6: $\neg(R \wedge L \wedge JD) \wedge R \wedge L$ | sat | ✓ |
| Z3 | T7: $\neg A4 \wedge R \wedge L \wedge SUC$ | sat | ✓ |
| Z3 | Modelo contextual (Def. 6.2.4) | sat con $S_{ctx} = -2\sqrt{2}$, violación CHSH (verificación algebraica) | ✓ |
| Clingo | Dinámica epistémica (5 agentes, 4 modelos, 3 tiempos) | OPTIMUM FOUND, contextual como atractor | ✓ |

---

## Apéndice: Script contextual_model_z3.smt2

```lisp
; ============================================================
; Z3: VERIFICACIÓN ALGEBRAICA DEL MODELO CONTEXTUAL
; ============================================================
; NOTA: Este script verifica la consistencia algebraica de las 
; correlaciones cuánticas y su violación de CHSH. No construye 
; explícitamente distribuciones de probabilidad P_xy con variables 
; aleatorias A_xy(w), B_xy(w) en {+1,-1}. Eso excede el alcance 
; de esta verificación formal.
; ============================================================

(set-option :produce-models true)

; ------------------------------------------------------------
; 1. sqrt(2) como constante real no interpretada
; ------------------------------------------------------------
(declare-const sqrt2 Real)
(assert (= (* sqrt2 sqrt2) 2.0))
(assert (> sqrt2 0.0))

; ------------------------------------------------------------
; 2. CORRELACIONES CUÁNTICAS para cada sub-experimento
; ------------------------------------------------------------
(declare-const E_ab Real)   ; E(a,b)   = -cos(0 - pi/4)     = -sqrt2/2
(declare-const E_abp Real)  ; E(a,b')  = -cos(0 - 3pi/4)    = +sqrt2/2
(declare-const E_apb Real)  ; E(a',b)  = -cos(pi/2 - pi/4)  = -sqrt2/2
(declare-const E_apbp Real) ; E(a',b') = -cos(pi/2 - 3pi/4) = -sqrt2/2

; Asignación de valores exactos
(assert (= E_ab    (- (/ sqrt2 2.0))))
(assert (= E_abp   (/ sqrt2 2.0)))
(assert (= E_apb   (- (/ sqrt2 2.0))))
(assert (= E_apbp  (- (/ sqrt2 2.0))))

; ------------------------------------------------------------
; 3. COMBINACIÓN CHSH EN EL MODELO CONTEXTUAL
; ------------------------------------------------------------
(declare-const S_ctx Real)
(assert (= S_ctx (+ (- E_ab E_abp) (+ E_apb E_apbp))))

; Verificamos que S_ctx = -2*sqrt2
(assert (= S_ctx (- (* 2.0 sqrt2))))

; ------------------------------------------------------------
; 4. VIOLACIÓN DE LA COTA CHSH (Teorema de Fine)
; ------------------------------------------------------------
(declare-const CHSH_bound Real)
(assert (= CHSH_bound 2.0))

; Demostramos que S_ctx < -2 (violación por debajo)
(assert (< S_ctx (- CHSH_bound)))

; ------------------------------------------------------------
; 5. VERIFICACIÓN DE CONSISTENCIA
; ------------------------------------------------------------
(check-sat)
(get-model)
```

Resultado verificado: `sat` con modelo algebraico exacto donde `S_ctx = -2√2 ≈ -2.828`, violando la cota `|S| ≤ 2`. Esto demuestra que las cuatro correlaciones cuánticas, tratadas como objetos matemáticos independientes (no como marginales de una distribución conjunta), son consistentes entre sí. Por el teorema de Fine (1982), la violación implica que no existe una distribución conjunta `P(A,A',B,B')` que las genere como marginales.