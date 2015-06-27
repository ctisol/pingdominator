set :pingdom_api_root,              "https://api.pingdom.com/api/2.0"
set :pingdom_appkey,                "xm0egh7qc2mavn2k2v2c68i39pnv4idg"
set :pingdom_check_interval,        "1" # minutes

def list_checks
  capture(
    "curl", "--request", "GET", "--silent",
    "--header", "\"App-Key: #{fetch(:pingdom_appkey)}\"",
    "--user", "\"#{fetch(:pingdom_userpass)}\"",
    "\"#{fetch(:pingdom_api_root)}/checks\""
  )
end

def list_check(id)
  capture(
    "curl", "--request", "GET", "--silent",
    "--header", "\"App-Key: #{fetch(:pingdom_appkey)}\"",
    "--user", "\"#{fetch(:pingdom_userpass)}\"",
    "\"#{fetch(:pingdom_api_root)}/checks/#{id.to_s}\""
  )
end

def delete_check(id)
  capture(
    "curl", "--request", "DELETE", "--silent",
    "--header", "\"App-Key: #{fetch(:pingdom_appkey)}\"",
    "--user", "\"#{fetch(:pingdom_userpass)}\"",
    "\"#{fetch(:pingdom_api_root)}/checks/#{id.to_s}\""
  )
end

def create_check
  capture(
    "curl", "--request", "POST", "--silent",
    "--header", "\"App-Key: #{fetch(:pingdom_appkey)}\"",
    "--user", "\"#{fetch(:pingdom_userpass)}\"",
    "\"#{fetch(:pingdom_api_root)}/checks" +
    "?name=#{host}" +
    "&url=#{fetch(:pingdom_check_path)}" +
    "&alert_policy=#{fetch(:pingdom_alert_policy_id)}" +
    "&type=#{fetch(:pingdom_check_type)}" +
    "&host=#{host}" +
    "&encryption=#{fetch(:pingdom_check_https).to_s}" +
    "&resolution=#{fetch(:pingdom_check_interval)}\""
  )
end
