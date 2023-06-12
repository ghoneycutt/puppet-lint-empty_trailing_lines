# frozen_string_literal: true

PuppetLint.new_check(:empty_trailing_lines) do
  def check
    last_token = tokens.last

    return unless %i[NEWLINE WHITESPACE INDENT].include?(last_token.prev_token.type)

    notify :warning, {
      message: 'too many empty lines at the end of the file',
      line: last_token.prev_token.line,
      column: manifest_lines.last.length
    }
  end

  def fix(problem)
    remove_token(tokens.last.prev_token)
    fix(problem) if tokens.last.prev_token.type == :NEWLINE && tokens.last.type == :NEWLINE
  end
end
