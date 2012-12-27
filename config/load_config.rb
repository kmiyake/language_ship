config_dir = Rails.root.join('config')

if File.exists?(config_dir.join('config.yml'))
  AppConfig = YAML.load(File.open(config_dir.join('config.yml')).read)
end
