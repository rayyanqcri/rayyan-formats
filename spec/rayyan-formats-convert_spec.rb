require 'spec_helper'

describe 'Command' do
  let(:input1) { 'spec/support/refman-example.ris' }
  let(:input2) { 'spec/support/endnote-example.txt' }
  let(:output) { 'output.csv' }
  let(:args) { [] }
  let(:expected_exit) { 1 }

  shared_examples 'command launcher' do
    it 'launches command with specified arguments' do
      out = `rayyan-formats-convert #{args.join(' ')} 2>&1`
      expect(out).to match(expected_out)
      expect($?.exitstatus).to eq(expected_exit)
    end
  end

  context 'when less than 2 arguments given' do
    let(:expected_out) { /USAGE/ }
    it_behaves_like 'command launcher'
  end

  context 'when output argument has no extension' do
    let(:args) { [input1, 'out-no-extension'] }
    let(:expected_out) { /must have an extension/ }
    it_behaves_like 'command launcher'
  end

  context 'when input argument has no extension' do
    let(:args) { ['Gemfile', output] }
    let(:expected_out) { /must end with '.' then extension/ }
    it_behaves_like 'command launcher'
  end

  context 'when input argument has unsupported extension' do
    let(:args) { ['Gemfile.lock', output] }
    let(:expected_out) { /Unsupported file format for import/ }
    it_behaves_like 'command launcher'
  end

  context 'when input argument file not found' do
    let(:args) { ['foo.bar', output] }
    let(:expected_out) { /No such file/ }
    it_behaves_like 'command launcher'
  end

  context 'when all arguments ok' do
    let(:args) { [input1, input2, output] }
    let(:expected_out) { /Imported 7 entries.*Imported 3 entries.*Exported 10 entries/m }
    let(:expected_exit) { 0 }
    it_behaves_like 'command launcher'
  end
end
