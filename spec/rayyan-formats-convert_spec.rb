require 'spec_helper'

describe 'Command' do
  let(:command) { "rayyan-formats-convert #{args.join(' ')} 2>&1" }
  let(:input1) { 'spec/support/refman-example.ris' }
  let(:input2) { 'spec/support/endnote-example.txt' }
  let(:output) { 'output.csv' }

  context "with invalid input" do
    let(:args) { [] }

    it 'prints error and exits with 1' do
      expect(`#{command}`).to match(/USAGE/)
      expect($?.exitstatus).to eq(1)
    end
  end

  context "with valid input" do
    let(:args) { [input1, input2, output] }

    it 'prints report and exits with 0' do
      expect(`#{command}`).to match(/Exported 10 entries/)
      expect($?.exitstatus).to eq(0)
    end
  end
end
