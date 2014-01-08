Rails.application.routes.draw do 
  namespace :admin do
    resources :audits
  end
end
