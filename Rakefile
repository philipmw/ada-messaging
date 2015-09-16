require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

QUEUE_URL='https://sqs.us-west-2.amazonaws.com/101804781795/ada-messaging'

task :listener do
  require_relative 'lib/listener'
  Listener.run(QUEUE_URL)
end

task :speaker do
  require_relative 'lib/speaker'
  Speaker.new(QUEUE_URL).speak
end