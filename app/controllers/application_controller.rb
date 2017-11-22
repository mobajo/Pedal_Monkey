class ApplicationController < ActionController::Base
  #protect_from_forgery prepend: true
  protect_from_forgery with: :exception
  before_action :authenticate_user!
end
