Rails.application.routes.draw do
  root 'converter#index'

  get 'convert', to: 'converter#convert'
end
