pingdominator
============

*Opinionatedly Setup Pingdom Alerts during Deployment.*

This is a Capistrano 3.x plugin, and relies on SSH access, as well as curl installed on the hosts.

### Installation:
* `gem install pingdominator` (Or add it to your Gemfile and `bundle install`.)
* Add "require 'pingdominator'" to your Capfile
`echo "require 'pingdominator'" >> Capfile`
* Create example configs:
`cap staging pingdom:write_example_configs`
* Turn them into real configs by removing the `_example` portions of their names, and adjusting their content to fit your needs. (Later when you upgrade to a newer version of pingdominator, you can `pingdom:write_example_configs` again and diff your current configs against the new configs to see what you need to add.)
* Add the "pingdom" role to the servers for which you want ping alerts setup.

### Usage:
`cap -T` will help remind you of the available commands, see this for more details.
* After setting up your `deploy.rb` config file during installation, simply run: `cap <stage> pingdom:setup`
* Run `cap <stage> pingdom:setup` again to see it find everything is already setup, and do nothing.
* Run `cap <stage> pingdom:setup:force` to be offered to delete and recreate the alert.
* Run `cap <stage> pingdom:status` to see the status of the alert.

###### Debugging:
* You can add the `--trace` option at the end of a command to see when which tasks are invoked, and when which task is actually executed.
* If you want to put on your DevOps hat, you can run `cap -T -A` to see each individually available task, and run them one at a time to debug each one.
