# config valid only for Capistrano 3.2.1
lock '3.2.1'

##### pingdominator
### ------------------------------------------------------------------
set :deployment_username,           "deployer"
set :pingdom_userpass,              "pingdom@example.com:mypassword"
set :pingdom_check_path,            '/login' # this MUST be single quoted not double quoted (because of slashes)
set :pingdom_check_type,            "http" # http, ping, (others)
set :pingdom_check_https,           true # check on https 443 or http 80
set :pingdom_alert_policy_id,       "1234567" # find this in your browser URL in your pingdom account
### ------------------------------------------------------------------
