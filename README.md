# mydeploy
Mis archivos de despligue de fastDeploy

## Estilo para escribir commands.ymal

# name

Siempre debe ser un verbo en infinitivo (no en primera persona, ni en gerundio).

Objetivo: que suene como una acción clara y neutral.

Ejemplos correctos:

"verificar Maven"

"ejecutar pruebas unitarias"

"generar paquete JAR"

"instalar dependencias en el repositorio local"

# description

Siempre redactada en tercera persona, impersonal, explicando qué hace el comando.

Evitar "yo" o "tú" (primera/segunda persona).

Usar frases cortas, técnicas y precisas.

Ejemplos correctos:

"verifica que Maven esté instalado"

"elimina artefactos previos, recompila el proyecto y ejecuta las pruebas unitarias"

"empaqueta el código compilado en un archivo JAR"

"instala el paquete en el repositorio local de Maven"

# Terraform outputs description

## Estructura de la descripción

Verbo en tercera persona, impersonal: Proporciona, Devuelve, Indica, Especifica.

Objeto principal: el recurso o valor que se expone.

Contexto opcional: el servicio o finalidad del valor.

👉 Formato recomendado:

    <Verbo> <qué valor expone> <contexto opcional>

Ejemplo:

"Proporciona el nombre del grupo de recursos de Azure."

"Devuelve la URL del servidor de inicio de sesión del Azure Container Registry."

## Verbos recomendados

Proporciona → para valores generales (ej. nombres).

Devuelve → para endpoints, URLs, identificadores.

Indica → para estados o banderas booleanas.

Especifica → cuando se describe un valor exacto de configuración.
