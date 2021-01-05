# frozen_string_literal: true

json.array! @income_statements, partial: 'income_statements/income_statement', as: :income_statement
