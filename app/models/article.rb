require 'yaml'

class Article
  cattr_accessor :articles_path
  self.articles_path = Rails.root.join('articles')

  # attr_accessor :title
  attr_accessor :content
  attr_accessor :slug
  attr_accessor :published_at

  attr_accessor :meta

  def initialize(year, month, day, slug)
    date = Date.new(year.to_i, month.to_i, day.to_i)
    @slug = slug
    @meta = Meta.new('date' => date)
    load_file
  end

  def to_html
    load_file if @content.blank?
    raise Blog::ArticleNotFound if @content.blank?
    Markdown.new(@content, :smart).to_html.html_safe
  end
  alias :content to_html
  alias :to_s to_html

  def url
    "http://#{Blog.host}/#{path}"
  end
  alias :permalink url

  def path
    "article/#{meta.date.strftime("%Y/%m/%d")}/#{slug}"
  end

  private
  def load_file
    article_path = File.join(self.class.articles_path, article_filename)
    raise Blog::ArticleNotFound unless File.exist?(article_path)

    meta, content = File.read(article_path).split(/\n\n/, 2)
    self.content = content
    (self.meta ||= Meta.new).update(YAML.load(meta))
    self.meta['date'] = Date.parse(self.meta['date'].gsub('/', '-')) rescue Date.today
  end

  def article_filename
    [ [meta.date.strftime("%Y-%m-%d"), slug].join('-'), Blog.format ].join('.')
  rescue
    raise Blog::ArticleNotFound
  end

  def method_missing(method_id, *args, &block)
    if meta && meta[method_id.to_s]
      meta[method_id.to_s]
    else
      super
    end
  end

  class << self
    def find_by_permalink(year, month, day, slug)
      Article.new(year, month, day, slug)
    end
  end
end
