# RailsRunningVersion
Add route '/version' to show the current running git commits

## A sample output
Here is a sample output when you access your Ruby on Rails server at '/version'.
```
The following commits at origin/master are yet to be included.

   880ec44 2017-06-12 17:04:23 -0700 john    Set allowed_gap before sending a down alert to an hour

We are running with,

   a7cd01e 2017-05-29 21:18:22 +0000 john    database setting for production
   b6062be 2017-06-12 10:03:42 -0700 john    Add "/traffics/upload_status", which is used by UptimeRobot

 dirty files:
     M app/controllers/server_controller.rb
     M config/initializers/running_version.rb
     M config/routes.rb
```

## Installation
Add this line to your Ruby on Rails' Gemfile:

```gem 'rails_running_version', :git => "git://github.com/john-coding/rails_running_version.git"```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
