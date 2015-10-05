#  Ruby has the ability to modify the environment. 
#  This makes it possible to load the environment variables 
#  from a YAML file at startup. In order to do this we need to 
#  create an initializer. Create an initializer called 
#  environment_variables.rb and add in the code listed below. 

module EnvironmentVariables
  class Application < Rails::Application
    config.before_configuration do
      env_file = Rails.root.join("config", 'environment_variables.yml').to_s

      if File.exists?(env_file)
        YAML.load_file(env_file)[Rails.env].each do |key, value|
          ENV[key.to_s] = value
        end # end YAML.load_file
      end # end if File.exists?
    end # end config.before_configuration
  end # end class
end # end module

# The code listed above will look to see if an environment_variables.yml 
# file exists. If it exists the file will be loaded and the environment 
# variables will be set. 