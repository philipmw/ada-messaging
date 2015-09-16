require 'aws-sdk-core'

QUEUE_URL='https://sqs.us-west-2.amazonaws.com/101804781795/ada-messaging'

if ARGV.count < 1 || !(%w(speaker listener).include? (mode = ARGV[0]))
  STDERR.puts "Run this program either in 'listener' or 'speaker' mode."
  exit(1)
end

puts "You're in #{mode} mode."

case mode
  when 'speaker'
    require_relative 'lib/speaker'
    Speaker.new(QUEUE_URL).speak
  when 'listener'
    require_relative 'lib/listener'
    Listener.run(QUEUE_URL)
  else
    raise 'Unrecognized mode.'
end
