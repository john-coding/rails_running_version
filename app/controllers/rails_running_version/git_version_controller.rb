module RailsRunningVersion

class ServerController < ActionController::Base
  def version
    version_info = GitVersionHelper.current_running_info

    up_to_date_string = if version_info[:up_to_date]
      "The latest commit at #{version_info[:up_stream]} is included."
    else
      "The following commits at #{version_info[:up_stream]} are yet to be included.\n\n" + version_info[:commits_to_deploy].gsub(/^/, '    ')
    end
    running_commits_string = "We are running with, \n\n#{version_info[:running_commits].gsub(/^/, '    ')}"

    dirty_status_string = ("dirty files:\n#{version_info[:dirty_files].gsub(/^/, '    ')}" unless version_info[:running_version][:clean])

    render :plain => "#{up_to_date_string}\n\n#{running_commits_string}\n\n#{dirty_status_string}"
  end
end

end

