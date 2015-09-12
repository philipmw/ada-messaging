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

  def self.run(queue_url)
    person_name = get_person_name

    puts "Send EOF (Ctrl-D on Mac, Ctrl-Z on Windows) to finish."
    sqs = Aws::SQS::Client.new
    print PROMPT
    STDIN.each_line do |line|
      msg = JSON.dump({
                        ts: Time.now.strftime('%FT%T%z'),
                        sent_by: person_name,
                        msg: line.strip,
                      })
      bm = Benchmark.measure do
        sqs.send_message({
                           queue_url: queue_url,
                           message_body: msg,
                         })
      end
      puts "-- pushed your message to SQS in #{'%.2f' % bm.real} s."
      print PROMPT
    end
  end
end