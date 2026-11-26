class ApplicationController < ActionController::API
    include ActionController::Cookies
    include Authentication
    include ActionController::RequestForgeryProtection

    protect_from_forgery with: :exception
end
