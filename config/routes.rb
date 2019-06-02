# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :v0 do
    resources :users do
      member do
        post 'verify', to: 'users#verify'
      end
    end

    post 'webhooks/sms_incoming', to: 'webhooks#sms_incoming'
  end
end
