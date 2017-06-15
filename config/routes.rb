Rails.application.routes.draw do
      get 'version' => 'rails_running_version/server#version'
end