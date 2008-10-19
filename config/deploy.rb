
set :application, "coaliz.typhon.net"

if ENV["deploy_to"] == "production"
  set :domain, application
  set :rails_env, "production"
  set :deploy_to, "/home/web/coaliz.com/"
  set :branch, ENV["tag"]
else
  set :domain, "coaliz.typhon.net"
  set :rails_env, "staging"
  set :deploy_to, "/home/web/dev.coaliz.com/"
  set :branch, "coaliz"
end

ssh_options[:paranoid] = false 
default_run_options[:pty] = true

set :repository, "git@github.com:rdurritcague/insoshi.git"
set :deploy_via, :remote_cache
set :scm, "git"
set :scm_passphrase, "AeR5ahGhie0bi"

set :user, "melipone"
set :runner, "melipone"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc <<-DESC
  Deploys your project. This calls both `update' and `restart'. Note that \
  this will generally only work for applications that have already been deployed \
  once. For a "cold" deploy, you'll want to take a look at the `deploy:cold' \
  task, which handles the cold start specifically.
  DESC
  task :restart do
    #sudo "kill -HUP `cat /var/run/nginx.pid`"
    #run "mongrel_cluster_ctl restart"
    if ENV["deploy_to"] == "production"
      sudo "monit restart all -g coaliz"
    else
      sudo "monit restart all -g dev-coaliz"
    end
  end

  task :stop do
    #sudo "kill -15 `cat /var/run/nginx.pid`"
    #run "mongrel_cluster_ctl stop"
    if ENV["deploy_to"] == "production"
      sudo "monit stop all -g coaliz"
    else
      sudo "monit stop all -g dev-coaliz"
    end
  end

  task :start do
    #sudo "/usr/local/nginx/sbin/nginx"
    #run "mongrel_cluster_ctl start"
    if ENV["deploy_to"] == "production"
      sudo "monit start all -g coaliz"
    else
      sudo "monit start all -g dev-coaliz"
    end
  end
end

# A callback
after "deploy:setup", "coaliz:shared_folder"
after "deploy:symlink", "coaliz:symlink_shared"

namespace :coaliz do 
  desc "Symlinks shared folders into current/public"
  task :symlink_shared do
    run <<-CMD
    rm -rf #{current_path}/public/items #{current_path}/public/photos #{current_path}/public/cvs &&
    ln -nfs #{shared_path}/rsa_key #{current_path}/rsa_key &&
    ln -nfs #{shared_path}/rsa_key.pub #{current_path}/rsa_key.pub &&
    ln -nfs #{shared_path}/files/items #{current_path}/public/items &&
    ln -nfs #{shared_path}/files/cvs #{current_path}/public/cvs &&
    ln -nfs #{shared_path}/files/photos #{current_path}/public/photos
    CMD
  end
  
  desc "Create the shared folder"
  task :shared_folder do
    run <<-CMD
    mkdir #{shared_path}/files &&
    mkdir #{shared_path}/files/items &&
    mkdir #{shared_path}/files/cvs &&
    mkdir #{shared_path}/files/photos
    CMD
  end
end

# namespace :daemon do
#   desc "Launch daemon"
#   task :start do
#     run <<-CMD
#     #{current_path}/lib/daemons/send_daily_note_mail_notification_ctl start
#     CMD
#   end
#   desc "Restart daemon"
#   task :restart do
#     run <<-CMD
#     #{current_path}/lib/daemons/send_daily_note_mail_notification_ctl restart
#     CMD
#   end
#   desc "Stop daemon"
#   task :stop do
#     run <<-CMD
#     #{current_path}/lib/daemons/send_daily_note_mail_notification_ctl stop
#     CMD
#   end
# end
