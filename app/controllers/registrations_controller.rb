# encoding: utf-8

=begin
 
BIOSOFT                                                         
Copyright (C)  2015  BIOSOFT
----------------------------------------------------------------------------------------------------                                                                   
Nombre archivo:     registrations_controller.rb
Descripción: 		Controlador para actualizar los registros de usuarios.
----------------------------------------------------------------------------------------------------                                                                                                                                      
Versión        1.0
Creado por:    Walter Rizo.
Creado el:     28/09/2015
----------------------------------------------------------------------------------------------------                                                                                                                                      
 
=end

class RegistrationsController <  Devise::RegistrationsController
	

	#Editando Los Registros sin actualizar la contrasenha
  	def update

  		# this action is triggered when the user sends data to edit their data
		# you can add your custom code here

		new_params = params.require(:user).permit(:email, :username, :current_password, :password, :password_confirmation)
		
		change_password = true

		if params[:user][:password].blank?
			params[:user].delete("password")
			params[:user].delete("password_confirmation")
			new_params = params.require(:user).permit(:email, :username)
			change_password = false
		end

		@user = User.find(current_user.id)

		is_valid = false
		
		if change_password
			is_valid = @user.update_with_password(new_params)
		else
			@user.update_without_password(new_params)
		end
		
		if is_valid
			set_flash_message :notice, :updated
			sign_in @user, :bypass => true
			redirect_to after_update_path_for(@user)
		else
			render "edit"
		end

	end

	def destroy
		
		# this method is triggered when the user tries to delete a user account

		@user = User.find(current_user.id)
		@user.is_active = 0
		
		if @user.save
			sign_out @user
			redirect_to root_path
		else
			render "edit"
		end

	end

end
