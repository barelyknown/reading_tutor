ReadingTutor::Application.routes.draw do
  root to: "words#index"

  resources :words do
    resources :syllables
  end
  
end
