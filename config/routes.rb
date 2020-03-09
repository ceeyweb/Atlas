# rubocop:disable Layout/LineLength
Rails.application.routes.draw do
  root "mobility#index"

  resources :mobility, path: "movilidad_social", param: :slug, only: %i[index show]
end
# rubocop:enable Layout/LineLength
