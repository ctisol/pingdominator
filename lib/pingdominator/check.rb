namespace :pingdom do
  namespace :check do

    desc 'Ensure all pingdominator specific settings are set, and warn and exit if not.'
    task :settings => 'deployinator:load_settings' do
      {
        (File.dirname(__FILE__) + "/examples/config/deploy.rb") => 'config/deploy.rb',
        (File.dirname(__FILE__) + "/examples/config/deploy/staging.rb") => "config/deploy/#{fetch(:stage)}.rb"
      }.each do |abs, rel|
        Rake::Task['deployinator:settings'].invoke(abs, rel)
        Rake::Task['deployinator:settings'].reenable
      end
    end

    namespace :settings do
      desc 'Print example pingdominator specific settings for comparison.'
      task :print => 'deployinator:load_settings' do
        set :print_all, true
        Rake::Task['pingdom:check:settings'].invoke
      end
    end

  end

  desc "Check the alert status"
  task :status => ['deployinator:load_settings', :check] do
    on roles(:pingdom) do |host|
      fetch(:pingdom_checks).each do |check|
        results = JSON.parse list_check(check['id'])
        info JSON.pretty_generate(results)
      end
    end
  end

  #desc "Check if the alert exists"
  task :check => ['deployinator:load_settings', 'pingdom:check:settings'] do
    require 'json'
    run_locally { warn "No #{fetch(:stage)} servers have been given the 'pingdom' role!" unless roles(:pingdom).length > 0 }
    on roles(:pingdom) do |host|
      results = JSON.parse list_checks
      set :pingdom_checks, results['checks'].select { |chk| chk['hostname'] == host.to_s }
      case
      when fetch(:pingdom_checks).length > 1
        warn "There are #{fetch(:pingdom_checks).length} Pingdom alert for this domain! (You may want to manually correct this.) They are:"
        fetch(:pingdom_checks).each { |a| warn "Name: #{a['name']}, Host: #{a['hostname']}, Type: #{a['type']}, ID: #{a['id']}" }
        warn ""
        warn "You can use pingdom:setup:force to be offered to delete and re-create each alert."
        info "Alert for #{host} is already setup."
        set :pingdom_alert_exists, true
      when fetch(:pingdom_checks).length == 1
        set :pingdom_alert_exists, true
        info "One pingdom alert found."
      when fetch(:pingdom_checks).length == 0
        set :pingdom_alert_exists, false
        info "No pingdom alert found."
      end
    end
  end

end
