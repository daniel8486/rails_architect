# Rails Architect

Uma gem Ruby para análise completa de projetos Rails com foco em arquitetura, TDD, BDD e princípios SOLID.

## Características

- ** Análise de Arquitetura**: Verifica a estrutura padrão do Rails e recomenda padrões opcionais
- ** Análise TDD**: Avalia cobertura de testes e sugere melhorias
- ** Análise BDD**: Identifica funcionalidades BDD com Cucumber e RSpec
- ** Análise SOLID**: Avalia cada princípio SOLID do seu código
- ** Sugestões Inteligentes**: Recomendações específicas para seu projeto
- ** Relatórios Detalhados**: Saída colorida e JSON exportável

## Instalação

Adicione à seu Gemfile:

```ruby
gem 'rails_architect_analyzer'
```

Depois execute:

```bash
bundle install
```

## Uso

### Linha de Comando

Analisar seu projeto Rails atual:

```bash
rails_architect analyze
```

Analisar um projeto específico:

```bash
rails_architect analyze /caminho/para/seu/projeto
```

Obter sugestões de arquitetura:

```bash
rails_architect suggest
```

Salvar relatório em JSON:

```bash
rails_architect analyze --json --output report.json
```

Salvar relatório em arquivo de texto:

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
results[:architecture][:score]      # Score de arquitetura (0-100)
results[:tdd][:score][:score]       # Score de cobertura TDD
results[:bdd][:score][:rating]      # Rating de BDD
results[:solid][:score][:score]     # Score SOLID (0-100)
```

## O que é Analisado?

###  Arquitetura Rails

- Estrutura padrão de diretórios
- Padrões opcionais (Services, Decorators, Policies, Presenters, Interactors, etc.)
- Detecção de "fat models" e "fat controllers"
- Qualidade de organização de helpers

###  Test-Driven Development (TDD)

- Cobertura de testes (modelo de estimativa)
- Número de testes por tipo (models, controllers, services, etc.)
- Uso de RSpec vs Minitest
- Sugestões para melhorar cobertura

###  Behavior-Driven Development (BDD)

- Presença de Cucumber
- Número de feature files e step definitions
- Análise de cenários legíveis (Given/When/Then)
- Testes de integração (request specs)

### Princípios SOLID

1. **Single Responsibility**: Detecta classes com múltiplas responsabilidades
2. **Open/Closed**: Verifica uso de concerns e herança
3. **Liskov Substitution**: Analisa cadeias de herança
4. **Interface Segregation**: Detecta módulos e classes muito grandes
5. **Dependency Inversion**: Avalia uso de service layer e injeção de dependência

## Saída de Exemplo

```
================================================================================
RAILS ARCHITECT - PROJECT ANALYSIS REPORT
================================================================================

ARCHITECTURE ANALYSIS
────────────────────────────────────────────────────────────────────────────────
Overall Score: 65%

✓ Existing Directories (9/10):
  ✅ app/models (8 files)
  ✅ app/controllers (12 files)
  ✅ app/views (45 files)
  ...

Suggestions:
  • Consider creating 'app/services' directory for business logic
  • Create 'app/decorators' for separating presentation logic from models
  ...

TEST-DRIVEN DEVELOPMENT (TDD) ANALYSIS
────────────────────────────────────────────────────────────────────────────────
Coverage Score: 45.5% ⚠️  Fair

Test Files:
  • Spec files: 28
  • Test files: 0
  • Total: 28

...
```

## Configuração

A gem funciona out-of-the-box. Coloque na raiz do seu projeto Rails:

```ruby
# config/initializers/rails_architect.rb (opcional)
# Configurações futuras
```

## Padrões Recomendados

### 1. Services (app/services)

```ruby
# app/services/user_creator.rb
class UserCreator
  def initialize(user_params)
    @user_params = user_params
  end

  def call
    User.create(@user_params)
  end
end

# Uso
UserCreator.new(params).call
```

### 2. Decorators (app/decorators)

```ruby
# app/decorators/user_decorator.rb
class UserDecorator
  def initialize(user)
    @user = user
  end

  def full_name_with_email
    "#{@user.full_name} <#{@user.email}>"
  end
end
```

### 3. Concerns (app/concerns)

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
```

### 4. Policies (app/policies) com Pundit

```ruby
# app/policies/post_policy.rb
class PostPolicy
  def initialize(user, post)
    @user = user
    @post = post
  end

  def update?
    @user == @post.author
  end
end
```

### 5. Presenters (app/presenters)

```ruby
# app/presenters/dashboard_presenter.rb
class DashboardPresenter
  def initialize(user)
    @user = user
  end

  def total_posts
    @user.posts.count
  end
end
```

## Melhorias Futuras

- [ ] Análise de performance
- [ ] Detecção de code smells
- [ ] Sugestões de gems para padrões
- [ ] Integração com CI/CD
- [ ] Dashboard web
- [ ] Comparação entre projetos
- [ ] Análise histórica

## Contribuindo

1. Faça um fork
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## Licença

MIT License - veja LICENSE.md para detalhes

## Changelog

### v0.1.0
- Versão inicial com análise de arquitetura, TDD, BDD e SOLID
- CLI completa com múltiplas opções de saída
- Relatórios detalhados e coloridos

## Autor

Daniel Matos - [@daniel8486](https://github.com/daniel8486)

## Suporte

Para reportar bugs ou sugerir features, abra uma issue no [GitHub](https://github.com/daniel8486/rails_architect/issues).
