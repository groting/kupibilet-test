Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/:short_url', action: :show, controller: 'links'
  post '/', action: :create, controller: 'links'
end
