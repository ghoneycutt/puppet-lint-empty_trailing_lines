require 'spec_helper'

describe 'empty_trailing_lines' do
  let(:msg) { 'too many empty lines at the end of the file' }

  context 'with fix disabled' do
    context 'code ending with an extra newline' do
      let(:code) { "foo\n\n\n'test'\n\n" }

      it 'should detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should create a warning' do
        expect(problems).to contain_warning(msg).on_line(4).in_column(0)
      end
    end

    context 'code ending with a newline' do
      let(:code) { "foo\n\n\n'test'\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end
    end
  end

  context 'with fix enabled' do
    before do
      PuppetLint.configuration.fix = true
    end

    after do
      PuppetLint.configuration.fix = false
    end

    context 'code ending with an extra newline' do
      let(:code) { "foo\n\n\n'test'\n\n" }

      it 'should only detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'should fix the problem' do
        expect(problems).to contain_fixed(msg).on_line(4).in_column(0)
      end

      it 'should add a newline to the end of the manifest' do
        expect(manifest).to eq("foo\n\n\n'test'\n")
      end
    end

    context 'code ending in a newline' do
      let(:code) { "foo\n\n\n'test'\n" }

      it 'should not detect any problems' do
        expect(problems).to have(0).problems
      end

      it 'should not modify the manifest' do
        expect(manifest).to eq(code)
      end
    end
  end
end
