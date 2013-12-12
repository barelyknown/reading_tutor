ReadingTutor::Application.routes.draw do
  resources :words
  root to: "words#index"
end
