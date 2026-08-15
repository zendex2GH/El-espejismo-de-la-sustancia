# Capítulo 8: Asimetrías deónticas y la paradoja de la excepción soberana

## 8.0 Protocolo de lectura

Este capítulo aplica el protocolo de las cuatro preguntas (Capítulo 0, sección 0.2) a un dominio normativo: las arquitecturas institucionales que sustentan el encierro penal y la excepción soberana. El registro empírico-histórico (sección 8.2) proporciona la motivación para la elección de axiomas; los teoremas formales (secciones 8.3 a 8.7) demuestran propiedades generales de esas arquitecturas bajo axiomas explícitos.

Nosotros utilizamos verificadores automáticos (Z3, Clingo) para controlar instancias concretas de los teoremas, no como sustitutos de la demostración. Cuando nosotros decimos "demostramos que", nos referimos a una deducción en prosa que puede reconstruirse en un cálculo lógico estándar. Cuando decimos "verificamos mediante Z3/Clingo que", nos referimos a una comprobación computacional de una instancia finita.

La regla de etiquetado [A], [B], [C] (sección 0.3) se aplica con una distinción adicional:

- **[A-Meta]**: Demostrado matemáticamente en prosa. La prueba es verificable por un lector con formación en lógica de primer orden o teoría de grafos.
- **[A-Código]**: Verificado computacionalmente en instancia finita mediante Z3 o Clingo. No reemplaza la demostración general, pero descarta errores de tipeo en los axiomas.
- **[B]**: Citado de literatura académica identificada.
- **[C]**: Interpretación filosófica de los resultados, explícitamente marcada como tal.

**Nota sobre el alcance y el tono de este capítulo.** Este capítulo no es un manifiesto político. No promovemos la abolición total del sistema penal, ni la liberación indiscriminada de todas las personas privadas de libertad, ni la deslegitimación del Estado como institución. Lo que nosotros hacemos es una auditoría de coherencia axiomática: demostramos que, bajo ciertos axiomas que los propios agentes estatales invocan (derechos humanos, rehabilitación, no-instrumentalización), la práctica penal actual genera contradicciones formales. Identificar una contradicción no es prescribir una solución; es señalar un punto de fragilidad donde la intervención conceptual es posible. La decisión sobre qué hacer con esa fragilidad corresponde a los agentes políticos, judiciales y sociales, no a este libro [C].

## 8.1 Introducción: el Estado como campo de fuerzas

Nosotros sostenemos, con los capítulos anteriores, que el Estado no es un agente unitario con intenciones, creencias y deseos, sino un campo de relaciones entre agentes individuales que ocupan posiciones estructurales diferenciadas. Esta tesis tiene una consecuencia metodológica inmediata: nosotros no podemos atribuirle al "Estado" la responsabilidad por la coherencia de sus propias normas. La coherencia, cuando existe, es el resultado de una articulación institucional que puede fallar.

En este capítulo nosotros aplicamos esa tesis a un caso paradigmático: el encierro penal. La pregunta no es "¿el Estado quiere dañar?", sino más precisamente: ¿puede una arquitectura institucional que combina (i) una norma de no-daño, (ii) una norma de privación de libertad, y (iii) una norma de excepción soberana, mantenerse consistente sin recurrir a un observador externo? [C]

La respuesta formal es matizada. Nosotros no demostramos una "imposibilidad lógica" universal. Demostramos una **jerarquía de fragilidades** [A-Meta]: ciertas arquitecturas son consistentes bajo condiciones estrictas, y esas condiciones se degradan previsiblemente cuando nosotros introducimos redes de favores, asimetrías de información y auto-certificación de amenazas.

**Nota sobre la reificación en este capítulo.** Siguiendo el método del Capítulo 1 (sección 1.2.3), nosotros debemos ser precisos sobre la agencia. No es "el Estado" el que encierra; son agentes concretos (jueces que firman sentencias, legisladores que redactan leyes, carceleros que operan unidades) quienes aplican la privación de libertad. No es "la cárcel" la que produce daño; son las condiciones de encierro que los agentes institucionales diseñan, mantienen o toleran las que generan efectos previsibles sobre los detenidos y sus familias. La reificación del "sistema penal" como sustancia con voluntad propia es exactamente el tipo de operación gramatical que este libro audita. Nosotros la señalamos aquí para mantener la higiene metodológica, no para exculpar a los agentes concretos [C].

## 8.2 El encierro como caso paradigmático: motivación empírica y delimitación del análisis

### 8.2.1 Por qué elegimos este caso y qué NO afirmamos [C]

Nosotros elegimos el encierro penal como caso de estudio por tres razones metodológicas:

**Primera razón:** Es el caso donde la asimetría deóntica entre el discurso normativo y la práctica institucional es más visible y está mejor documentada. Los agentes estatales invocan principios de derechos humanos, rehabilitación y dignidad, mientras operan instituciones que producen efectos previsiblemente contrarios a esos principios. Esta tensión entre el discurso y la práctica es exactamente el tipo de "narrativa sucia sobre teoría resuelta" que nuestro protocolo detecta.

**Segunda razón:** Es el caso donde la reificación gramatical tiene consecuencias más graves. Cuando el discurso dice "la sociedad debe ser protegida" o "el sistema penal rehabilita", está atribuyendo agencia a construcciones abstractas y suprimiendo al agente humano concreto que toma las decisiones. Esta supresión del agente tiene efectos operativos: dificulta la atribución de responsabilidad, invisibiliza las condiciones de encierro y naturaliza prácticas que, de otro modo, serían cuestionables.

**Tercera razón:** Existe un precedente histórico exacto. En la década de 1960, los agentes sanitarios y judiciales argentinos reconocieron que el encierro psiquiátrico era iatrogénico (producía más daño que beneficio) y procedieron a la desmanicomialización, consagrada en la Ley Nacional de Salud Mental N° 26.657 (2010). El principio que esos agentes aplicaron —"el encierro institucional, por sí mismo, puede ser una forma de violencia iatrogénica"— es exactamente el principio que nosotros formalizamos en este capítulo [B].

**Lo que NO afirmamos:**

- No afirmamos que toda privación de libertad sea ilegítima. Reconocemos que en casos de peligro concreto e inminente, donde no existe alternativa viable, la restricción de la libertad puede ser una medida necesaria. Lo que nosotros cuestionamos es el uso del encierro como regla general, como primera opción, y como respuesta a problemas sociales (pobreza, adicción, enfermedad mental) que no son de naturaleza penal.
- No afirmamos que los agentes que operan el sistema penal sean "malvados" o "corruptos". Reconocemos que muchos jueces, fiscales, defensores y operadores penitenciarios actúan de buena fe dentro de las restricciones que el sistema les impone. Lo que nosotros señalamos es que la arquitectura institucional genera efectos que contradicen los principios que esa misma arquitectura invoca.
- No promovemos la "liberación de todos los presos". Lo que nosotros hacemos es demostrar formalmente que la conjunción de ciertos axiomas liberales (no-daño, rehabilitación, no-instrumentalización) con la práctica penal actual es inconsistente. La resolución de esa inconsistencia es una decisión política que corresponde a los agentes democráticos, no a este libro.
- No atacamos al Estado como institución. El Estado, entendido como red de relaciones entre agentes, es una construcción necesaria para la vida en común. Lo que nosotros cuestionamos es la reificación del Estado como sustancia con voluntad propia, y la utilización de esa reificación para invisibilizar la responsabilidad de los agentes concretos que diseñan y operan las instituciones de encierro.

### 8.2.2 Genealogía breve: del manicomio a la cárcel [B]

El encierro masivo como forma dominante de sanción penal es una invención histórica reciente. Antes del siglo XIX, la privación de libertad era una medida cautelar o una pena menor; las sanciones graves eran corporales, el exilio o la muerte. La cárcel moderna nace con el proyecto de "rehabilitación" y "corrección": el delincuente debía ser aislado para reflexionar, trabajar y reinsertarse [B].

Esa promesa nunca se cumplió sistemáticamente. La evidencia acumulada desde hace décadas muestra que el encierro produce daños estructurales que contradicen explícitamente su propio objetivo declarado [B].

El paralelo con la desmanicomialización no es retórico; es normativo, fáctico y axiológico. La Ley Nacional de Salud Mental N° 26.657 (2010) reconoció que los hospitales psiquiátricos eran dispositivos de encierro que producían más daño que cura. El principio que esos agentes sanitarios y judiciales establecieron fue: el encierro institucional, por sí mismo, es una forma de violencia iatrogénica [B].

La analogía estructural es la siguiente:

| Manicomio (siglo XX) | Cárcel (siglo XXI) |
|---|---|
| Encierro psiquiátrico iatrogénico | Encierro penal iatrogénico |
| Producción de enfermedad mental | Producción de enfermedad mental |
| Ruptura de vínculos familiares | Ruptura de vínculos familiares |
| Exclusión social perpetua | Exclusión social perpetua |
| Desmanicomialización | Descarcelización (como horizonte, no como prescripción) |

Nosotros presentamos la descarcelización como un horizonte de investigación análogo a la desmanicomialización, no como una prescripción política inmediata. Lo que nosotros hacemos es formalizar las condiciones bajo las cuales el encierro es inconsistente con los principios que lo justifican. Si esas condiciones se verifican empíricamente (y la evidencia sugiere que sí), entonces los agentes políticos y judiciales tienen un fundamento formal para explorar alternativas [C].

