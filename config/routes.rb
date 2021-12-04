# frozen_string_literal: true

Rails.application.routes.draw do
  root 'palindromes#new'
  resources :palindromes, only: %i[index show destroy new create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
