namespace :dev do
  desc "Configurando o ambiente"
  task setup: :environment do
    if Rails.env.development?
      spinner = TTY::Spinner.new("[:spinner] Configurando o ambiente...")
      show_spinner("Apagando o BD...") { %x(rails db:drop) }
      show_spinner("Criando o BD...") { %x(rails db:create) }
      show_spinner("Migrando o BD...") { %x(rails db:migrate) }
      show_spinner("Populando o BD...") { %x(rails db:seed) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)      
    else
      puts "Você não está em ambiente de desenvolvimento"
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
      add_coins("Bitcoin", "BTC", "https://cryptologos.cc/logos/bitcoin-btc-logo.png", 1)
      add_coins("Ethereum", "ETH", "https://cryptologos.cc/logos/ethereum-eth-logo.png", 2)
      add_coins("Dash", "DASH", "https://cryptologos.cc/logos/dash-dash-logo.png", 3)
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      add_mining_types("Proof of Work", "PoW")
      add_mining_types("Proof of Stake", "PoS")
      add_mining_types("Proof of Capacity", "PoC")
    end
  end

  def show_spinner(msg_start)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(Concluído!)")
  end

  def add_coins(description, acronym, url_image, mining_type_id)
    Coin.find_or_create_by!(
      description: description,
      acronym: acronym,
      url_image: url_image,
      mining_type_id: mining_type_id
    )
  end

  def add_mining_types(description, acronym)
    MiningType.find_or_create_by!(
      description: description,
      acronym: acronym
    )
  end

end
