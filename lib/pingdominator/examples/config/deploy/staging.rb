##### pingdominator
### ------------------------------------------------------------------
set :domain,                        "my-app.example.com"
server fetch(:domain),
  :user                             => fetch(:deployment_username),
  :roles                            => ["pingdom"]
### ------------------------------------------------------------------
