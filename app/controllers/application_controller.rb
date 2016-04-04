# encoding: utf-8

=begin
 
BIOSOFT                                                         
Copyright (C)  2015  BIOSOFT
----------------------------------------------------------------------------------------------------                                                                   
Nombre archivo:     application_controller.rb
Descripción: 		Aplication controller, este controlador hereda a las otras clases de ruby
					pedira la atentificacion 
----------------------------------------------------------------------------------------------------                                                                                                                                      
Versión        1.0
Creado por:    Walter Rizo.
Creado el:     28/09/2015
----------------------------------------------------------------------------------------------------                                                                                                                                      
 
=end

class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!


  # In Rails 4 to permit passing certain params to a model, you have to whitelist them.
  # How devise plays with them in described in the devise documentation here
  # You can find more about strong parameters at rails documentation here

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:signin, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

end
