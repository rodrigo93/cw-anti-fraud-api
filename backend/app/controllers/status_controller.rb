# frozen_string_literal: true

class StatusController < ApplicationController
  # Just a simple health check endpoint for now
  def check
    render json: { status: 'ok' }
  end
end
