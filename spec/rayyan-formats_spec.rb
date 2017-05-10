require 'spec_helper'

describe RayyanFormats::Command do
  let(:input1) { 'spec/support/refman-example.ris' }
  let(:input2) { 'spec/support/endnote-example.txt' }
  let(:output) { 'output.csv' }

  shared_examples 'invalid command handler' do
    it 'validates command with specified arguments' do
      begin
        RayyanFormats::Command.new(args).run
      rescue => e
        expect(e.message).to match(expected_out)
      end
    end
  end

  context 'when less than 2 arguments given' do
    let(:args) { [] }
    let(:expected_out) { /USAGE/ }
    it_behaves_like 'invalid command handler'
  end

  context 'when output argument has no extension' do
    let(:args) { [input1, 'out-no-extension'] }
    let(:expected_out) { /must have an extension/ }
    it_behaves_like 'invalid command handler'
  end

  context 'when input argument has no extension' do
    let(:args) { ['Gemfile', output] }
    let(:expected_out) { /must end with '.' then extension/ }
    it_behaves_like 'invalid command handler'
  end

  context 'when input argument has unsupported extension' do
    let(:args) { ['Gemfile.lock', output] }
    let(:expected_out) { /Unsupported file format for import/ }
    it_behaves_like 'invalid command handler'
  end

  context 'when input argument file not found' do
    let(:args) { ['foo.bar', output] }
    let(:expected_out) { /No such file/ }
    it_behaves_like 'invalid command handler'
  end

  context 'when all arguments ok' do
    let(:args) { [input1, input2, output] }
    let(:captured_messages) { [] }
    
    before {
      allow($stdout).to receive(:puts) {|message|
        captured_messages << message
      }
    }

    after {
      allow($stdout).to receive(:puts).and_call_original
    }

    it "runs with no exceptions and outputs correct messages" do
      expect{RayyanFormats::Command.new(args).run}.not_to raise_error
      expect(captured_messages[0]).to match(/Imported 7 entries/)
      expect(captured_messages[1]).to match(/Imported 3 entries/)
      expect(captured_messages[2]).to match(/Exported 10 entries/)
    end
  end
end