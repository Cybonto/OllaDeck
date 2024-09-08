# OllaDeck

OllaDeck is a purple technology stack for Generative AI (text modality) cybersecurity. It provides a comprehensive set of tools for both blue team and red team operations in the context of text-based generative AI.

## News

- First release of OllaDeck is now available!
- Setup verified with AMD64 architecture, Docker for Desktop on Windows, WSL2 with Ubuntu, and local storage.

## Table of Contents

- [Overview](#overview)
- [Key Components](#key-components)
- [Code of Conduct](#code-of-conduct)
- [Blue Team](#blue-team)
- [Red Team](#red-team)
- [Installation](#installation)
- [Usage](#usage)
- [News](#news)
- [Planned Items](#planned-items)
- [Contributing](#contributing)
- [License](#license)

## Overview

OllaDeck is a purple technology stack for Generative AI (text modality) security. It combines LLM platforms, various database types, and specialized tools for both offensive and defensive cybersecurity operations.

## Key Components

1. LLM platforms for loading, managing, and performing LLM operations (e.g., chat)
2. Vector, graph, and traditional databases for data operations
3. Red team instance with tools for Generative AI (text modality)
4. Blue team instance with Generative AI-based defense tools
5. Sample endpoints for simulated attacks and defenses

## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project and/or cloning the project, you agree to abide by its terms.

## Blue Team

The blue team in the context of text-based generative AI focuses on defending and securing AI systems. This includes activities such as:

- Monitoring AI model outputs for potential vulnerabilities
- Implementing safeguards against prompt injection and other AI-specific attacks
- Ensuring compliance with ethical AI guidelines and regulations
- Analyzing AI-generated content for potential security risks

### Blue Team Tools
Currently, OllaDeck has the following Blue Team tools.

#### Foundational Tools
- **AutoGluon**: Automates machine learning tasks
- **AutoViz**: Automated visualization library
- **python-dateutil**: Powerful extensions to the standard datetime module
- **lxml**: Library for processing XML and HTML

#### Natural Language Processing Tools
- **PyPDF2**: PDF file manipulation
- **docx**: Python library for creating and updating Microsoft Word (.docx) files
- **openpyxl**: Python library to read/write Excel files
- **Tesseract**: Optical Character Recognition engine
- **TextBlob**: Simplified text processing
- **Gensim**: Topic modeling, document indexing, and similarity retrieval

#### Compliance Tools
- **Compliance Masonry**: Tool for building compliance documentation

#### Threat Intel Tools
- **CybOX**: Structured language for cyber observables
- **STIX**: Structured language for cyber threat intelligence

## Red Team

The red team in text-based generative AI focuses on identifying vulnerabilities and potential attack vectors in AI systems. Activities include:

- Crafting adversarial prompts to manipulate AI outputs
- Testing AI model robustness against various attack techniques
- Exploring potential data leakage or privacy concerns in AI responses
- Simulating real-world attack scenarios on AI systems

### Red Team Tools
Currently, OllaDeck has the following Blue Team tools.
- **pyRIT**: Red team automation toolkit
- **TextAttack**: Framework for adversarial attacks on NLP models
- **Adversarial Robustness Toolbox**: Library for machine learning security
- **Garak**: LLM vulnerability scanner

## Installation

For detailed installation instructions, please refer to our [Installation Guide](INSTALLATION.md).

## Planned Items

- Add more JupyterNotebook examples
- Add more datasets
- Enhanced documentation and user guides
- Add more tools for both blue and red team operations

## Contributing

We welcome contributions to OllaDeck! Please see our [Contributing Guide](CONTRIBUTING.md) for more information on how to get started.

## License

[MIT](LICENSE)