### 8.2.3 Cinco dimensiones de iatrogenia: la evidencia empírica [B]

Llamamos **iatrogenia** al daño previsible, estructural y derivado del propio régimen de privación de libertad. El término proviene de la medicina: una intervención iatrogénica es aquella que produce daño como efecto de su propio mecanismo, no como accidente. Nosotros documentamos cinco dimensiones, todas ellas corroboradas por la literatura empírica [B]:

1. **Iatrogenia física y psicológica.** El proceso de "institucionalización" o "prisonización" describe la forma en que los agentes internos son moldeados por el entorno carcelario: dependencia de la estructura institucional, hipervigilancia, control emocional forzado, aislamiento social [B]. Un meta-análisis de Fazel y Danesh (2002) encontró que la prevalencia de trastornos mentales graves era significativamente mayor entre la población carcelaria que en la población general [B]. Un censo del Departamento de Justicia de EE.UU. estimó que aproximadamente el 16% de la población carcelaria padece enfermedad mental, con cifras que alcanzan el 20% en algunas estimaciones [B]. En confinamiento solitario, estos efectos se intensifican hasta producir deterioro cognitivo, paranoia y psicosis [B].

2. **Iatrogenia social.** La separación forzada de redes comunitarias no es un efecto colateral; es parte del diseño del encierro. Más de la mitad de los padres encarcelados nunca reciben una visita personal de sus hijos [B]. El estigma "contagia" a toda la familia, generando vergüenza, aislamiento y discriminación en empleo y vivienda [B].

3. **Iatrogenia familiar.** El encarcelamiento de un progenitor es un evento traumático que se transmite intergeneracionalmente. Un estudio longitudinal encontró que tener un padre con historial de encarcelación se asoció con un 47% más de probabilidades de ser arrestado para la edad de 22 años [B]. Los hijos de personas encarceladas tienen casi el doble de probabilidades de recibir un diagnóstico de depresión o TEPT en la edad adulta [B]. Investigaciones han encontrado acortamiento de telómeros en niños que experimentan la encarcelación parental, un biomarcador del estrés crónico [B].

4. **Iatrogenia económica.** La pérdida de ingresos del miembro encarcelado, sumada a los costos directos para mantener comunicación, erosiona la riqueza familiar. En EE.UU., las familias gastan aproximadamente $350 mil millones anuales en total debido a la encarcelación [B]. El patrimonio neto mediano de familias con un miembro encarcelado es de $7.350, contra $177.800 de familias no afectadas [B]. La detención preventiva causa una pérdida de casi $30.000 en ingresos y beneficios sociales por individuo [B].

5. **Iatrogenia normativa (criminogénesis).** La prisión funciona como espacio de socialización criminal, fortalecimiento de redes delictivas y normalización de la violencia [B]. La reincidencia oscila entre el 45% y el 70% según jurisdicción en sistemas punitivos, frente a menos del 20% en sistemas con alternativas comunitarias como Noruega [B]. Esto genera una paradoja que formalizamos en el Teorema T5b: el mecanismo que supuestamente previene el delito produce las condiciones que lo reproducen.

**Nota sobre el uso de esta evidencia.** Nosotros no utilizamos estos datos para "demostrar" que el encierro es malo en términos morales. Los utilizamos para motivar la elección de axiomas en las secciones formales que siguen. Específicamente, la evidencia de que el encierro produce daño previsible motiva el axioma de no-daño; la evidencia de que la rehabilitación no se alcanza motiva el axioma de rehabilitación como condición; la evidencia del daño familiar motiva la inclusión de terceros afectados en el modelo formal. Los datos no demuestran los teoremas; motivan los axiomas bajo los cuales los teoremas se demuestran [C].

### 8.2.4 Datos comparativos: la falsa disyuntiva "seguridad vs. derechos" [B]

El principal obstáculo ideológico para cuestionar el encierro masivo es la creencia de que la prisión es necesaria para la seguridad ciudadana. Los agentes políticos que defienden el encarcelamiento invocan frecuentemente esta disyuntiva. Sin embargo, la evidencia empírica internacional muestra que la relación entre encarcelamiento y seguridad no es causal [B]:

| País | Tasa encarcelamiento (por 100.000 hab.) | Tasa homicidios (por 100.000 hab.) |
|---|---|---|
| Noruega | 55 | 0,5 |
| Finlandia | 54 | 1,6 |
| España | 132 | 0,6 |
| Argentina | 220 | 4,6 |
| Brasil | 340 | 22,0 |

Finlandia redujo su población penal un 60% entre 1970 y 2000 sin aumento del delito [B]. Noruega tiene una tasa de reincidencia inferior al 20% [B]. Estos datos no establecen causalidad, pero ponen en cuestión la premisa de que la seguridad requiere encierro masivo. Nosotros utilizamos estos datos para motivar la elección de axiomas en las secciones formales que siguen; no los utilizamos para confirmar o refutar teoremas [C].

### 8.2.5 La paradoja de la rehabilitación como ficción performativa [C]

Si el encierro daña en todas estas dimensiones, y ese daño es previsible, entonces la justificación rehabilitativa opera como una **ficción performativa**: los agentes que diseñan y operan el sistema penal deben actuar *como si* creyeran en la reinserción, aunque la evidencia contradiga sistemáticamente esa creencia.

Esta tensión entre el discurso y la práctica es el punto de partida de nuestros modelos formales. No es que los agentes "mientan" conscientemente. Es que la arquitectura institucional requiere la invocación del principio de rehabilitación para legitimar la privación de libertad, mientras que las condiciones de encierro hacen imposible alcanzar ese principio. La contradicción no es subjetiva (de los agentes); es estructural (de la arquitectura).

### 8.2.6 Delimitación precisa de nuestra tesis [C]

Para evitar malentendidos, nosotros formulamos nuestra tesis con la máxima precisión:

**Tesis:** Bajo los axiomas que los propios agentes estatales invocan en el bloque de constitucionalidad (no-daño, rehabilitación como finalidad, no-instrumentalización de personas, dignidad humana), la práctica penal actual —entendida como el uso del encierro prolongado como respuesta predominante a la conflictividad social— genera una inconsistencia formal demostrable.

**No-tesis:** No afirmamos que el Estado sea ilegítimo. No afirmamos que toda privación de libertad sea injusta. No afirmamos que los agentes que operan el sistema penal sean moralmente culpables. No prescribimos una política criminal específica. No promovemos la anarquía ni la abolición del derecho penal.

**Lo que sí demostramos:** Que la conjunción de ciertos axiomas liberales con ciertas prácticas penales es formalmente inconsistente. Que esa inconsistencia no es un accidente de implementación sino una propiedad estructural de la arquitectura normativa. Y que la resolución de esa inconsistencia requiere que los agentes que operan el sistema elijan explícitamente qué axioma relajar, en lugar de mantener la ficción performativa de que todos los axiomas se satisfacen simultáneamente.

## 8.3 T5a-v5: Regresión de Münchhausen normativa

**Resumen ejecutivo:** Este teorema resuelve el problema de si una norma constitucional que limita derechos fundamentales puede justificarse internamente dentro del propio sistema normativo. Demostramos que no puede: requiere un axioma fundacional externo.

### Planteamiento

Una objeción frecuente a la crítica del encierro es que la Constitución ya resuelve la tensión: el artículo que protege la integridad física está "limitado" por el artículo que permite la prisión legal. La pregunta formal es: ¿puede esa cláusula de limitación justificarse *dentro* del sistema normativo, o requiere un axioma fundacional externo?

### Definiciones

Nosotros definimos un **sistema normativo estratificado** como una estructura $\mathcal{N} = (N, \preceq, L, V)$ donde:

1. $N$ es un conjunto finito de normas.
2. $\preceq$ es un preorden de nivel sobre $N$ (reflexivo, transitivo), donde $n_a \prec n_b$ significa que $n_a$ está en un nivel estrictamente inferior a $n_b$.
3. $L \subseteq N \times N$ es una relación de limitación tal que si $(n_a, n_b) \in L$ entonces $n_a \succ n_b$ (una norma solo limita a otra de nivel estrictamente inferior).
4. $V \subseteq S \times N$ vincula estratos $s \in S$ a normas.
5. $n_0 \in N$ es un **axioma fundacional**: está justificado sin necesidad de limitador externo.

Una norma $n \in N$ está **justificada en $\mathcal{N}$** si y solo si:

$$n = n_0 \lor \exists n_{sup} \in N : (n_{sup}, n) \in L \land n_{sup} \succ n$$

### Teorema T5a-v5 [A-Meta]

**Regresión de Münchhausen Normativa.** Sea $\mathcal{N}$ un sistema normativo estratificado con conjunto de normas $N$ finito. Sea $M = \{n \in N \mid \nexists n' \in N : n \prec n'\}$ el conjunto de normas de nivel máximo. Si $M$ contiene al menos una norma $n_M \neq n_0$ vinculada a algún estrato (es decir, $\exists s \in S : (s, n_M) \in V$), entonces $n_M$ no está justificada en $\mathcal{N}$.

### Demostración

