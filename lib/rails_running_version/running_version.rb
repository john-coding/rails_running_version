# This file is used to get the current running version of the deployed code.
# It is inside the initializer directory so that the rails environment has been loaded.
# That is, cache_classes and eager_load have been initialized.

class GitVersionHelper
  # 0a16bcf 2017-06-11 19:30:31 -0700 john    Simplest protection by http basic authentication
  LOG_FORMAT = "--date=iso --format='format:%h %ad %<(16)%aN %s'"

  def self.versions_on_disk
    up_stream = `git rev-parse --abbrev-ref --symbolic-full-name @{u}`.chop

    changed_files=`git diff --name-only HEAD`
    untracked_unignored_files = `git ls-files --exclude-standard --others`
    folder_clean = changed_files.empty? && untracked_unignored_files.empty?

    dirty_files = if folder_clean
                   nil
                 else
                   `git status --porcelain`
                 end

    running_version = `git rev-parse HEAD`.chop

    {
        up_stream: up_stream,
        running_version: {
            hash: running_version,
            clean: folder_clean
        },
        dirty_files: dirty_files
    }
  end

  # Record the running version when the server starts as the initial version
  # This is motivated by its usage in the production environment.
  EAGER_LOADED_VERSION = self.versions_on_disk

  def self.current_running_info
    `git fetch`

    # local_version = system('git rev-parse @').chop
    up_stream = `git rev-parse --abbrev-ref --symbolic-full-name @{u}`.chop
    raise 'Deployment directory has switched to track a new remote branch' if Rails.application.config.eager_load && up_stream != EAGER_LOADED_VERSION[:up_stream]
    remote_version = `git rev-parse #{up_stream}`.chop

    #up_stream_merged = system("git merge-base --is-ancestor #{up_stream} HEAD")

    running_commit = Rails.application.config.eager_load ? EAGER_LOADED_VERSION[:running_version][:hash] : 'HEAD'
    merge_base = `git merge-base #{up_stream} #{running_commit}`.chop
    running_commits = `git log #{LOG_FORMAT} #{merge_base}~10..#{running_commit}` # Include nine commits before merge base.

    # https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git
    up_to_date = merge_base == remote_version
    commits_to_deploy = (`git log #{LOG_FORMAT} #{merge_base}..#{up_stream}` unless up_to_date)

    if Rails.application.config.eager_load
      EAGER_LOADED_VERSION
    else
      versions_on_disk
    end
        .merge ({up_to_date: up_to_date,
                 merge_base: merge_base,
                 commits_to_deploy: commits_to_deploy,
                 running_commits: running_commits})
  end
end



