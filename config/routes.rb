# rubocop:disable Layout/LineLength
Rails.application.routes.draw do
  root "static_pages#introduction"

  resources :mobility, path: "movilidad_social", param: :slug, only: %i[index show]
  resources :upward_mobility_indicator, path: "movilidad_social_ascendente", param: :slug, only: %i[index show]
end
# rubocop:enable Layout/LineLength
