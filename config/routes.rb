Rails.application.routes.draw do
  root "mobility#index"

  get "movilidad_social", to: "mobility#index", as: "social_mobility"
end
