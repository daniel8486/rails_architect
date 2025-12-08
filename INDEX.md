# 📚 Índice de Documentação - Rails Architect

## 🚀 Primeiros Passos

- **[QUICKSTART.md](QUICKSTART.md)** - Comece em minutos
  - Instalação simples
  - Primeiros comandos
  - Interpretação de resultados
  - Dicas de início rápido

## 📖 Documentação Principal

- **[README.md](README.md)** - Documentação completa
  - Características
  - Instalação detalhada
  - Uso em linha de comando e código
  - O que é analisado
  - Padrões recomendados
  - Roadmap

- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Guia de contribuição
  - Como contribuir
  - Diretrizes
  - Roadmap
  - Referências

## 💻 Exemplos e Padrões

- **[REFACTORING_EXAMPLES.md](REFACTORING_EXAMPLES.md)** - Exemplos práticos
  - Problema 1: Fat Models
  - Problema 2: Fat Controllers
  - Problema 3: Dependency Injection
  - Problema 4: Falta de Testes
  - Problema 5: DRY com Concerns
  - Resumo de melhorias

## 📦 Publicação

- **[PUBLISHING.md](PUBLISHING.md)** - Publicar no RubyGems
  - Configuração de credenciais
  - Passos de publicação
  - Checklist
  - Troubleshooting
  - Guia de versionamento

## 📝 Histórico

- **[CHANGELOG.md](CHANGELOG.md)** - Histórico de versões
  - v0.1.0 - Versão inicial
  - Planejado para futuras versões

## 📋 Código de Conduta

- **[CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)** - Código de conduta
  - Nossa promessa
  - Padrões aceitáveis
  - Responsabilidades

## 🔧 Referência Rápida

### Instalação
```bash
gem 'rails_architect'
bundle install
```

### Uso
```bash
rails_architect analyze           # Análise completa
rails_architect suggest           # Apenas sugestões
rails_architect analyze --json --output report.json
```

### Estrutura do Projeto

```
rails_architect/
├── lib/
│   ├── rails_architect.rb                    # Entrada principal
│   ├── rails_architect/
│   │   ├── version.rb                        # Versão
│   │   ├── cli.rb                           # Interface de linha de comando
│   │   ├── analyzers/                       # Analisadores
│   │   │   ├── architecture_analyzer.rb
│   │   │   ├── tdd_analyzer.rb
│   │   │   ├── bdd_analyzer.rb
│   │   │   └── solid_analyzer.rb
│   │   └── reporters/                       # Geradores de relatórios
│   │       └── report_generator.rb
├── exe/
│   └── rails_architect                      # Executável
├── spec/
│   └── rails_architect/
│       ├── rails_architect_spec.rb
│       └── analyzers/
│           └── architecture_analyzer_spec.rb
├── rails_architect.gemspec                  # Especificação da gem
├── Gemfile                                  # Dependências
├── Rakefile                                 # Tasks
├── README.md
├── QUICKSTART.md
├── CONTRIBUTING.md
├── REFACTORING_EXAMPLES.md
├── PUBLISHING.md
├── CODE_OF_CONDUCT.md
├── CHANGELOG.md
├── LICENSE.md
└── .gitignore
```

### Analisadores Disponíveis

1. **ArchitectureAnalyzer** (`lib/rails_architect/analyzers/architecture_analyzer.rb`)
   - Valida estrutura padrão Rails
   - Detecta padrões opcionais
   - Encontra "fat models" e "fat controllers"
   - Score: 0-100%

2. **TddAnalyzer** (`lib/rails_architect/analyzers/tdd_analyzer.rb`)
   - Avalia cobertura de testes
   - Conta testes por tipo
   - Estima qualidade TDD
   - Score: 0-100%

3. **BddAnalyzer** (`lib/rails_architect/analyzers/bdd_analyzer.rb`)
   - Verifica BDD (Cucumber/RSpec)
   - Analisa feature files
   - Valida user stories
   - Score: 0-100%

4. **SolidAnalyzer** (`lib/rails_architect/analyzers/solid_analyzer.rb`)
   - Avalia 5 princípios SOLID
   - Detecta violações
   - Sugere refatorações
   - Score: 0-100

### Reportes

**ReportGenerator** (`lib/rails_architect/reporters/report_generator.rb`)
- Gera relatórios coloridos
- Exporta para JSON
- Fornece recomendações

### CLI

**CLI** (`lib/rails_architect/cli.rb`)
- `analyze` - análise completa
- `suggest` - apenas sugestões
- `version` - mostrar versão

## ❓ Dúvidas Frequentes

### Como instalar?
Veja [QUICKSTART.md](QUICKSTART.md) para instruções passo a passo.

### Como usar?
```bash
rails_architect analyze
```

### Como interpretar os scores?
Veja a seção "Interpretando os Resultados" em [QUICKSTART.md](QUICKSTART.md).

### Posso usar em meu projeto Rails?
Sim! A gem é compatível com Rails 6.0+.

### Como contribuir?
Veja [CONTRIBUTING.md](CONTRIBUTING.md).

### Como publicar?
Veja [PUBLISHING.md](PUBLISHING.md).

## 🔗 Links Úteis

- **GitHub**: https://github.com/danielmatos-pro/rails_architect
- **RubyGems**: https://rubygems.org/gems/rails_architect
- **Issues**: https://github.com/danielmatos-pro/rails_architect/issues
- **Discussions**: https://github.com/danielmatos-pro/rails_architect/discussions

## 📞 Suporte

- 📧 Email: seu-email@example.com
- 🐛 Bugs: Abra uma issue no GitHub
- 💬 Dúvidas: Inicie uma discussão no GitHub

---

**Última atualização:** 8 de dezembro de 2025

**Versão:** 0.1.0

**Licença:** MIT
