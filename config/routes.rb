# frozen_string_literal: true

Rails.application.routes.draw do
  get 'status/check'

  post 'transactions/check'
end
