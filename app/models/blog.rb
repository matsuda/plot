class Blog
  class ArticleNotFound < RuntimeError
  end

  class << self
    def method_missing(method_id, *args, &block)
      if Configuration.configuration.respond_to?(method_id)
        Configuration.configuration.__send__ method_id
      else
        super
      end
    end
  end
end
