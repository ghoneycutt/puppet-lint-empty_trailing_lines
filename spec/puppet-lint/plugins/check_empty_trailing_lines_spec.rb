# frozen_string_literal: true

require 'spec_helper'

describe 'empty_trailing_lines' do
  let(:msg) { 'too many empty lines at the end of the file' }

  context 'with fix disabled' do
    context 'when code ending with an extra newline' do
      let(:code) { "foo\n\n\n'test'\n\n" }

      it 'detects a single problem' do
        expect(problems).to have(1).problem
      end

      it 'creates a warning' do
        expect(problems).to contain_warning(msg).on_line(4).in_column(0)
      end
    end

    context 'when code ending with many extra newlines' do
      let(:code) { "foo\n\n\n'test'\n\n\n\n" }

      it 'detects a single problem' do
        expect(problems).to have(1).problem
      end

      it 'creates a warning' do
        expect(problems).to contain_warning(msg).on_line(6).in_column(0)
      end
    end

    context 'when code ending with a newline' do
      let(:code) { "foo\n\n\n'test'\n" }

      it 'does not detect any problems' do
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

    context 'when code ending with an extra newline' do
      let(:code) { "foo\n\n\n'test'\n\n" }

      it 'onlies detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'fixes the problem' do
        expect(problems).to contain_fixed(msg).on_line(4).in_column(0)
      end

      it 'adds a newline to the end of the manifest' do
        expect(manifest).to eq("foo\n\n\n'test'\n")
      end
    end

    context 'when code ending with many extra newlines' do
      let(:code) { "foo\n\n\n'test'\n\n\n\n" }

      it 'onlies detect a single problem' do
        expect(problems).to have(1).problem
      end

      it 'fixes the problem' do
        expect(problems).to contain_fixed(msg).on_line(6).in_column(0)
      end

      it 'adds a newline to the end of the manifest' do
        expect(manifest).to eq("foo\n\n\n'test'\n")
      end
    end

    context 'when code ending in a newline' do
      let(:code) { "foo\n\n\n'test'\n" }

      it 'does not detect any problems' do
        expect(problems).to have(0).problems
      end

      it 'does not modify the manifest' do
        expect(manifest).to eq(code)
      end
    end
  end
end
