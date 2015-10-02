# TODO prevent down api from breaking deploys
namespace :pingdom do

  namespace :setup do

    desc "Offer to remove any existing alert(s) and (re)create"
    task :force => :check do
      on roles(:pingdom) do |host|
        set :not_deleted, false
        if fetch(:pingdom_alert_exists)
          fetch(:pingdom_checks).each do |check|
            warn "Deleting #{JSON.pretty_generate(check)}"
            set :yes_or_no, ""
            until fetch(:yes_or_no).chomp.downcase == "yes" or fetch(:yes_or_no).chomp.downcase == "no"
              ask :yes_or_no, "Are you sure?"
            end
            if fetch(:yes_or_no).chomp.downcase == "yes"
              results = JSON.parse delete_check(check['id'])
              info results['message']
            else
              warn "Not deleting check named #{check['name']}"
              set :not_deleted, true
            end
          end
        end
        if fetch(:not_deleted)
          info "We'll now create a new check."
          set :yes_or_no, ""
          until fetch(:yes_or_no).chomp.downcase == "yes" or fetch(:yes_or_no).chomp.downcase == "no"
            ask :yes_or_no, "Are you sure?"
          end
          unless fetch(:yes_or_no).chomp.downcase == "yes"
            next
          end
        end
        results = JSON.parse create_check
        info "Successfully created Pingdom Alert # #{results['check']['id']} named #{results['check']['name']}"
      end
    end
  end

  desc "Ensure the alert exists"
  task :setup => :check do
    on roles(:pingdom) do |host|
      unless fetch(:pingdom_alert_exists)
        Rake::Task['pingdom:setup:force'].invoke
      else
        info "Alert for #{host} is already setup, moving on."
      end
    end
  end

  if Rake::Task.task_defined?("deploy:publishing")
    after 'deploy:publishing', 'pingdom:setup'
  end

end
