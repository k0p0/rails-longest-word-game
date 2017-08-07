Rails.application.routes.draw do
  get 'game', to: 'game#generate'
  get 'score', to: 'game#score'
  root 'game#generate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