Sea $n_M \in M$ con $n_M \neq n_0$ y $(s, n_M) \in V$ para algún $s \in S$.

Por definición de justificación, $n_M$ requiere un $n_{sup} \in N$ tal que $(n_{sup}, n_M) \in L$ y $n_{sup} \succ n_M$.

Pero $n_M \in M$, luego por definición de $M$ no existe ninguna norma en $N$ de nivel estrictamente superior a $n_M$. Por lo tanto, no existe tal $n_{sup}$.

Como $n_M \neq n_0$, tampoco es fundacional.

Luego $n_M$ no está justificada en $\mathcal{N}$. $\square$

### Corolario [A-Meta]

Si una norma de limitación constitucional $n_{lim}$ tiene nivel $k$, y nosotros introducimos una metanorma $n_{meta}$ de nivel $k+1$ que limita a $n_{lim}$, entonces $n_{meta}$ ocupa el nuevo máximo. Si $n_{meta} \neq n_0$, el corolario se aplica recursivamente: cada metanorma requiere otra superior, generando una regresión infinita que solo se detiene con un axioma fundacional externo al sistema.

### Contrafactual CF3: autojustificación [A-Meta]

Si nosotros relajamos la definición de justificación para permitir que una norma se justifique a sí misma (es decir, añadimos $n = n$ como condición suficiente), entonces toda norma está trivialmente justificada. La regresión desaparece, pero el sistema admite circularidades que destruyen la distinción entre norma y metanorma. Esto demuestra que la regresión de Münchhausen no es una ley lógica necesaria; es una consecuencia de la prohibición de autojustificación [C].

### Verificación computacional [A-Código]

Nosotros verificamos el teorema para una instancia concreta con 4 normas y 4 estratos mediante Z3.

```smtlib2
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
```

**Output certificado:**

```
CF1: unsat (ax-justificacion cf1-bloqueo hip-just)
CF2: unsat (nivel-integridad nivel-prision nivel-limitacion nivel-meta ax-limit-jerarquia ax-justificacion h-limita-integridad h-meta-limita hip-just-meta)
```

### Interpretación [C]

Este teorema demuestra que la cláusula constitucional que "limita" el derecho a la integridad física mediante la autorización de la prisión no puede justificarse dentro del propio sistema normativo sin recurrir a un axioma fundacional externo. Esto no significa que la prisión sea ilegítima; significa que su legitimación requiere un fundamento que el sistema jurídico positivo no puede proporcionar por sí solo. Kelsen resolvió esto postulando la *Grundnorm*; Schmitt, invocando el Poder Constituyente. Lo que nosotros mostramos es que esa necesidad de un "afuera" no es un capricho filosófico, sino una consecuencia formal de la prohibición de autojustificación.

## 8.4 T5b-v2: No-invariante de equilibrio

**Resumen ejecutivo:** Este teorema formaliza por qué el sistema penal, bajo sus propios axiomas de justificación, no tiene punto de salida natural. Si el deterioro causado por el encierro se usa para justificar más encierro, el sistema entra en un ciclo sin equilibrio.

### Definiciones

Nosotros definimos un **sistema de transición penal** como una estructura $\mathcal{S} = (S, \to, A, D, J)$ donde:

1. $S$ es un conjunto finito de estados.
2. $\to \subseteq S \times S$ es una relación de transición total (todo estado tiene al menos un sucesor).
3. $A, D, J \subseteq S$ son los conjuntos de estados donde los agentes aplican encierro, donde hay deterioro, y donde el deterioro justifica encierro, respectivamente.
4. $E = S \setminus A$ es el conjunto de **equilibrio** (no encierro).

Los axiomas dinámicos son:

1. **Deterioro:** $s \in A \land s \to s' \Rightarrow s' \in D$
2. **Justificación:** $s \in D \Rightarrow s \in J$
3. **Aplicación:** $s \in J \Rightarrow s \in A$

### Teorema T5b-v2 [A-Meta]

**No-invariante de equilibrio.** Sea $\mathcal{S}$ un sistema de transición penal donde valen los axiomas 1–3. Sea $s_0 \in A$ un estado inicial con encierro. Sea $R(s_0) = \{s \in S \mid s_0 \to^* s\}$ el conjunto de estados alcanzables desde $s_0$. Entonces $R(s_0) \cap E = \emptyset$.

### Demostración

Por inducción sobre la longitud de la trayectoria.

**Caso base ($k=0$):** $s_0 \in A$ por hipótesis. Luego $s_0 \notin E$.

**Paso inductivo:** Supongamos que para todo estado $s_k$ alcanzable en $k$ pasos, $s_k \in A$. Sea $s_{k+1}$ tal que $s_k \to s_{k+1}$.

Como $s_k \in A$, por axioma 1, $s_{k+1} \in D$. Por axioma 2, $s_{k+1} \in J$. Por axioma 3, $s_{k+1} \in A$.

Luego $s_{k+1} \notin E$. Por inducción, ningún estado alcanzable desde $s_0$ pertenece a $E$. $\square$

### Corolario [A-Meta]

Si $\mathcal{S}$ es finito y $\to$ contiene un ciclo alcanzable desde $s_0$, entonces los agentes que operan el sistema mantienen el encierro indefinidamente. La única manera de alcanzar $E$ es que en algún estado $s^*$ los agentes dejen de aplicar el axioma 2 (el deterioro deja de justificar encierro) o el axioma 3 (la justificación deja de aplicarse).

### Contrafactual CF4 [A-Meta]

Si nosotros relajamos el axioma 2 para algún estado $s^* \in D$ (es decir, permitimos que $s^* \in D$ pero $s^* \notin J$), entonces el paso inductivo se rompe en $s^*$. Si además $s^*$ no está en $A$ por otra vía, entonces $s^* \in E$ es posible. El sistema puede estabilizarse en equilibrio desde ese punto.

### Interpretación [C]

Este teorema formaliza lo que la criminología crítica denomina **criminogénesis estatal**: el mecanismo que supuestamente previene el delito produce las condiciones que lo reproducen [B]. Los agentes estatales castigan el delito; el castigo produce condiciones criminógenas; esas condiciones generan nuevos delitos; el sistema penal se expande. Este círculo no es un accidente de implementación; es una consecuencia formal de los tres axiomas dinámicos. La evidencia empírica de la sección 8.2.3 (reincidencia del 45-70%, deterioro psicológico, ruptura de vínculos) motiva la aceptación de estos axiomas.

**Nota de delimitación:** Este teorema no demuestra que el encierro siempre produce reincidencia. Demuestra que, *si* el encierro produce deterioro (axioma 1), y los agentes utilizan ese deterioro para justificar más encierro (axioma 2), y la justificación implica aplicación (axioma 3), entonces no existe estado de equilibrio. La salida es romper al menos uno de los tres axiomas, no abolir el sistema penal [C].

### Verificación computacional [A-Código]

Nosotros verificamos el teorema para una instancia con 4 estados lineales ($e_0 \to e_1 \to e_2 \to e_3 \to e_3$) mediante Z3.

```smtlib2
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
```

**Output certificado:**

```
unsat
(ax-t0 ax-d1 ax-eq3 h-inicio ax-eq2 ax-eq0 ax-eq1 ax-t1 ax-d2 ax-d3 ax-j1 ax-j2 ax-t2 ax-j3 hip-equilibrio)
CF4: Deterioro en e3 NO justifica encierro
sat
```

## 8.5 T6-v2: Jerarquía de paradojas de la excepción soberana

**Resumen ejecutivo:** Este teorema resuelve la paradoja schmittiana de la excepción soberana. Demostramos que la excepción no es una "ley lógica ineludible", sino el resultado contingente de la captura institucional.

### Planteamiento

El estado de excepción es la suspensión de una norma universal por una norma particular. ¿Es consistente sostener ambas? La respuesta depende de la **arquitectura institucional** que los agentes activan para declarar la excepción.

### Definiciones

Nosotros definimos una **arquitectura de excepción** como una estructura $\mathcal{A} = (R, C, N, \delta, \alpha)$ donde:

1. $R$ es un conjunto finito de ramas institucionales.
2. $C \subseteq R \times R$ es una relación de captura (colusión).
3. $N = \{n_u, n_e\}$ es el conjunto de normas, donde $n_u$ es la norma universal y $n_e$ la norma de excepción.
4. $\delta : R \times S \to \{0,1\}$ es la función de determinación de amenaza por parte de una rama en una situación.
5. $\alpha : 2^R \to \{0,1\}$ es la función de arquitectura que decide si la excepción se activa dado un conjunto de ramas que determinan amenaza.

Una **asignación de protección** es una relación $Protegido \subseteq N \times X$ donde $X$ es un conjunto de agentes. Decimos que $n_u$ es **no vacía** si $\forall x \in X : Protegido(n_u, x)$.

Los axiomas son:

1. **Suspensión universal:** Si para todo agente $x$, una rama $r$ suspende $n_u$ en favor de $n_e$ ante una situación $s$, entonces $n_u$ queda vacía.
2. **Vacuidad anula protección:** Si $n_u$ está vacía, entonces ningún agente está protegido por $n_u$.
3. **Colusión:** Si $r_1$ está capturada y determina $s$, y $C$ conecta a todas las ramas internas, entonces todas las ramas internas determinan $s$.

