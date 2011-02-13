class Archives < Array
  class << self
    def archive(options = {})
      limit = options.delete(:limit) || Blog.limit
      self.new.tap do |archives|
        idx = 0
        self.articles.each do |article_file|
          break if idx >= limit
          slug = File.basename(article_file)
          slug =~ /^(\d{4})-(\d{2})-(\d{2})-(.+)\.\w+$/
          archives << Article.new($1, $2, $3, $4)
          idx += 1
        end
      end
    end

    def articles
      Dir[File.join(Article.articles_path, '*')].sort_by{ |article| File.basename(article) }
    end
  end
end
