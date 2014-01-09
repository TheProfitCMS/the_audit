Rails.application.routes.draw do 
  namespace :admin do
    resources :audits, except: [:new, :create]
  end
end
