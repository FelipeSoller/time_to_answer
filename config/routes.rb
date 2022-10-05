Rails.application.routes.draw do
  namespace :admins_backoffice do
    get 'admins/index'
  end
  namespace :site do
    get 'welcome/index'
  end

  namespace :users_backoffice do
    get 'welcome/index'
  end

  namespace :admins_backoffice do
    get 'welcome/index'
  end

  devise_for :admins
  devise_for :users

  root 'site/welcome#index'
end
