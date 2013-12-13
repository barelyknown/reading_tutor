ReadingTutor::Application.routes.draw do
  root to: "words#index"

  get "common_word", to: "words#common", as: :common_word
  get "random_word", to: "words#random", as: :random_word
  get "uncommon_word", to: "words#uncommon", as: :uncommon_word

  resources :words do
    resources :syllables
    resources :definitions
  end
  
end
