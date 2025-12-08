# 🚀 Testando Rails Architect - Guia Prático

## Passo 1: Instalar Dependências

```bash
cd rails_architect
bundle install
```

**Esperado:** Instala todas as gems do Gemfile.

## Passo 2: Verificar Executável

```bash
# Ver se o executável funciona
bundle exec exe/rails_architect version
```

**Esperado Output:**
```
Rails Architect 0.1.0
```

## Passo 3: Testar em um Projeto Rails Real

### Opção A: Usar um projeto Rails existente

```bash
# Se você tiver um projeto Rails
cd /seu/projeto/rails
bundle exec rails_architect analyze .
```

### Opção B: Criar um projeto Rails de teste

```bash
# Criar projeto Rails temporário
cd /tmp
rails new test_rails_app
cd test_rails_app

# Testar a gem
/Users/danielmatos-pro/www/created_ruby_gem/rails_architect/exe/rails_architect analyze .
```

## Passo 4: Testar Comandos

```bash
cd rails_architect

# 1. Análise completa
bundle exec exe/rails_architect analyze /seu/projeto/rails

# 2. Ver apenas sugestões
bundle exec exe/rails_architect suggest /seu/projeto/rails

# 3. Exportar JSON
bundle exec exe/rails_architect analyze /seu/projeto/rails --json --output report.json

# 4. Ver versão
bundle exec exe/rails_architect version
```

## Passo 5: Testar em Ruby Interativo

```bash
cd rails_architect

bundle exec irb -Ilib -rrails_architect

# No console IRB:
project_path = '/seu/projeto/rails'
results = RailsArchitect.analyze(project_path)
puts results[:architecture][:score]
```

## Passo 6: Executar Testes (RSpec)

```bash
cd rails_architect

# Todos os testes
bundle exec rake spec

# Um arquivo específico
bundle exec rspec spec/rails_architect_spec.rb

# Com saída detalhada
bundle exec rspec -v
```

## Passo 7: Verificar Código (RuboCop)

```bash
cd rails_architect

# Verificar
bundle exec rubocop

# Auto-corrigir
bundle exec rubocop -a
```

## ✅ Checklist Completo

```bash
# 1. Dependências
cd rails_architect && bundle install

# 2. Versão
bundle exec exe/rails_architect version

# 3. Testes
bundle exec rake spec

# 4. RuboCop
bundle exec rubocop

# 5. Analisar projeto de teste
bundle exec exe/rails_architect analyze /seu/projeto/rails

# 6. Sugestões
bundle exec exe/rails_architect suggest /seu/projeto/rails
```

## 🐛 Se Encontrar Erros

### Erro: "Could not find gem 'rails_architect'"

```bash
cd rails_architect
bundle install
```

### Erro: "No such file or directory"

```bash
# Certifique-se de estar no diretório correto
cd rails_architect
pwd  # Deve mostrar o path correto
```

### Erro: "Gem not found"

```bash
# Instale localmente
cd rails_architect
bundle exec rake build
gem install pkg/rails_architect-0.1.0.gem
```

---

**Comece pelo Passo 1 e vá seguindo em ordem!** 🎯
