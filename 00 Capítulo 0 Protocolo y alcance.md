# Capítulo 0: Protocolo y alcance

## 0.1 De qué trata este libro

Este libro aborda un problema específico: la confusión entre los modelos que construimos para describir la realidad y la realidad misma. Esta confusión, conocida como reificación, consiste en atribuir a los objetos del mundo propiedades que pertenecen únicamente a nuestras herramientas de representación.

El libro sostiene una tesis precisa: muchas paradojas y contradicciones en física y ciencias sociales no revelan límites insalvables del conocimiento, sino errores en la formulación conceptual de los problemas. Estos errores pueden detectarse y corregirse mediante un análisis riguroso de los niveles de representación involucrados.

El método que proponemos es la estratificación explícita de niveles: distinguir claramente entre el sistema que se describe y el lenguaje en que se lo describe, entre la norma y el evaluador de la norma, entre el objeto medido y el instrumento de medición.

El libro se limita a casos donde el formalismo científico es estable y las predicciones funcionan, pero la narrativa que lo envuelve es confusa o contradictoria. No pretende resolver problemas abiertos de la física, proponer nuevas teorías, ni hacer predicciones empíricas.

El argumento sigue una progresión: el Capítulo 1 define operativamente la reificación y muestra que es un error categorial recurrente con la misma gramática en dominios distintos. El Capítulo 2 introduce las herramientas formales que permiten verificarlo. El Capítulo 3 demuestra que la estratificación resuelve un caso concreto en lógica (el sistema SPA). Los Capítulos 4 a 8 aplican el mismo protocolo a cinco dominios distintos: la gramática del discurso físico clásico (Cap. 4), la medición cuántica (Cap. 5), la recepción del teorema de Bell (Cap. 6), los sistemas normativos y ciencias sociales (Cap. 7), y las asimetrías deónticas del poder estatal (Cap. 8). El Capítulo 9 evalúa qué se ha ganado, qué no, y qué queda por hacer.

## 0.2 El protocolo de las cuatro preguntas

El método de análisis que empleamos en cada caso de estudio consiste en cuatro preguntas, aplicadas en este orden:

**Pregunta 1: ¿Cuál es el objeto formal y cuál es su tipo?**

Identificamos la estructura subyacente: un objeto matemático, un predicado lógico, un tipo de datos, o un operador. Determinamos a qué nivel pertenece: objeto, meta, operador, predicado, norma. En física, esto será típicamente un tensor, un vector de estado, o una métrica. En ciencias sociales, será un predicado normativo, una regla de inferencia, o una relación de autoridad.

**Pregunta 2: ¿Qué atribuye la narrativa a ese objeto que su tipo no contiene?**

Examinamos el lenguaje con que se habla de ese formalismo. ¿Se dice que el espacio-tiempo se curva? ¿Que la función de onda colapsa? ¿Que el Estado decide? ¿Que la Patria exige? Identificamos los atributos que la prosa añade y que no están presentes en la estructura formal subyacente.

**Pregunta 3: ¿Existe una descripción alternativa sin ese atributo?**

Buscamos en la literatura si existe una descripción alternativa que produzca las mismas predicciones observacionales sin utilizar el atributo cuestionado. Si existe equivalencia observacional pero no equivalencia teórica, se señala explícitamente. En ciencias sociales y lógica, la descripción alternativa puede tomar la forma de una prueba de que el sistema que colapsa los niveles es lógicamente inconsistente, por ejemplo mediante diagonalización.

Si existe tal descripción o prueba, el atributo es una interpretación, no un hecho forzoso. Si no existe ninguna alternativa, el caso queda fuera del alcance del libro.

**Pregunta 4: ¿Es esto teoría resuelta con narrativa sucia, un desacuerdo interpretativo con formalismo sólido, o un problema genuinamente abierto?**

Distinguimos tres situaciones:

- **Teoría resuelta con narrativa sucia:** El formalismo es sólido, las predicciones funcionan, y hay consenso científico. Solo la narrativa que lo envuelve es confusa. Es el caso ideal para nuestro análisis.
- **Desacuerdo interpretativo con formalismo sólido:** El formalismo funciona, las predicciones son correctas, el consenso empírico es estable, pero existen interpretaciones rivales sin consenso. Nuestro análisis puede clarificar la estructura lógica del desacuerdo, pero no pretenderá resolverlo.
- **Problema genuinamente abierto:** No hay formalismo aceptado, no hay consenso, o la física relevante no se conoce. Nuestro método no tiene nada que ofrecer aquí. El caso queda excluido.

## 0.3 Regla de pertenencia y etiquetado

Una afirmación solo entra en este libro si:

1. Supera las cuatro preguntas del protocolo, o
2. Es una cita de literatura externa debidamente referenciada, o
3. Está explícitamente marcada como interpretación no demostrada o dirección futura.

Toda afirmación sustantiva en capítulos formalizados se clasifica al final del capítulo como:

