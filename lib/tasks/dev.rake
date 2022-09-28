namespace :dev do
  DEFAULT_PASSWORD = 123123

  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Excluíndo Banco de Dados existente") { %x(rails db:drop) }
      show_spinner("Criando Banco de Dados") { %x(rails db:create) }
      show_spinner("Migrando tabelas do Banco de Dados") { %x(rails db:migrate) }
      show_spinner("Criando administradores") { %x(rails dev:add_default_admin) }
      show_spinner("Criando usuários") { %x(rails dev:add_default_user) }
    else
      puts 'Você não está em ambiente de desenvolvimento'
    end
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@example.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD,
    )
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@example.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD,
    )
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("- #{msg_end}")
  end
end
