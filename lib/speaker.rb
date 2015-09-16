require 'aws-sdk-core'
require 'benchmark'
require 'json'

class Speaker
  PROMPT='Say> '

  def self.get_person_name
    begin
      print "What's your name?: "
      name = STDIN.readline.strip
    end while name.length == 0
    puts "Nice to meet you, #{name}."
    name
  end

  def initialize(queue_url, sqs_client = Aws::SQS::Client.new)
    @queue_url = queue_url
    @sqs_client = sqs_client
  end

  def speak
    my_name = self.class.get_person_name
    puts "Send EOF (Ctrl-D on Mac, Ctrl-Z on Windows) to finish."

    print PROMPT
    STDIN.each_line do |line|
      msg = JSON.dump({
        ts: Time.now.strftime('%FT%T%z'),
        sent_by: my_name,
        msg: line.strip,
      })
      bm = Benchmark.measure do
        @sqs_client.send_message({
           queue_url: @queue_url,
           message_body: msg,
        })
      end
      puts "-- pushed your message to SQS in #{'%.2f' % bm.real} s."
      print PROMPT
    end
  end
end