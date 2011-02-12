require Rails.root.join('lib', 'plot', 'configuration')

Configuration.configure do |config|
  config.format = 'txt'
  config.host   = 'localhost:3000'
end
