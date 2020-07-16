# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect('/formulario')

  get '/formulario', to: 'form_answers#new'
  post '/formulario', to: 'form_answers#create'

  devise_for :users
  authenticated :user do
    resources :users
  end

  match '*path' => redirect('/'), via: :get
end
