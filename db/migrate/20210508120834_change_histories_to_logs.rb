# frozen_string_literal: true

class ChangeHistoriesToLogs < ActiveRecord::Migration[6.1]
  def change
    rename_table :histories, :logs
  end
end
