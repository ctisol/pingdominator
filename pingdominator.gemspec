Gem::Specification.new do |s|
  s.name        = 'pingdominator'
  s.version     = '0.0.0'
  s.date        = '2015-06-26'
  s.summary     = "Capistrano Plugin to Setup Pindom Alerts"
  s.description = "Idempotently Setup Pindom Alerts during Deployment"
  s.authors     = ["david amick"]
  s.email       = "davidamick@ctisolutionsinc.com"
  s.files       = [
    "lib/pingdominator.rb",
    "lib/pingdominator/pingdom.rb",
    "lib/pingdominator/check.rb",
    "lib/pingdominator/config.rb",
    "lib/pingdominator/built-in.rb",
    "lib/pingdominator/examples/Capfile",
    "lib/pingdominator/examples/config/deploy.rb",
    "lib/pingdominator/examples/config/deploy/staging.rb"
  ]
  s.required_ruby_version  =                '>= 1.9.3'
  s.requirements           <<               "curl (on the hosts)"
  s.add_runtime_dependency 'capistrano',    '~> 3.2.1'
  s.add_runtime_dependency 'deployinator',  '~> 0.1.3'
  s.add_runtime_dependency 'rake',          '~> 10.3.2'
  s.add_runtime_dependency 'sshkit',        '~> 1.5.1'
  s.homepage    =
    'https://github.com/snarlysodboxer/pingdominator'
  s.license     = 'GNU'
end
