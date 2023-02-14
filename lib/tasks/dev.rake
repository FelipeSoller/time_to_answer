namespace :dev do
  DEFAULT_PASSWORD = 123123
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc 'Configura o ambiente de desenvolvimento'
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Excluíndo Banco de Dados existente") { %x(rails db:drop) }
      show_spinner("Criando Banco de Dados") { %x(rails db:create) }
      show_spinner("Migrando tabelas do Banco de Dados") { %x(rails db:migrate) }
      show_spinner("Criando administrador padrão") { %x(rails dev:add_default_admin) }
      show_spinner("Criando administradores aleatórios") { %x(rails dev:add_random_admins) }
      show_spinner("Criando usuários") { %x(rails dev:add_default_user) }
      show_spinner("Criando assuntos padrão") { %x(rails dev:add_subject) }
      show_spinner("Cadastrando as perguntas e respostas") { %x(rails dev:add_answers_and_questions) }
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

  desc "Adiciona administradores aleatórios"
  task add_random_admins: :environment do
    100.times do
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD,
      )
    end
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@example.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD,
    )
  end

  desc "Adiciona assuntos padrão"
  task add_subject: :environment do
    file_name = 'subjects.txt'
    file_path = File.join(DEFAULT_FILES_PATH, file_name)

    File.open(file_path, 'r').each do |line|
      Subject.create!(description: line.strip)
    end
  end

  desc "Adiciona perguntas e respostas"
  task add_answers_and_questions: :environment do
    Subject.all.each do |subject|
      rand(2..5).times do |i|
        Question.create!(
          description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
          subject: subject
        )
      end
    end
  end

  private

  def show_spinner(msg_start, msg_end = "Concluído com sucesso!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("- #{msg_end}")
  end
end
