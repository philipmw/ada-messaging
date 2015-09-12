require 'aws-sdk-resources'
require 'json'

class Listener
  ADVERBS=%w(happily neutrally angrily deviously sarcastically)
  VERBS=%w(spoke said emitted articulated related uttered voiced expressed communicated opined)

  def self.run(queue_url)
    poller = Aws::SQS::QueuePoller.new(queue_url)
    poller.poll do |msg|
      msg_hash = JSON.parse(msg.body)
      sent_ts = Time.strptime(msg_hash['ts'], '%FT%T%:z')
      delay = Time.now - sent_ts
      sent_by = msg_hash['sent_by']
      msg = msg_hash['msg']
      puts "At #{sent_ts} (#{delay}s ago), #{sent_by} #{ADVERBS.sample} #{VERBS.sample}, '#{msg}'"
    end
  end
end