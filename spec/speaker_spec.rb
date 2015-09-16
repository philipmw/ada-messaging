require 'speaker'
require 'time'

describe Speaker do
  describe '.get_person_name' do
    before(:each) do
      allow(STDIN).to receive(:readline).and_return(stdin_line)
    end

    [
      {line: 'First Last', expected_name: 'First Last'},
      {line: 'Wang', expected_name: 'Wang'},
      {line: 'Wang ', expected_name: 'Wang'},
      {line: ' Wang', expected_name: 'Wang'},
      {line: "\r\rWang", expected_name: 'Wang'},
    ].each do |h|
      context "when line is '#{h[:line]}'" do
        let(:stdin_line) { h[:line] }

        it "returns '#{h[:expected_name]}'" do
          expect(described_class.get_person_name).to eq h[:expected_name]
        end

        it 'greets' do
          expect(STDOUT).to receive(:puts).with("Nice to meet you, #{h[:expected_name]}.")
          described_class.get_person_name
        end
      end
    end
  end

  describe '#speak' do
    let(:sqs_client) { double }
    subject { described_class.new('some-queue-url', sqs_client) }
    let(:typed_msg) { 'Hello, world  ' }

    before(:each) do
      allow(subject.class).to receive(:get_person_name).and_return('Nell')
      allow(STDIN).to receive(:each_line).and_yield(typed_msg)
    end

    it 'queues message with metadata' do
      expect(sqs_client).to receive(:send_message).with({
        queue_url: 'some-queue-url',
        message_body: satisfy('a JSON-encoded message') do |msg_json|
          msg_hash = JSON.parse(msg_json)
          msg_hash['msg'] == typed_msg.strip &&
          msg_hash['sent_by'] == 'Nell' &&
          Time.strptime(msg_hash['ts'], '%FT%T%z').is_a?(Time)
        end
      })
      subject.speak
    end
  end
end