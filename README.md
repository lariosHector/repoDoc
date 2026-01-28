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

### `scan`
Analiza un repositorio local y muestra en consola la información detectada.

### Descripción
- Detecta el stack tecnológico
- Identifica archivos clave (`README`, `LICENSE`, `.gitignore`, etc.)
- Detecta integración continua (CI)
- No genera archivos, solo imprime resultados

### Uso

```bash
swift run RepoDoc scan
```

### Flags
| Flag | Descripción |
|-----|-------------|
| `--path <ruta>` | Ruta del repositorio a analizar (por defecto, el directorio actual) |

---

### `generate`
Genera documentación técnica básica a partir del análisis del repositorio.

### Descripción
- Crea `PROJECT_OVERVIEW.md`
- Crea `docs/STRUCTURE.md`
- Genera la carpeta `docs/` si no existe
- No sobrescribe archivos existentes

### Uso
```bash
 swift run repodoc generate
```

### Flags
| Flag | Descripción |
|-----|-------------|
| `--path <ruta>` | Ruta del repositorio (por defecto, el directorio actual) |
| `--depth <n>` | Profundidad máxima del árbol del repositorio (default: 3) |

---

### `generate-readme`
Genera un `README.md` inteligente usando la información detectada del repositorio.

### Descripción
El README generado incluye:
- Stack tecnológico con enlaces oficiales
- Archivos clave detectados
- CI detectado
- Estructura del proyecto
- Instrucciones básicas de ejecución
- Autor del repositorio (si puede inferirse)
- No sobrescribe `README.md` existente (a menos que se indique)

### Uso
```bash
swift repodoc generate-readme
```

### Flags
| Flag | Descripción |
|-----|-------------|
| `--path <ruta>` | Ruta del repositorio (por defecto, el directorio actual) |
| `--depth <n>` | Profundidad del árbol del repositorio (default: 3) |
| `--force` | Sobrescribe `README.md` si ya existe |

---

### `score`
Evalúa el estado de la documentación del repositorio.

### Descripción
- Calcula un puntaje de documentación (0–100)
- Identifica archivos faltantes
- Sugiere mejoras para elevar la calidad documental
- No genera archivos

### Uso
```bash
swift run repodoc score
```

### Flags
| Flag | Descripción |
|-----|-------------|
| `--path <ruta>` | Ruta del repositorio a evaluar (por defecto, el directorio actual) |

---

### Resumen de Comandos

| Comando | Función principal |
|-------|------------------|
| `scan` | Analiza el repositorio y muestra señales detectadas |
| `generate` | Genera overview y estructura del proyecto |
| `generate-readme` | Genera un README completo e inteligente |
| `score` | Evalúa la calidad de la documentación |

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

## Mejoras Futuras

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
