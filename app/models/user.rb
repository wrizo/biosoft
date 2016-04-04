# encoding: utf-8

=begin
 
BIOSOFT                                                         
Copyright (C)  2015  BIOSOFT
----------------------------------------------------------------------------------------------------                                                                   
Nombre archivo:     user.rb
Descripción: 		Modelo de Usuario
----------------------------------------------------------------------------------------------------                                                                                                                                      
Versión        1.0
Creado por:    Walter Rizo.
Creado el:     28/09/2015
----------------------------------------------------------------------------------------------------                                                                                                                                      
 
=end

class User < ActiveRecord::Base

  attr_accessor :signin

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :uniqueness => {:case_sensitive => false}
  # Only allow letter, number, underscore and punctuation.s
  validates_format_of :username, :with => /\A[a-zA-Z áéíóúAÉÍÓÚÑñ]+\z/, :message => "Solo debe contener letras.", :keypress => true

  validate :validate_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    conditions[:email].downcase! if conditions[:email]
    if signin = conditions.delete(:signin)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", {:value => signin.downcase}]).first
    else
      where(conditions.to_hash).first
    end
  end

end
