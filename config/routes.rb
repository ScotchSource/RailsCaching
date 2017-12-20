Rails.application.routes.draw do
  resources :employees, only: [:index] do
    collection do
      get 'info'
    end
  end
end
