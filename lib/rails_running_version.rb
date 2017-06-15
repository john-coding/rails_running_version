module GitVersionRails
    require_relative "../app/controllers/rails_running_version//git_version_controller.rb"
    require_relative "rails_running_version//running_version.rb"
  # Your code goes here...
  class Engine < Rails::Engine; end
end
