Plot::Application.routes.draw do
  get 'article/:year/:month/:day/:slug',  :to => "articles#show",   :as => 'article'
  get 'articles',                         :to => "articles#index",  :as => 'articles'
  get 'archives',                         :to => "archives#index",  :as => 'archives'
  root :to => "articles#index"
end