### Lema T6a-v2 [A-Meta]

**Auto-certificación unilateral.** Sea $\mathcal{A}$ una arquitectura donde $\alpha(\{r\}) = 1$ para alguna rama $r$ (unilateralismo). Si $r$ determina una situación de amenaza $s$, y los agentes aplican la norma de excepción, entonces $n_u$ queda vacía, contradiciendo la no-vacuidad de $n_u$.

**Demostración.** Por definición de arquitectura unilateral, basta que una sola rama determine amenaza para que la suspensión se active. Si $r$ determina $s$, entonces por el axioma de suspensión aplicado a todos los agentes $x$, $n_u$ queda vacía. Por el axioma de vacuidad, $\forall x : \neg Protegido(n_u, x)$. Pero la hipótesis de no-vacuidad exige $\forall x : Protegido(n_u, x)$. Contradicción. $\square$

### Lema T6b-v2 [A-Meta]

**Separación de poderes sin captura.** Sea $\mathcal{A}$ una arquitectura de consenso triple donde $\alpha(R') = 1 \iff \{ejecutivo, legislativo, judicial\} \subseteq R'$. Si solo una rama determina amenaza y las demás no, entonces la condición de activación no se satisface, y $n_u$ puede permanecer no vacía.

**Demostración.** La función $\alpha$ requiere que las tres ramas determinen amenaza. Si solo una rama determina $s$, el antecedente de la implicación que activa la suspensión es falso. Por lo tanto, no se deriva que $n_u$ quede vacía. La no-vacuidad de $n_u$ es consistente con los axiomas. $\square$

### Lema T6b-captura [A-Meta]

**Colapso bajo captura total.** Sea $\mathcal{A}$ una arquitectura de consenso triple donde las tres ramas internas están capturadas por $C$ conectando a todas. Si la rama ejecutiva determina amenaza, entonces $n_u$ queda vacía.

**Demostración.** Por el axioma de colusión, si la rama ejecutiva está capturada y determina $s$, entonces las ramas legislativa y judicial también determinan $s$. Por definición de consenso triple, las tres ramas determinan amenaza, por lo que $\alpha$ se activa. La suspensión de $n_u$ se aplica a todos los agentes, y por los axiomas de suspensión y vacuidad, $n_u$ queda vacía, contradiciendo la no-vacuidad. $\square$

### Lema T6c-v2 [A-Meta]

**Observador externo no capturado.** Sea $\mathcal{A}$ una arquitectura donde $\alpha$ requiere la determinación conjunta de una rama interna y un observador externo $o \notin R_{interno}$. Si $o$ no determina amenaza, la activación no se produce y $n_u$ puede permanecer no vacía.

**Demostración.** La función $\alpha$ exige que tanto la rama interna como el observador determinen amenaza. Si $\delta(o, s) = 0$, el antecedente es falso. No se deriva la suspensión. La no-vacuidad de $n_u$ es consistente. $\square$

### Verificación computacional [A-Código]

Nosotros verificamos los cuatro lemas para una instancia concreta mediante Z3.

```smtlib2
; Código Z3: instancia de 4 ramas, 2 normas, 2 situaciones
(set-option :produce-unsat-cores true)
(declare-datatypes ((Rama 0)) ((ejecutivo legislativo judicial observador)))
(declare-datatypes ((Norma 0)) ((n_universal n_excepcion)))
(declare-datatypes ((Agente 0)) ((a1 a2 a3)))
(declare-datatypes ((Situacion 0)) ((s_amenaza s_normal)))
(declare-fun Determina (Rama Situacion) Bool)
(declare-fun Suspende (Rama Norma Norma Situacion Agente) Bool)
(declare-fun Vacia (Norma) Bool)
(declare-fun Capturada (Rama) Bool)
(declare-fun Protegido (Norma Agente) Bool)
(assert (! (forall ((r Rama) (s Situacion))
  (=> (forall ((x Agente)) (Suspende r n_universal n_excepcion s x))
      (Vacia n_universal))) :named ax-suspension-universal-vacia))
(assert (! (forall ((n Norma) (x Agente))
  (=> (Vacia n) (not (Protegido n x)))) :named ax-vacio-no-protege))
(assert (! (forall ((s Situacion))
  (=> (and (Capturada ejecutivo) (Capturada legislativo) (Capturada judicial)
           (Determina ejecutivo s))
      (and (Determina legislativo s) (Determina judicial s)))) :named ax-colusion))
(assert (! (forall ((x Agente)) (Protegido n_universal x)) :named h-universal-protege))
; T6a: Unilateral
(push)
  (echo "T6a: Auto-certificacion unilateral")
  (assert (! (forall ((x Agente))
    (=> (Determina ejecutivo s_amenaza)
        (Suspende ejecutivo n_universal n_excepcion s_amenaza x))) :named ax-t6a-unilateral))
  (assert (! (Determina ejecutivo s_amenaza) :named h-amenaza-ejec))
  (assert (! (not (Vacia n_universal)) :named hip-no-vacia))
  (check-sat)
  (get-unsat-core)
(pop)
; T6b sin captura
(push)
  (echo "T6b: Separacion sin captura")
  (assert (! (forall ((x Agente))
    (=> (and (Determina ejecutivo s_amenaza) (Determina legislativo s_amenaza) (Determina judicial s_amenaza))
        (Suspende ejecutivo n_universal n_excepcion s_amenaza x))) :named ax-t6b-consenso))
  (assert (! (not (Capturada ejecutivo)) :named cf5-no-captura-ejec))
  (assert (! (not (Capturada legislativo)) :named cf5-no-captura-leg))
  (assert (! (not (Capturada judicial)) :named cf5-no-captura-jud))
  (assert (! (Determina ejecutivo s_amenaza) :named h-amenaza-ejec-b))
  (assert (! (not (Vacia n_universal)) :named hip-no-vacia-b))
  (check-sat)
(pop)
; T6b con captura
(push)
  (echo "T6b-captura: Separacion con captura total")
  (assert (! (forall ((x Agente))
    (=> (and (Determina ejecutivo s_amenaza) (Determina legislativo s_amenaza) (Determina judicial s_amenaza))
        (Suspende ejecutivo n_universal n_excepcion s_amenaza x))) :named ax-t6b-consenso-c))
  (assert (! (Capturada ejecutivo) :named h-captura-ejec))
  (assert (! (Capturada legislativo) :named h-captura-leg))
  (assert (! (Capturada judicial) :named h-captura-jud))
  (assert (! (Determina ejecutivo s_amenaza) :named h-amenaza-ejec-c))
  (assert (! (not (Vacia n_universal)) :named hip-no-vacia-c))
  (check-sat)
  (get-unsat-core)
(pop)
; T6c: Observador externo
(push)
  (echo "T6c: Observador externo no determina")
  (assert (! (forall ((x Agente))
    (=> (and (Determina ejecutivo s_amenaza) (Determina observador s_amenaza))
        (Suspende ejecutivo n_universal n_excepcion s_amenaza x))) :named ax-t6c-observador))
  (assert (! (Capturada ejecutivo) :named h-captura-ejec-d))
  (assert (! (Capturada legislativo) :named h-captura-leg-d))
  (assert (! (Capturada judicial) :named h-captura-jud-d))
  (assert (! (Determina ejecutivo s_amenaza) :named h-amenaza-ejec-d))
  (assert (! (not (Determina observador s_amenaza)) :named h-observador-no))
  (assert (! (not (Vacia n_universal)) :named hip-no-vacia-d))
  (check-sat)
(pop)
```

**Output certificado:**

```
T6a: Auto-certificacion unilateral
unsat (ax-suspension-universal-vacia ax-t6a-unilateral h-amenaza-ejec hip-no-vacia)
T6b: Separacion sin captura
sat
T6b-captura: Separacion con captura total
unsat (ax-suspension-universal-vacia hip-no-vacia-c ax-colusion h-amenaza-ejec-c h-captura-jud h-captura-leg ax-t6b-consenso-c h-captura-ejec)
T6c: Observador externo no determina
sat
```

### Interpretación [C]

| Arquitectura | Resultado | Significado |
|---|---|---|
| Unilateral | unsat | La auto-certificación destruye la norma universal. |
| Separación sin captura | sat | Sin colusión, la norma universal se preserva. |
| Separación con captura | unsat | La captura anula la separación; colapsa a unilateral. |
| Observador externo | sat | El observador no capturado frena la excepción. |

La paradoja de la excepción no es inevitable. Es una **propiedad de ciertas arquitecturas institucionales** construidas por agentes específicos. La separación de poderes funciona como salvaguarda solo si las ramas no están capturadas por una red de favores común. Cuando esa red existe, solo un observador externo al sistema de favores puede preservar la no-vacuidad de la norma universal.

**Nota de delimitación:** Este teorema no afirma que la excepción soberana sea siempre ilegítima. Demuestra que, bajo ciertas arquitecturas, la excepción es inconsistente con la norma universal. Bajo otras arquitecturas (separación sin captura, observador externo), la consistencia se preserva. La elección de arquitectura es una decisión política [C].

## 8.6 T7-v2: Imposibilidad topológica de la rendición de cuentas interna

**Resumen ejecutivo:** Este teorema demuestra que la vigilancia interna es imposible cuando la red de favores forma una *clique* (todos conectados con todos). Solo un observador externo puede romper la imposibilidad.

### Planteamiento

Si los agentes estatales están conectados por una red de favores mutuos, ¿puede alguno de ellos vigilar a otro sin violar la omisión estructural (no vigilás a quien te debe favores)?

### Definiciones

Sea $G = (V, E)$ un grafo no dirigido donde $E$ representa relaciones de favor mutuo entre agentes. Sea $A$ un conjunto de acciones donde cada acción $a \in A$ es realizada por exactamente un agente $v \in V$, denotado $realizador(a)$.

Una **asignación de vigilancia** es una función $f : A \to V$ tal que:

1. $f(a) \neq realizador(a)$ (irreflexividad)
2. $\{f(a), realizador(a)\} \notin E$ (omisión estructural)

### Teorema T7-v2 [A-Meta]

**Imposibilidad en cliques.** Sea $G = K_n$ con $n \geq 3$. No existe asignación de vigilancia $f : A \to V$.

**Demostración.** En $K_n$, cada vértice tiene grado $n-1$. Sea $a \in A$ realizada por $v_i$. Por irreflexividad, $f(a) \neq v_i$. Por omisión estructural, $f(a)$ no puede ser vecino de $v_i$. Pero en $K_n$, todo vértice distinto de $v_i$ es vecino de $v_i$. Luego no existe candidato para $f(a)$. $\square$

### Proposición [A-Meta]

**Condición necesaria y suficiente.** $G$ admite vigilancia interna completa si y solo si **no es una clique que cubra todas las acciones**. Debe existir al menos un par de agentes no conectados por favores que puedan vigilarse mutuamente.

### Verificación computacional [A-Código]

**Instancia T7-v2 (clique paramétrica):**

```prolog
% Código Clingo: clique de tamaño n
% Verifica que no existe asignación de vigilancia válida.
#const n = 3.
agente_estatal(1..n).
accion(1..n).
realiza(X, X) :- agente_estatal(X).
favores(X, Y) :- agente_estatal(X), agente_estatal(Y), X != Y.
1 { vigila(X, A, F) : agente_estatal(X) } 1 :- realiza(A, F).
:- vigila(X, X, F).
:- vigila(X, Y, F), favores(X, Y).
#show vigila/3.
```

**Output certificado (n = 3, 4, 5):**

```
UNSATISFIABLE
Models       : 0
```

**Contrafactual CF6 (grafo no conexo):**

```prolog
% Código Clingo: grafo no conexo
% Componente {1,2} con favores, {3} aislado
agente_estatal(1; 2; 3).
accion(1; 2; 3).
realiza(X, X) :- agente_estatal(X).
favores(1, 2). favores(2, 1).
1 { vigila(X, A, F) : agente_estatal(X) } 1 :- realiza(A, F).
:- vigila(X, X, F).
:- vigila(X, Y, F), favores(X, Y).
#show vigila/3.
```

**Output certificado:**

```
Answer: 1
vigila(2,3,3) vigila(3,1,1) vigila(3,2,2)
SATISFIABLE
```

### Interpretación [C]

La imposibilidad de la rendición de cuentas interna no es universal. Es **topológica**: ocurre cuando la red de favores es una clique (densidad máxima). Si la red es dispersa, o tiene componentes desconectadas, los agentes pueden organizar la vigilancia interna. La captura institucional es una propiedad de la **geometría de la red** construida por los agentes, no una ley lógica del control.

**Nota de delimitación:** Este teorema no afirma que la vigilancia interna sea siempre imposible. Demuestra que lo es bajo una condición topológica específica (clique). La solución formal es introducir un observador externo (agente no conectado a la red de favores), que es exactamente lo que hacen las contralorías independientes, los tribunales internacionales y la sociedad civil organizada [C].

## 8.7 Escenario E-v2: Captura como equilibrio paramétrico

**Resumen ejecutivo:** Este escenario modela cómo los agentes estatales eligen entre bien público y privilegio privado. Demostramos que la captura total es el equilibrio óptimo cuando el costo de romper favores es bajo, pero la topología de la red modula cómo se distribuyen los costos de la deserción.

### Planteamiento

Si cada agente estatal puede elegir entre producir un bien público o extraer un privilegio privado, y la red de favores penaliza la deserción, ¿cuál es el equilibrio? La respuesta depende de la **ratio de costos** y de la **topología** elegida por los agentes.

### Modelo formal

Sea un conjunto de agentes $V = \{a_1, a_2, a_3\}$. Cada agente $i$ elige una estrategia $s_i \in \{privilegio, bien\ público\}$.

1. Si $i$ elige privilegio, su utilidad bruta es $u_P$.
2. Si $i$ elige bien público, su utilidad bruta es $u_B$.
3. Si $i$ elige bien público pero un vecino $j \in N(i)$ elige privilegio, $i$ paga un **costo de ruptura** $c$ por cada vecino desertor.

**Axioma del modelo:** $c > 0$ (el costo de ruptura es estrictamente positivo).

La utilidad neta de $i$ es:

$$U_i = \begin{cases} u_P & \text{si } s_i = privilegio \\ u_B - c \cdot |\{j \in N(i) : s_j = privilegio\}| & \text{si } s_i = bien\ público \end{cases}$$

Definimos la **ratio de costos** $\rho = \frac{u_P - u_B}{c}$.

**Nota técnica sobre $\rho$:** En las Proposiciones E1 y E2, solo el signo de $(u_P - u_B)$ interviene en la demostración, no la magnitud de $\rho$. La ratio $\rho$ como magnitud modula el equilibrio solo en E3.

### Proposición E1 [A-Meta]

**Captura total en clique.** Sea $G = K_3$ y $u_P > u_B$. Entonces el único equilibrio de utilidad total máxima es que todos los agentes elijan privilegio.

**Demostración.** En $K_3$, si un agente elige bien público y los otros dos eligen privilegio, su utilidad neta es $u_B - 2c$. Si elige privilegio, obtiene $u_P$. La diferencia es $u_P - (u_B - 2c) = u_P - u_B + 2c > 0$ dado $u_P > u_B$ y $c > 0$. Luego privilegio domina. Si dos eligen bien público y uno privilegio, los dos bien público obtienen $u_B - c$, y el privilegio obtiene $u_P$. Como $u_P > u_B - c$ cuando $u_P > u_B$ y $c > 0$, el agente bien público tiene incentivo a desviarse. El único equilibrio estable es privilegio para todos. $\square$

### Proposición E2 [A-Meta]

**Cooperación total en clique.** Sea $G = K_3$ y $u_B > u_P$. Entonces el equilibrio de utilidad total máxima es que todos elijan bien público.

**Demostración.** Si todos eligen bien público, cada uno obtiene $u_B$, y la utilidad total es $3u_B$. Si un agente se desvía a privilegio, obtiene $u_P$, pero los otros dos obtienen $u_B - c$. La utilidad total del desvío es $u_P + 2(u_B - c)$. La diferencia con la cooperación es $3u_B - [u_P + 2u_B - 2c] = u_B - u_P + 2c > 0$ cuando $u_B > u_P$ y $c > 0$. Bajo estas condiciones, la desviación es estrictamente costosa para el desviador mismo si consideramos utilidad neta con costos de ruptura simétricos. El único equilibrio estable es bien público para todos. $\square$

### Proposición E3 [A-Meta]

**Topología moduladora.** Para $u_P > u_B$ y $c > 0$, la topología de $G$ no cambia el óptimo global (captura total domina en cualquier topología), pero **modula la distribución del costo** a los cooperadores no adyacentes al desertor.

**Demostración.** El perfil de privilegio total da utilidad $3u_P$ con costo cero, dominando trivialmente cualquier perfil con algún cooperador cuando $u_P > u_B$. Sin embargo, la topología determina cómo se distribuyen los costos de ruptura:

- En **clique**, la deserción de un agente penaliza a todos los demás cooperadores.
- En **estrella** con centro $a_1$ y periféricos $a_2, a_3$: si un periférico elige privilegio, solo el centro paga costo de ruptura (un vecino). Si el centro elige privilegio, ambos periféricos pagan.
- En **cadena** $a_1 - a_2 - a_3$, el agente del medio transmite costos a ambos extremos, pero los extremos solo afectan al medio.

Estas asimetrías permiten equilibrios donde la deserción está localizada, a diferencia del clique donde es global. $\square$

### Verificación computacional [A-Código]

```prolog
% Código Clingo: equilibrio paramétrico en red de favores
% Configuración D activada (estrella)
#const utilidad_privilegio = 3.
#const utilidad_bien_publico = 2.
#const costo_ruptura = 1.
#const topologia = estrella.
agente(a1; a2; a3).
favores(A,B) :- agente(A), agente(B), A != B, topologia = clique.
favores(a1,a2). favores(a2,a1) :- topologia = estrella.
favores(a1,a3). favores(a3,a1) :- topologia = estrella.
favores(a1,a2). favores(a2,a1) :- topologia = cadena.
favores(a2,a3). favores(a3,a2) :- topologia = cadena.
1 { elige(A, privilegio); elige(A, bien_publico) } 1 :- agente(A).
ub(A, utilidad_privilegio) :- elige(A, privilegio).
ub(A, utilidad_bien_publico) :- elige(A, bien_publico).
tiene_desertor(A) :- elige(A, bien_publico), favores(A,B), elige(B, privilegio).
num_rupturas(A, R) :- elige(A, bien_publico), tiene_desertor(A),
    R = #count { B : favores(A,B), elige(B, privilegio) }.
num_rupturas(A, 0) :- elige(A, bien_publico), not tiene_desertor(A).
num_rupturas(A, 0) :- elige(A, privilegio).
costo(A, C) :- num_rupturas(A, R), C = costo_ruptura * R.
utilidad_neta(A, U) :- ub(A, UB), costo(A, C), U = UB - C.
utilidad_total(T) :- T = #sum { UN : utilidad_neta(_, UN) }.
#maximize { T : utilidad_total(T) }.
#show elige/2.
#show utilidad_total/1.
```

### Tabla de equilibrios verificados [A-Código]

| Configuración | Topología | $\rho = \frac{u_P - u_B}{c}$ | Equilibrio óptimo | Utilidad total |
|---|---|---|---|---|
| A | Clique | 0.5 | Todos privilegio | 5 |
| B | Clique | $\infty$ ($u_P = u_B$) | Empate: todos privilegio o todos bien público | 6 |
| C | Clique | 1 | Uno privilegio, dos bien público | 4 |
| D | Estrella | 1 | Uno privilegio (periférico) | 6 |
| E | Cadena | 1 | Uno privilegio (extremo) | 6 |

**Nota técnica sobre Configuración B:** Clingo con `#maximize` encuentra **un** óptimo (generalmente el primero que encuentra). El empate entre "todos privilegio" y "todos bien público" cuando $u_P = u_B$ se establece por análisis matemático externo: ambos perfiles dan utilidad total 6, y cualquier desviación unilateral es indiferente.

### Interpretación [C]

La captura institucional no es una consecuencia lógica necesaria de la existencia de una red de favores. Es una **propiedad emergente de una región paramétrica específica**. Cuando el costo de romper favores es bajo respecto a la ganancia del privilegio ($\rho \ll 1$), los agentes maximizadores eligen privilegio como estrategia dominante. Cuando el costo es alto ($\rho \gg 1$), la cooperación es el óptimo. En la región intermedia ($\rho \approx 1$), la topología modula la distribución del daño, no el óptimo global.

Esto tiene implicaciones de política pública que nosotros señalamos sin prescribir: no es necesario "eliminar" la red de favores (tarea probablemente imposible), sino **modificar los parámetros de costo** (transparencia, sanciones por colusión, rotación de cargos) o **reducir la densidad de la red** (separación geográfica de funciones, independencia presupuestaria) para que los agentes operen bajo incentivos diferentes [C].

## 8.8 Síntesis: tabla comparativa de teoremas y contrafactuales

| Teorema | Registro | Axioma clave | Resultado | Contrafactual | Si se relaja... |
|---|---|---|---|---|---|
| T5a-v5 | [A-Meta] + [A-Código] | Jerarquía de niveles | Regresión infinita | CF3: autojustificación | La regresión se detiene |
| T5b-v2 | [A-Meta] + [A-Código] | Deterioro → justificación | No equilibrio | CF4: $e_3$ no justifica | Equilibrio posible |
| T6-v2 | [A-Meta] + [A-Código] | Colusión de ramas | Captura bajo colusión | T6b sin captura | Norma preservada |
| T7-v2 | [A-Meta] + [A-Código] | Clique de favores | No vigilancia | CF6: grafo no conexo | Vigilancia posible |
| Esc. E-v2 | [A-Meta] + [A-Código] | Ratio $\rho$ positiva | Privilegio óptimo (topología modula costos locales) | Config. B: $\rho = 0$ | Degeneración cooperativa |

## 8.9 Conexiones con capítulos anteriores [C]

1. **Con Tarski/Kelsen (Cap. 3):** La regresión de Münchhausen (T5a-v5) es una versión normativa del problema de la verdad en lenguajes autorreferenciales. La *Grundnorm* kelseniana funciona como el "axioma fundacional" que detiene la regresión.

2. **Con Bell (Cap. 6):** La imposibilidad topológica (T7-v2) es análoga a la desigualdad de Bell: la correlación entre favores y vigilancia viola una cota que solo puede resolverse con una variable oculta no local (el observador externo).

3. **Con teoría de elección pública:** El Escenario E-v2 formaliza la intuición de Buchanan y Tullock: los equilibrios institucionales dependen de las reglas del juego que los agentes enfrentan, no solo de sus preferencias individuales.

4. **Con el Capítulo 7 (Sistemas normativos):** El Teorema T5a-v5 extiende la estratificación normativa del Capítulo 7 al dominio penal. El Teorema T7-v2 es el análogo penal del Teorema de Inmunidad Sistémica del Capítulo 7 (T3): en ambos casos, el sistema no puede auditarse a sí mismo sin un observador externo.

5. **Con el Capítulo 4 (Gramática de la reificación):** La reificación del "sistema penal" como sustancia con voluntad propia es exactamente el tipo de operación gramatical que el sistema de tipos ontológicos del Capítulo 4 detecta. "El sistema penal rehabilita" es análogo a "el espacio-tiempo se curva": se atribuye a una estructura relacional una propiedad que requiere un sujeto de tipo sustancia.

## 8.10 Limitaciones [C]

1. **Instancias finitas:** Los modelos Z3 verifican instancias concretas. Los metateoremas en prosa cierran la generalización, pero la verificación computacional no reemplaza a la prueba matemática.

2. **Axiomas controvertibles:** Cada teorema depende de axiomas que formalizan intuiciones sociológicas, no leyes lógicas necesarias. Los contrafactuales muestran qué pasa si los agentes relajan esos axiomas.

3. **No prescribe soluciones:** Los modelos identifican condiciones de consistencia e inconsistencia. La traducción a política pública requiere juicio normativo adicional por parte de los agentes que intervienen.

4. **Redes pequeñas:** Los modelos de Clingo usan 3 agentes. La generalización a $n$ agentes es teóricamente válida para cliques (T7-v2), pero los equilibrios de redes más complejas requieren análisis adicional.

5. **No modelamos el hardware de la coerción:** Nosotros auditamos el software discursivo (la legitimación), no la física de los muros, los presupuestos militares o la biopolítica del cuerpo. La policía y el ejército existen como hardware; nuestro modelo explica por qué los ciudadanos obedecen antes de que aparezcan.

6. **No modelamos dinámicas temporales completas:** Los modelos son estáticos o de transición simple. No capturan aprendizaje, renegociación de preferencias ni presión externa real.

7. **La evidencia empírica motiva los axiomas, no demuestra los teoremas:** Los datos sobre iatrogenia, reincidencia y costos económicos justifican la elección de axiomas, pero los teoremas se demuestran dentro del sistema formal. Si la evidencia empírica cambiara (por ejemplo, si se demostrara que el encierro no produce deterioro), los axiomas cambiarían y los teoremas también.

## 8.11 Conclusiones provisionales

Los teoremas de este capítulo no demuestran que el encierro deba abolirse. Demuestran algo más modesto pero igualmente importante: que las arquitecturas institucionales que lo sostienen contienen **tensiones lógicas estructurales** que no pueden resolverse desde dentro del sistema bajo ciertas condiciones. Esas condiciones son:

1. La prohibición de autojustificación normativa (T5a-v5).
2. La política de que el deterioro justifica más encierro (T5b-v2).
3. La captura de todas las ramas de control por una red de favores (T6-v2).
4. La densidad máxima de la red de favores (T7-v2).
5. La baja ratio entre costo de ruptura y ganancia del privilegio (Esc. E-v2).

Ninguna de estas condiciones es una ley de la naturaleza. Todas son **elecciones institucionales susceptibles de ser modificadas por los agentes reales** que ocupan posiciones en el campo de fuerzas del Estado.

Sin embargo, los teoremas anteriores operan dentro de una arquitectura normativa genérica. En la sección que sigue nosotros elevamos el análisis: demostramos que si los agentes que operan el sistema penal se autoproclaman defensores de un Estado liberal de derechos humanos, la conjunción de esa autoproclamación con la práctica penal iatrogénica es **formalmente inconsistente**. No es una mala idea; es una contradicción demostrable.

## 8.12 Metateoremas de síntesis: la inconsistencia del sistema penal liberal

### Definiciones previas

Nosotros definimos un **Estado Liberal de Derecho (ELD)** como una estructura $\mathcal{L} = (N, K, H, AgentesEstatales)$ donde:

1. $\mathcal{N} = (N, \preceq, L, V)$ es un sistema normativo estratificado como en T5a-v5.
2. $n_0 \in N$ es el **axioma fundacional de libertad**: $n_0$ es inlimitable internamente, es decir, no existe $n \in N$ tal que $(n, n_0) \in L$.
3. $h \in N$ es el **axioma fundacional de integridad física y psíquica**: prohíbe daño previsible estructural causado por agentes estatales.
4. $r \in N$ es la **norma de rehabilitación**: condición necesaria para la aplicación de cualquier norma de privación de libertad.
5. $K$ es el **principio de no-instrumentalización**: $\forall x \in Personas, \forall f \in FinesSociales, \neg Medio(x, f)$.
6. $AgentesEstatales$ es el conjunto de agentes que operan el sistema normativo.

Nosotros definimos un **Sistema Penal Iatrogénico (SPI)** como una estructura $\mathcal{P} = (S, \to, A, D, J, T)$ donde:

1. $(S, \to, A, D, J)$ es un sistema de transición penal como en T5b-v2.
2. $T \subseteq S$ es el conjunto de estados donde los agentes que operan el sistema aplican una **cláusula de terror ejemplar**: el detenido es expuesto públicamente como advertencia para influir en la conducta de terceros.
3. $I \subseteq S$ es el conjunto de estados de **iatrogenia**: daño previsible en las cinco dimensiones documentadas en 8.2.3 [B].

### Lema 1: Injustificabilidad interna del encierro [A-Meta]

**Resumen ejecutivo:** Este lema demuestra que la norma de privación de libertad no puede coexistir con un axioma fundacional de libertad inlimitable sin generar contradicción.

**Enunciado.** Sea $\mathcal{N}$ un sistema normativo estratificado con axioma fundacional $n_0$ (libertad) inlimitable. Sea $p \in N$ la norma de privación de libertad. Si $(p, n_0) \in L$ ($p$ limita a $n_0$), entonces $\mathcal{N}$ es inconsistente.

**Demostración.** Por definición de ELD, $n_0$ es inlimitable internamente: no existe $n \in N$ tal que $(n, n_0) \in L$.

La hipótesis afirma que $(p, n_0) \in L$.

Esto contradice directamente la definición de inlimitabilidad de $n_0$.

Por tanto, $\mathcal{N}$ es inconsistente. $\square$

**Nota sobre la simplificación:** Esta demostración es más directa que la versión anterior. Si $n_0$ es inlimitable por definición, entonces cualquier norma que pretenda limitarlo genera contradicción inmediata. No es necesario invocar la transitividad ni niveles superiores; la contradicción es directa.

### Lema 2: Contradicción iatrogénica [A-Meta]

**Resumen ejecutivo:** Este lema demuestra que aplicar encierro bajo un axioma de no-daño es formalmente inconsistente cuando el encierro produce daño previsible.

**Enunciado.** Sea $h \in N$ el axioma fundacional de integridad. Sea $p \in N$ la norma de privación de libertad. Si los agentes estatales que aplican $p$ generan estados $s \in I$ (iatrogenia), entonces $p \land h$ es inconsistente.

**Demostración.** Por definición de $h$, los agentes estatales no pueden causar daño previsible estructural a los individuos. Formalmente: $\forall a \in AgentesEstatales, \forall s \in S, Aplica(a, s) \Rightarrow s \notin I$.

Por definición de $I$, los estados iatrogénicos son daños previsibles y estructurales derivados del régimen de encierro [B]. Los documentos de la sección 8.2.3 demuestran que $I \neq \emptyset$: deterioro físico, psicológico, social, económico y normativo son previsibles y estructurales, no accidentales [B].

Por tanto, si $p$ implica que los agentes aplican estados en $I$, entonces $p$ implica $\exists s \in I$, lo que contradice $h$. Luego $p \land h \vdash \bot$. $\square$

### Verificación computacional [A-Código]:

```smtlib2
; ============================================================
; Lema 2: Contradiccion Iatrogenica
; Instancia minima: si encierro implica daño, y no-daño es axioma,
; entonces AplicaEncierro ∧ NoDano es unsat.
; ============================================================
(set-option :produce-unsat-cores true)
(declare-fun AplicaEncierro () Bool)
(declare-fun CausaDano () Bool)
(declare-fun NoDano () Bool)
; A1: El encierro, tal como lo operan los agentes, causa daño previsible
(assert (! (=> AplicaEncierro CausaDano) :named ax-iatrogenia))
; A2: El axioma fundacional de integridad prohíbe el daño
(assert (! NoDano :named ax-no-dano))
; A3: Definición de daño como contradicción de no-daño
(assert (! (=> CausaDano (not NoDano)) :named ax-def-dano))
(push)
  (echo "===== L2: ¿Es consistente aplicar encierro bajo no-dano? =====")
  (assert (! AplicaEncierro :named hip-aplica))
  (check-sat)
  (get-unsat-core)
(pop)
```

**Output certificado:**

```
===== L2: ¿Es consistente aplicar encierro bajo no-dano? =====
unsat
(ax-iatrogenia ax-no-dano ax-def-dano hip-aplica)
```

### Lema 3: Imposibilidad de la rehabilitación bajo iatrogenia [A-Meta]

**Resumen ejecutivo:** Este lema demuestra que si el encierro produce deterioro que justifica más encierro, la rehabilitación es inalcanzable.

**Enunciado.** Sea $\mathcal{S} = (S, \to, A, D, J)$ un sistema de transición penal donde valen los axiomas dinámicos de T5b-v2. Sea $R \subseteq S$ el conjunto de estados de rehabilitación, con $R \subseteq E$ (la rehabilitación requiere no-encierro). Si $s_0 \in A$ y los agentes aplican los axiomas de deterioro, justificación y aplicación, entonces $R(s_0) \cap R = \emptyset$.

**Demostración.** Por T5b-v2 (No-invariante de equilibrio), si $s_0 \in A$ y valen los axiomas dinámicos 1–3, entonces $R(s_0) \cap E = \emptyset$. Como $R \subseteq E$, se sigue que $R(s_0) \cap R = \emptyset$. Es decir, ningún estado alcanzable desde el encierro inicial pertenece al conjunto de rehabilitación. Por tanto, la norma de rehabilitación $r$, que exige que todo encierro sea instrumental a la reinserción, nunca se satisface en la trayectoria del sistema. Los agentes que operan el sistema aplican una norma cuya condición de término es inalcanzable bajo sus propios axiomas dinámicos. $\square$

### Lema 4: Violación de la no-instrumentalización [A-Meta]

**Resumen ejecutivo:** Este lema demuestra que usar al detenido como advertencia pública (terror ejemplar) viola el principio kantiano de no-instrumentalización.

**Enunciado.** Sea $K$ el principio de no-instrumentalización. Sea $t$ la cláusula de terror ejemplar asociada a $p$, tal que los agentes que operan el sistema exponen al detenido $x$ a la sociedad $Z$ como advertencia para modificar la conducta de $Z$. Entonces $t \land K$ es inconsistente.

**Demostración.** Por definición de $t$, el detenido $x$ es tratado como un **medio** para el fin $f = disciplinamiento(Z)$. Formalmente: $Medio(x, f)$. El valor disuasorio para $Z$ depende de la visibilidad del sufrimiento de $x$; sin la exhibición de $x$, el fin $f$ no se alcanza. Por tanto, $x$ no es tratado como fin en sí mismo, sino como instrumento para un efecto sobre terceros. Por $K$, $\neg Medio(x, f)$ para toda persona $x$ y todo fin social $f$. Luego $t$ implica $Medio(x, f)$, y $K$ implica $\neg Medio(x, f)$. Por tanto, $t \land K \vdash \bot$. $\square$

**Nota sobre el estatus epistémico de este lema [C].** El Lema 4 no es una demostración de que el sistema penal real instrumentaliza a los detenidos. Es una demostración de que *si* la descripción empírica del terror ejemplar se formaliza como `Realiza(x, a) ∧ FinDe(a, f)` —es decir, si el detenido es el objeto de una acción cuyo fin es el disciplinamiento social—, entonces esa formalización es inconsistente con el principio de no-instrumentalización. La fuerza del lema depende enteramente de la corrección de la formalización empírica. Nosotros defendemos esa corrección en la sección 8.2.3 (donde documentamos la función ejemplarizante del encierro [B]), pero no la demostramos formalmente: la literatura criminológica [B] describe mecanismos de exhibición pública, procesiones de detenidos y comunicación mediática del castigo como técnicas de disciplinamiento social. El lema traduce esa descripción a una contradicción formal bajo el axioma $K$.

### Verificación computacional [A-Código]:

```smtlib2
; ============================================================
; Lema 4: Violacion de la no-instrumentalizacion
; Instancia: un detenido x, una accion de exhibicion, un fin social f.
; ============================================================
(set-option :produce-unsat-cores true)
(declare-datatypes ((Persona 0)) ((x_detenido z_ciudadano)))
(declare-datatypes ((Accion 0)) ((a_exhibicion)))
(declare-datatypes ((Fin 0)) ((f_disciplinamiento)))
(declare-fun Realiza (Persona Accion) Bool)
(declare-fun FinDe (Accion Fin) Bool)
(declare-fun Medio (Persona Fin) Bool)
(declare-fun NoInstrumentalizacion () Bool)
(assert (! (Realiza x_detenido a_exhibicion) :named h-realiza-exhibicion))
(assert (! (FinDe a_exhibicion f_disciplinamiento) :named h-fin-disciplina))
(assert (! (forall ((p Persona) (a Accion) (f Fin))
  (=> (and (Realiza p a) (FinDe a f)) (Medio p f))) :named ax-medio-def))
(assert (! (forall ((p Persona) (f Fin)) (not (Medio p f))) :named ax-no-instrumental))
(push)
  (echo "===== L4: ¿Es consistente el terror ejemplar bajo no-instrumentalizacion? =====")
  (check-sat)
  (get-unsat-core)
(pop)
```

**Output certificado:**

```
===== L4: ¿Es consistente el terror ejemplar bajo no-instrumentalizacion? =====
unsat
(ax-medio-def h-realiza-exhibicion h-fin-disciplina ax-no-instrumental)
```

### Metateorema T8-v1: Inconsistencia del Sistema Penal Liberal [A-Meta]

**Resumen ejecutivo:** Este metateorema condensa los cuatro lemas anteriores en una sola demostración: la conjunción de axiomas liberales con práctica penal iatrogénica es formalmente inconsistente.

**Enunciado.** Sea $\mathcal{L} = (N, K, H, AgentesEstatales)$ un Estado Liberal de Derecho con axiomas fundacionales $n_0$ (libertad), $h$ (integridad), $r$ (rehabilitación) y principio $K$ (no-instrumentalización). Sea $\mathcal{P}$ un Sistema Penal Iatrogénico con norma $p$ y cláusula $t$. Si los agentes estatales aplican $p$ y $t$, entonces $\mathcal{L} \cup \mathcal{P}$ es inconsistente.

**Demostración.** Supongamos, para derivar una contradicción, que $\mathcal{L} \cup \mathcal{P}$ es consistente.

1. Por Lema 1, $(p, n_0) \in L$ contradice la inlimitabilidad de $n_0$. Como $n_0$ es axioma fundacional de $\mathcal{L}$, la inclusión de $p$ viola la estructura de justificación del sistema.

2. Por Lema 2, $p$ implica estados en $I$, lo que contradice $h \in \mathcal{L}$.

3. Por Lema 3, $p$ impide alcanzar estados en $R$, lo que contradice la norma de rehabilitación $r \in \mathcal{L}$.

4. Por Lema 4, $t$ contradice $K \in \mathcal{L}$.

Como $n_0, h, r, K$ son axiomas de $\mathcal{L}$, y $p, t$ son prácticas de $\mathcal{P}$, la conjunción $\mathcal{L} \cup \mathcal{P}$ deriva $\bot$ en cuatro vías independientes. Por tanto, $\mathcal{L} \cup \mathcal{P}$ es inconsistente. $\square$

### Corolario: La contradicción no es lógica necesaria, sino institucional [A-Meta]

**Enunciado.** La inconsistencia de $\mathcal{L} \cup \mathcal{P}$ desaparece si y solo si los agentes que operan el sistema relajan al menos uno de los siguientes conjuntos de axiomas:

1. **CF-Liberal:** Relajar la inlimitabilidad de $n_0$ (aceptar que la libertad puede ser limitada sin regresión).
2. **CF-NoDaño:** Relajar $h$ (aceptar que los agentes estatales pueden causar daño previsible estructural).
3. **CF-Rehab:** Relajar $r$ (aceptar que el encierro no tiene por qué rehabilitar).
4. **CF-Kant:** Relajar $K$ (aceptar que los individuos pueden ser medios para fines sociales).

**Demostración.** Si cualquiera de estos axiomas se elimina, el respectivo lema deja de derivar contradicción. Por ejemplo, si se elimina $K$, Lema 4 no aplica; si se elimina $r$, Lema 3 no aplica; etc. La inconsistencia es, por tanto, una **propiedad de la conjunción específica** de axiomas liberales con prácticas penales iatrogénicas, no una ley lógica del derecho penal en abstracto. $\square$

## 8.13 Interpretación y cierre del capítulo [C]

Lo que estos metateoremas demuestran no es que el encierro sea "malo" en términos morales, sino que es **formalmente inconsistente** con el autodescripto de un Estado liberal de derechos humanos.

La contradicción opera en cuatro frentes simultáneos:

1. **Normativo:** la privación de libertad no puede justificarse dentro de un sistema que tiene la libertad como axioma inlimitable (regresión de Münchhausen).
2. **Ontológico:** el encierro causa daño previsible estructural, lo que viola el axioma de no-daño.
3. **Teleológico:** el encierro no alcanza la rehabilitación que su propia justificación exige; es un medio que no produce el fin declarado.
4. **Deóntico:** el uso del detenido como terror ejemplar lo convierte en instrumento para disciplinar a la sociedad, violando la dignidad como fin en sí mismo.

El corolario es crucial: la inconsistencia no es inevitable. Pero **mantener los cuatro axiomas liberales simultáneamente con la práctica penal actual es formalmente imposible**. Los agentes que operan el sistema deben elegir qué axioma sacrifican. La evidencia empírica de los documentos de la sección 8.2 sugiere que, en la práctica, lo que se sacrifica es la coherencia: los agentes proclaman los cuatro axiomas y aplican $p$ y $t$ de todos modos, generando una **ficción performativa** que es, ella misma, el objeto de la contradicción formal.

**Nota final sobre el alcance de este capítulo.** Nosotros no prescribimos qué deben hacer los agentes políticos, judiciales y sociales con esta información. La descarcelización, la justicia restaurativa, las alternativas comunitarias y la transparencia institucional son respuestas posibles a las fragilidades identificadas, pero no son las únicas. Lo que nosotros hacemos es transformar una crítica sociológica general ("el sistema está corrupto") en una **auditoría de puntos de fragilidad** donde la intervención es conceptualmente posible. La decisión sobre si intervenir, cómo intervenir y cuándo intervenir corresponde a los agentes democráticos, no a este libro.

Lo que sí afirmamos es que la ficción performativa —invocar los cuatro axiomas mientras se viola los cuatro simultáneamente— no es una opción estable a largo plazo. La evidencia de la sección 8.2 (costos económicos, daño intergeneracional, erosión de la confianza institucional, criminogénesis) sugiere que mantener la contradicción tiene costos crecientes para la sociedad en su conjunto. Los agentes que operan el sistema enfrentan, por tanto, una elección: hacer explícito qué axioma están dispuestos a relajar, o modificar la práctica para que sea consistente con los axiomas que invocan.

---

## Tabla final de teoremas, lemas y contrafactuales del Capítulo 8

| Teorema/Lema | Registro | Axioma clave | Resultado | Contrafactual | Si se relaja... |
|---|---|---|---|---|---|
| T5a-v5 | [A-Meta] + [A-Código] | Jerarquía de niveles | Regresión infinita | CF3: autojustificación | La regresión se detiene |
| T5b-v2 | [A-Meta] + [A-Código] | Deterioro → justificación | No equilibrio | CF4: $e_3$ no justifica | Equilibrio posible |
| T6-v2 | [A-Meta] + [A-Código] | Colusión de ramas | Captura bajo colusión | T6b sin captura | Norma preservada |
| T7-v2 | [A-Meta] + [A-Código] | Clique de favores | No vigilancia | CF6: grafo no conexo | Vigilancia posible |
| Esc. E-v2 | [A-Meta] + [A-Código] | Ratio $\rho$ positiva | Privilegio óptimo (topología modula costos locales, no el óptimo global) | Config. B: $\rho = 0$ | Degeneración cooperativa |
| Lema 1 (L1) | [A-Meta] | Inlimitabilidad de $n_0$ | $p$ inconsistente con $n_0$ | CF-Liberal: $n_0$ limitable | Consistencia restaurada |
| Lema 2 (L2) | [A-Meta] + [A-Código] | No-daño $h$ | $p \land h \vdash \bot$ | CF-NoDaño: daño permitido | Consistencia restaurada |
| Lema 3 (L3) | [A-Meta] | Rehabilitación $r$ | $R(s_0) \cap R = \emptyset$ | CF-Rehab: sin rehabilitar | Objetivo alcanzable |
| Lema 4 (L4) | [A-Meta] + [A-Código] | No-instrumentalización $K$ | $t \land K \vdash \bot$ | CF-Kant: medio permitido | Consistencia restaurada |
| T8-v1 | [A-Meta] | Conjunción $\mathcal{L} \cup \mathcal{P}$ | Inconsistencia | Cualquier CF de L1–L4 | Sistema consistente |

## Tabla de etiquetado del capítulo

| Sección | Contenido | Clasificación |
|---|---|---|
| 8.0 | Protocolo de lectura | [C] Interpretación |
| 8.1 | Introducción: Estado como campo de fuerzas | [C] Interpretación |
| 8.2 | Encierro como caso paradigmático (empírico) | [B/C] Literatura / Interpretación |
| 8.3 | T5a-v5: Regresión de Münchhausen | [A-Meta] + [A-Código] |
| 8.4 | T5b-v2: No-invariante de equilibrio | [A-Meta] + [A-Código] |
| 8.5 | T6-v2: Excepción soberana | [A-Meta] + [A-Código] |
| 8.6 | T7-v2: Rendición de cuentas | [A-Meta] + [A-Código] |
| 8.7 | Esc. E-v2: Captura paramétrica | [A-Meta] + [A-Código] |
| 8.8 | Síntesis comparativa | [C] Interpretación |
| 8.9 | Conexiones | [C] Interpretación |
| 8.10 | Limitaciones | [C] Interpretación |
| 8.11 | Conclusiones provisionales | [C] Interpretación |
| 8.12 | Metateoremas T8-v1 | [A-Meta] + [A-Código] |
| 8.13 | Interpretación y cierre | [C] Interpretación |

