class Configuration
  cattr_accessor :configuration

  attr_accessor :author
  attr_accessor :title
  attr_accessor :description
  attr_accessor :keywords
  attr_accessor :host
  attr_accessor :format
  attr_accessor :limit

  def initialize
    default_config.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def default_config
    {
      :author       => ENV['USER'],
      :title        => %Q{My Blog},
      :description  => %Q{My Blog's description},
      :keywords     => %Q{Blog},
      :host         => '127.0.0.1',
      :format       => 'txt',
      :limit        => 20
    }
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
