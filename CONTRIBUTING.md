<!-- markdownlint-disable MD033 -->
<a href="https://github.com/danielmatos-pro/rails_architect">
  <img alt="Rails Architect" src="https://img.shields.io/badge/Rails-Architect-blue?style=for-the-badge&logo=rails" />
</a>
<a href="https://github.com/danielmatos-pro/rails_architect/blob/main/LICENSE.md">
  <img alt="License" src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" />
</a>
<a href="https://rubygems.org/gems/rails_architect">
  <img alt="Gem Version" src="https://img.shields.io/gem/v/rails_architect?style=for-the-badge" />
</a>

---

# Rails Architect

🏗️ Uma gem Ruby para análise completa de projetos Rails com foco em **arquitetura**, **TDD**, **BDD** e **princípios SOLID**.

A Rails Architect analisa automaticamente a estrutura do seu projeto Rails e fornece sugestões detalhadas para melhorias em qualidade de código, cobertura de testes e aderência aos princípios SOLID.

## 📋 Tabela de Conteúdos

- [Características](#características)
- [Instalação](#instalação)
- [Uso](#uso)
- [O que é Analisado](#o-que-é-analisado)
- [Exemplos](#exemplos)
- [Padrões Recomendados](#padrões-recomendados)
- [Contribuindo](#contribuindo)
- [Licença](#licença)

## ✨ Características

- **📐 Análise de Arquitetura**: Verifica a estrutura padrão do Rails e recomenda padrões opcionais
- **🧪 Análise TDD**: Avalia cobertura de testes e sugere melhorias
- **🎯 Análise BDD**: Identifica funcionalidades BDD com Cucumber e RSpec
- **⚡ Análise SOLID**: Avalia cada princípio SOLID do seu código
- **💡 Sugestões Inteligentes**: Recomendações específicas e acionáveis para seu projeto
- **📊 Relatórios Detalhados**: Saída colorida em terminal e exportação em JSON
- **🔍 Detecção de Problemas**: Identifica "fat models", "fat controllers" e violações de SOLID
- **⚙️ CLI Completa**: Ferramenta de linha de comando intuitiva e poderosa

## 🚀 Instalação

### 1. Via Gemfile

Adicione à seu `Gemfile`:

```ruby
gem 'rails_architect'
```

Execute:

```bash
bundle install
```

### 2. Via Gem Manual

```bash
gem install rails_architect
```

## 📖 Uso

### Linha de Comando

#### Analisar projeto atual

```bash
rails_architect analyze
```

#### Analisar um projeto específico

```bash
rails_architect analyze /caminho/para/seu/projeto
```

#### Obter sugestões de arquitetura

```bash
rails_architect suggest
```

#### Salvar relatório em JSON

```bash
rails_architect analyze --json --output report.json
```

#### Salvar relatório em arquivo de texto

```bash
rails_architect analyze --output report.txt
```

### Dentro do Código Rails

```ruby
# Analisar projeto atual
results = RailsArchitect.analyze

# Analisar projeto específico
results = RailsArchitect.analyze('/caminho/para/seu/projeto')

# Acessar resultados específicos
puts results[:architecture][:score]      # Score de arquitetura (0-100)
puts results[:tdd][:score][:score]       # Score de cobertura TDD
puts results[:bdd][:score][:rating]      # Rating de BDD
puts results[:solid][:score][:score]     # Score SOLID (0-100)
```

## 📊 O que é Analisado?

### 📐 Análise de Arquitetura Rails

Verifica e recomenda:

- ✅ Estrutura padrão de diretórios (models, controllers, views, etc.)
- ✅ Padrões opcionais:
  - Services (app/services)
  - Decorators (app/decorators)
  - Policies (app/policies)
  - Presenters (app/presenters)
  - Interactors (app/interactors)
  - Concerns (app/concerns)
  - Validators (app/validators)
- ⚠️ Detecção de "fat models" (modelos muito grandes)
- ⚠️ Detecção de "fat controllers" (controladores muito grandes)
- ⚠️ Qualidade de organização de helpers

### 🧪 Análise de TDD (Test-Driven Development)

Avalia:

- Cobertura de testes (modelo de estimativa)
- Número de testes por tipo:
  - Testes de modelos
  - Testes de controladores
  - Testes de serviços
  - Testes de helpers
  - Testes de requisição
- Uso de RSpec vs Minitest
- Sugestões para melhorar cobertura
- Score de cobertura: 0-100%

### 🎯 Análise de BDD (Behavior-Driven Development)

Verifica:

- Presença de Cucumber
- Número de feature files e step definitions
- Análise de cenários legíveis (Given/When/Then)
- User stories estruturadas
- Testes de integração (request specs)
- Reusabilidade de steps

### ⚡ Análise de Princípios SOLID

Avalia cada um dos 5 princípios:

1. **S**ingle Responsibility Principle (SRP)
   - Detecta classes com múltiplas responsabilidades
   - Sugere extração de lógica em services

2. **O**pen/Closed Principle (OCP)
   - Verifica uso de concerns e herança
   - Incentiva extensibilidade sem modificação

3. **L**iskov Substitution Principle (LSP)
   - Analisa cadeias de herança
   - Detecta profundidade de herança excessiva

4. **I**nterface Segregation Principle (ISP)
   - Detecta módulos e classes muito grandes
   - Sugera segregação de interfaces

5. **D**ependency Inversion Principle (DIP)
   - Avalia uso de service layer
   - Recomenda injeção de dependência

**Score SOLID**: 0-100 pontos (20 pontos por princípio)

## 📈 Exemplo de Saída

```
================================================================================
🏗️  RAILS ARCHITECT - PROJECT ANALYSIS REPORT
================================================================================

📐 ARCHITECTURE ANALYSIS
────────────────────────────────────────────────────────────────────────────────
Overall Score: 65%

✓ Existing Directories (9/10):
  ✅ app/models (8 files)
  ✅ app/controllers (12 files)
  ✅ app/views (45 files)
  ✅ app/helpers (5 files)
  ✅ app/services (3 files)
  ✅ config (25 files)
  ✅ lib (8 files)
  ✅ spec (45 files)
  ❌ app/decorators

⚠️  Missing Important Directories:
  • app/decorators
  • app/policies

📦 Optional Patterns Available:
  ✅ Implemented - Service Objects (app/services)
  ❌ Not used - Decorator Pattern (app/decorators)
  ❌ Not used - Authorization Policies (app/policies)

💡 Suggestions:
  • Consider creating 'app/decorators' directory for separating presentation logic
  • Implement 'app/policies' directory for authorization logic

🧪 TEST-DRIVEN DEVELOPMENT (TDD) ANALYSIS
────────────────────────────────────────────────────────────────────────────────
Coverage Score: 65.5% ✅ Good

Test Files:
  • Spec files: 48
  • Test files: 0
  • Total: 48

🎯 BEHAVIOR-DRIVEN DEVELOPMENT (BDD) ANALYSIS
────────────────────────────────────────────────────────────────────────────────
BDD Score: ✅ Some BDD coverage

Frameworks:
  • Cucumber: ❌ Not installed
  • RSpec: ✅ Installed

⚡ SOLID PRINCIPLES ANALYSIS
────────────────────────────────────────────────────────────────────────────────
SOLID Score: 72/100 ✅ Good

Principle Analysis:

1. Single Responsibility Principle (SRP)
   Status: ✅ Good

2. Open/Closed Principle (OCP)
   Status: ✅ Some patterns found

3. Liskov Substitution Principle (LSP)
   Status: ✅ Good

...

📊 OVERALL SUMMARY
================================================================================
Architecture:  65%
TDD Coverage:  65.50% ✅ Good
BDD Practices: ✅ Some BDD coverage
SOLID Score:   72/100 ✅ Good

🚀 RECOMMENDATIONS FOR IMPROVEMENT
================================================================================

1. Consider creating 'app/decorators' directory
2. ⚠️ Detected fat models. Consider extracting logic to services
3. Add model specs/tests to ensure data validation logic
4. Consider using Cucumber for BDD with human-readable scenarios
...
```

## 💡 Padrões Recomendados

### 1. Services (app/services)

Encapsule lógica de negócio complexa:

```ruby
# app/services/user_creator.rb
class UserCreator
  def initialize(user_params)
    @user_params = user_params
  end

  def call
    User.create!(@user_params)
  end
end

# Uso
UserCreator.new(params).call
```

### 2. Decorators (app/decorators)

Separe lógica de apresentação dos modelos:

```ruby
# app/decorators/user_decorator.rb
class UserDecorator
  def initialize(user)
    @user = user
  end

  def full_name_with_email
    "#{@user.full_name} <#{@user.email}>"
  end

  def formatted_created_at
    @user.created_at.strftime('%d/%m/%Y')
  end
end

# Uso em views
<%= UserDecorator.new(@user).full_name_with_email %>
```

### 3. Concerns (app/concerns)

Compartilhe comportamentos entre modelos:

```ruby
# app/concerns/timestampable.rb
module Timestampable
  extend ActiveSupport::Concern

  included do
    before_save :update_timestamps
  end

  def update_timestamps
    self.updated_at = Time.current
  end
end

# Uso
class Post < ApplicationRecord
  include Timestampable
end
```

### 4. Policies (app/policies)

Use Pundit para autorização:

```ruby
# app/policies/post_policy.rb
class PostPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    @user == @post.author
  end

  def destroy?
    @user == @post.author || @user.admin?
  end
end

# Uso no controller
authorize @post, :update?
```

### 5. Presenters (app/presenters)

Prepare dados para a camada de apresentação:

```ruby
# app/presenters/dashboard_presenter.rb
class DashboardPresenter
  def initialize(user)
    @user = user
  end

  def total_posts
    @user.posts.count
  end

  def recent_posts
    @user.posts.recent.limit(5)
  end

  def stats
    {
      posts: total_posts,
      comments: @user.comments.count
    }
  end
end

# Uso no controller
@dashboard = DashboardPresenter.new(current_user)
```

## 🧪 Testes

Execute os testes da gem:

```bash
cd rails_architect
bundle install
rake spec
```

## 🔄 Desenvolvimento

### Setup

```bash
git clone https://github.com/daniel8486/rails_architect.git
cd rails_architect
bundle install
```

### Testes

```bash
rake spec
```

### Console IRB

```bash
rake console
```

## 🤝 Contribuindo

Contribuições são muito bem-vindas! Para manter a qualidade:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request
6. Certifique-se de que os testes passam

### Diretrizes

- Mantenha o código limpo e bem documentado
- Escreva testes para novas funcionalidades
- Siga o estilo de código do projeto
- Atualize a documentação conforme necessário

## 📋 Roadmap

- [ ] Análise de performance
- [ ] Detecção de code smells
- [ ] Sugestões de gems para padrões
- [ ] Integração com CI/CD (GitHub Actions, GitLab CI)
- [ ] Dashboard web interativo
- [ ] Comparação entre versões do projeto
- [ ] Análise histórica de métricas
- [ ] Exportação em múltiplos formatos (PDF, HTML)
- [ ] Suporte a gems de qualidade (Rubocop, Brakeman)

## 📝 Changelog

### v0.1.0 (2025-12-08)

**Features:**
- ✨ Análise inicial de arquitetura Rails
- ✨ Análise de TDD com estimativa de cobertura
- ✨ Análise de BDD com Cucumber e RSpec
- ✨ Análise de princípios SOLID
- ✨ CLI completa com múltiplas opções de saída
- ✨ Relatórios detalhados e coloridos em terminal
- ✨ Exportação em JSON

**Bugfixes:**
- 🐛 Correções iniciais

## 📄 Licença

MIT License - veja [LICENSE.md](LICENSE.md) para detalhes completos

```
Copyright (c) 2025 Daniel Matos

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software.
```

## 🙋 Suporte

### Issues

Para reportar bugs ou sugerir features, abra uma issue no [GitHub Issues](https://github.com/daniel8486/rails_architect/issues).

### Discussões

Tenha dúvidas? Inicie uma discussão no [GitHub Discussions](https://github.com/daniel8486/rails_architect/discussions).

## 👨‍💻 Autor

**Daniel Matos**
- GitHub: [@daniel8486](https://github.com/daniel8486)
- Email: eu@danieldjam.dev.br | danielmatos404@gmail.com

## 🙏 Agradecimentos

- Comunidade Rails por melhores práticas
- Inspiração em ferramentas de análise como RuboCop, Brakeman e Flay
- Todos os contribuidores que ajudam a melhorar a gem

## 📚 Referências e Leitura Recomendada

- [Rails Guides - Active Record](https://guides.rubyonrails.org/active_record_basics.html)
- [SOLID Principles](https://en.wikipedia.org/wiki/SOLID)
- [RSpec Best Practices](https://rspec.info/)
- [Cucumber.io Documentation](https://cucumber.io/docs/gherkin/)
- [Clean Code by Robert C. Martin](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882)
- [Refactoring: Improving the Design of Existing Code](https://refactoring.com/)

---

<p align="center">
  <strong>Feito com ❤️ para a comunidade Rails</strong>
</p>

<p align="center">
  <a href="https://github.com/daniel8486/rails_architect">⭐ Star no GitHub</a>
  •
  <a href="https://github.com/daniel8486/rails_architect/issues">🐛 Reportar Bug</a>
  •
  <a href="https://github.com/daniel8486/rails_architect/issues">💡 Sugerir Feature</a>
</p>