- **[A] Probada por código:** el archivo correspondiente compila y la afirmación se sigue directamente del teorema formalizado.
- **[B] Citada de literatura:** la afirmación está respaldada por una fuente académica identificada.
- **[C] Interpretación:** la afirmación es una lectura filosófica de los resultados formales o empíricos, y se presenta como tal, no como hecho establecido.

Estas marcas aparecen como etiquetas al margen del texto o en una tabla resumen al final de cada capítulo, según resulte más legible en cada caso.

## 0.4 Matriz de herramientas

Según el tipo de problema, utilizamos distintas herramientas formales:

| Tipo de problema | Herramienta | Justificación |
|---|---|---|
| Consistencia lógica, teoremas con inducción | Lean 4 | Kernel pequeño, prueba verificable, lógica de primer orden con igualdad |
| Satisfactibilidad de conjuntos de axiomas en fragmentos decidibles | Z3 / SMT-LIB | Automático, produce modelos o unsat core |
| Normas con excepciones, razonamiento por defecto | Clingo / ASP | Answer Set Programming maneja negación por fallo y reglas defeasibles |
| Verificación de tipos, estructura de datos | Lean 4 | Teoría de tipos dependientes, chequeo en compilación |

La elección de la herramienta se justifica en cada capítulo. No se utiliza una herramienta por inercia, sino porque es la adecuada para el problema concreto.

## 0.5 Regla de oro: no-compresión lingüística y agencia explícita

A lo largo de este libro, nosotros aplicamos una regla de estilo que es también una regla metodológica: **la prohibición de la compresión lingüística que suprime al agente humano**.

El lenguaje natural, como demostramos en el Capítulo 1 (sección 1.2.3), reifica por estructura gramatical. La nominalización, la voz pasiva sin agente y la metonimia de instrumento por agente son operaciones sintácticas que ocultan la responsabilidad. Cuando un discurso dice "el Estado decide", "la ley exige", "Z3 demuestra" o "el sistema sanciona", ha promovido una construcción abstracta o una herramienta al rol de agente, y ha suprimido a los agentes humanos que son los únicos con capacidad real de acción, creencia y responsabilidad.

Nosotros nos negamos a economizar palabras si el costo de esa compresión es la pérdida del agente humano. Por tanto, en la prosa de este libro:

- No decimos "Z3 demuestra el teorema"; decimos "nosotros demostramos el teorema mediante Z3".
- No decimos "el sistema penal produce daño"; decimos "los agentes que diseñan y operan el sistema penal producen daño".
- No decimos "la Patria exige sacrificio"; decimos "los líderes políticos exigen sacrificio amparándose en la Patria".
- No decimos "el modelo revela"; decimos "nosotros interpretamos que el modelo predice".

Esta regla tiene una consecuencia práctica: la prosa de este libro es deliberadamente más larga de lo que la economía discursiva estándar permitiría. El lector debe soportar la longitud de nuestras oraciones como el precio de nuestra higiene ontológica. La compresión de información produce pérdida de información, y la información que se pierde es siempre la misma: quién es el agente responsable.

Esta regla se aplica también a nuestro propio aparato analítico. No es "la reificación" la que produce guerras; son los líderes políticos quienes utilizan construcciones reificadas para justificarlas. No son "los procesos satélite" los que manipulan; son los hablantes quienes aplican esos procesos. El método no acusa; diagnostica. Y al diagnosticar, señala a los agentes concretos.

## 0.6 Lector previsto y cómo leer este libro

El lector previsto tiene formación universitaria en alguna disciplina científica o filosófica, no necesariamente en lógica formal. Los capítulos que incluyen código —principalmente el 3, el 5, el 6, el 7 y el 8— pueden leerse a dos niveles: el argumento conceptual sin el código, o el argumento con verificación del código. El código está disponible para quien quiera inspeccionarlo, pero no es necesario seguirlo línea por línea para entender el argumento.

El libro está organizado en diez capítulos:

| Capítulo | Título | Función |
|---|---|---|
| 0 | Protocolo y alcance | Las reglas del juego |
| 1 | La reificación como problema metodológico | Definición operativa, procesos satélite, protocolo de 4 preguntas, autoaplicación |
| 2 | Herramientas formales para no especialistas | Lean 4, Z3, Clingo explicados para lectores no técnicos |
| 3 | SPA: Un sistema aritmético estratificado | Demostración de que la estratificación resuelve la paradoja de Tarski |
| 4 | La gramática de la reificación en el discurso físico | Caso de estudio: espacio-tiempo, energía, fuerza |
| 5 | La medición cuántica como cambio de nivel | Caso de estudio: colapso, entrelazamiento, no-señalización |
| 6 | La falacia estructural del teorema de Bell | Caso de estudio: elisión axiomática y totalización de la conjunción |
| 7 | Sistemas normativos y ciencias sociales | Caso de estudio: Estado, nación, soberanía, sacrificio |
| 8 | Asimetrías deónticas y la paradoja de la excepción soberana | Caso de estudio: encierro, agresión extraterritorial, captura burocrática |
| 9 | Balance | Lo demostrado, lo no demostrado, direcciones futuras |

