class CsrfTokensController < ApplicationController
  allow_unauthenticated_access

  def show
    render json: {
      csrf_token: form_authenticity_token
    }
  end
end