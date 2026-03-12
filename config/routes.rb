Rails.application.routes.draw do
  namespace :api do
    resources :releases, only: %i[index show]
  end
end