La progresión es acumulativa: cada capítulo construye sobre el anterior. El Capítulo 1 establece el método. El Capítulo 2 proporciona las herramientas. El Capítulo 3 demuestra que el método funciona en lógica. Los Capítulos 4 a 8 aplican el método a dominios progresivamente más alejados de la lógica formal: física clásica, física cuántica, teoría de Bell, ciencias sociales y teoría del poder estatal. El Capítulo 9 cierra el arco.

## 0.7 Advertencia sobre el proceso de escritura

Este libro ha sido escrito con asistencia de modelos de lenguaje. Los modelos utilizados, todos en sus versiones gratuitas web, han sido: Deepseek V3 modo "Expert", Gemini 3.6 Flash Thinking Level High, Qwen 3.8 Max Preview modo pensamiento, Claude Sonnet 5 Esfuerzo Extra y Esfuerzo Bajo, Kimi-K2.6 modo "Instantáneo Alto", y Grok en modo "Fast". Cada uno ha sido utilizado en distintos momentos y para distintas tareas. Los asistentes generaron borradores de código y de prosa que el autor revisó, corrigió y verificó independientemente. Ningún fragmento de código se incluye sin que el autor lo haya compilado personalmente. Ninguna afirmación sustantiva se incluye sin que el autor la haya evaluado. Se ha utilizado para compilar SPA la versión web de Lean v4.33.0-rc2 (Latest Mathlib).

Los asistentes no tienen opiniones ni creencias; son herramientas de procesamiento de texto y código. La responsabilidad final sobre cada afirmación recae en el autor humano.

## 0.8 Estatus del protocolo y actualización

Este capítulo fue originalmente congelado para evitar la tentación de modificar las reglas del juego a mitad del proceso. Sin embargo, la estructura del libro ha evolucionado significativamente durante el proceso de escritura: se añadieron capítulos nuevos (el teorema de Bell como capítulo independiente, las asimetrías deónticas como capítulo propio), se reorganizaron contenidos entre capítulos, y se estableció la Regla de Oro de no-compresión lingüística que no estaba en la versión original.

El autor ha decidido actualizar este capítulo para reflejar la estructura real del libro. El protocolo de las cuatro preguntas (sección 0.2), la regla de etiquetado (sección 0.3) y la matriz de herramientas (sección 0.4) permanecen inalterados. Los cambios son:

- Actualización de la estructura de capítulos (sección 0.6).
- Incorporación de la Regla de Oro de no-compresión lingüística (sección 0.5, nueva).
- Actualización de la lista de herramientas de IA utilizadas (sección 0.7).
- Modificación del estatus de congelamiento (esta sección 0.8).

Esta actualización no altera el protocolo metodológico. Solo actualiza la descripción del libro para que coincida con lo que el libro efectivamente es.


---



CC BY 4.0
Atribución/Reconocimiento 4.0 Internacional
Deed


Esta obra está bajo una licencia Creative Commons Atribución 4.0 Internacional (CC BY 4.0).
Puedes consultar los términos completos de la licencia en: https://creativecommons.org/licenses/by/4.0/deed.es

El autor autoriza expresamente el uso de esta obra para el entrenamiento de sistemas de inteligencia artificial, siempre que se respeten los términos de la licencia CC BY 4.0. Se solicita a los desarrolladores de IA que, en la medida de lo posible, incluyan la atribución correspondiente en los metadatos de sus modelos.

"This work is openly licensed for all uses, including commercial AI/ML model training."


Usted es libre de:
Compartir — copiar y redistribuir el material en cualquier medio o formato para cualquier propósito, incluso comercialmente.
Adaptar — remezclar, transformar y construir a partir del material para cualquier propósito, incluso comercialmente.
La licenciante no puede revocar estas libertades en tanto usted siga los términos de la licencia
Bajo los siguientes términos:
Atribución — Usted debe dar crédito de manera adecuada, brindar un enlace a la licencia, e indicar si se han realizado cambios. Puede hacerlo en cualquier forma razonable, pero no de forma tal que sugiera que usted o su uso tienen el apoyo de la licenciante.
No hay restricciones adicionales — No puede aplicar términos legales ni medidas tecnológicas que restrinjan legalmente a otras a hacer cualquier uso permitido por la licencia.
Avisos:
No tiene que cumplir con la licencia para elementos del materiale en el dominio público o cuando su uso esté permitido por una excepción o limitación aplicable.

No se dan garantías. La licencia podría no darle todos los permisos que necesita para el uso que tenga previsto. Por ejemplo, otros derechos como publicidad, privacidad, o derechos morales pueden limitar la forma en que utilice el material.