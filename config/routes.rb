ReadingTutor::Application.routes.draw do
  resources :words
  root to: "words#new"
end
