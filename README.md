# RepoDoc CLI

RepoDoc CLI es una herramienta de línea de comandos desarrollada en **Swift** que permite **analizar un repositorio de software y generar documentación técnica básica de forma automática**.  
Está orientada a estudiantes y desarrolladores que desean contar con una base documental clara y consistente sin invertir tiempo en crearla manualmente.

---

## 📌 Características

- 🔎 Escaneo de repositorios locales
- 🧠 Detección automática del stack tecnológico
- 📦 Identificación de archivos clave (README, LICENSE, etc.)
- 🤖 Detección de integración continua (CI)
- 📄 Generación automática de documentación en Markdown
- 📊 Evaluación del estado de la documentación mediante un puntaje (Doc Health Score)
- 🔒 Modo seguro: no sobrescribe archivos existentes

---

## 🛠️ Requisitos

- macOS 13 o superior  
- Swift 5.9 o superior  
- Swift Package Manager (incluido con Swift)

---

## 📦 Instalación

Clona el repositorio:

```bash
git clone https://github.com/USUARIO/repodoc.git
cd repodoc
```

Compila el proyecto:

```bash
swift build
```

Ejecuta la herramienta:

```bash
swift run repodoc
```

> Nota: El nombre del ejecutable puede ser `RepoDoc` o `repodoc` dependiendo de la configuración del `Package.swift`.

---

## 🚀 Uso

RepoDoc CLI funciona a través de subcomandos.

### 🔍 Scan
Analiza el repositorio y muestra la información detectada en consola.

```bash
swift run RepoDoc scan
```

Opcionalmente puedes indicar una ruta específica:

```bash
swift run RepoDoc scan --path /ruta/al/repositorio
```

---

### 📄 Generate
Genera documentación técnica en formato Markdown.

```bash
swift run RepoDoc generate
```

Archivos generados:
- `PROJECT_OVERVIEW.md`
- `docs/STRUCTURE.md`

Puedes limitar la profundidad del árbol del repositorio:

```bash
swift run RepoDoc generate --depth 2
```

> RepoDoc no sobrescribe archivos existentes.

---

### 📊 Score
Evalúa el estado de la documentación del repositorio.

```bash
swift run RepoDoc score
```

Salida esperada:
- Puntaje de documentación (0–100)
- Elementos faltantes
- Recomendaciones de mejora

---

## 📂 Estructura del Proyecto

```
Sources/
└── RepoDoc/
    ├── RepoDocCLI.swift
    ├── Scan.swift
    ├── Generate.swift
    ├── Score.swift
    ├── RepoScanner.swift
    ├── StackDetector.swift
    ├── CIDetector.swift
    ├── DocGenerator.swift
    ├── DirectoryTreeBuilder.swift
    ├── DocScorer.swift
    └── ConsolePrinter.swift
```

---

## 🧠 Diseño del Sistema

RepoDoc CLI sigue una arquitectura modular:

- **CLI**: Manejo de comandos y argumentos
- **Scanner**: Recorre la estructura del repositorio
- **Detector**: Identifica tecnologías y CI
- **Generator**: Produce archivos de documentación
- **Score**: Evalúa la calidad documental

Esta separación facilita el mantenimiento y la escalabilidad del proyecto.

---

## 🔮 Mejoras Futuras

- Soporte para repositorios remotos (GitHub/GitLab)
- Generación de diagramas de arquitectura
- Plantillas de documentación personalizables
- Sistema de plugins para nuevos detectores
- Análisis más profundo del código fuente

---

## 📄 Licencia

Este proyecto se distribuye con fines académicos.  
La licencia puede añadirse o modificarse según las necesidades del proyecto.

---

## 👤 Autor

**Larios Ponce Héctor Manuel**  
Proyecto académico – UNAM  
Asignatura: Desarrollo de aplicaciones para dispositivos iOS

---

## 📎 Notas Finales

RepoDoc CLI fue desarrollado como un proyecto académico con enfoque en buenas prácticas de ingeniería de software, automatización y herramientas profesionales utilizadas en entornos reales.
