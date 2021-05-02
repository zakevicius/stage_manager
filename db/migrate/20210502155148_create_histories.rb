# frozen_string_literal: true

class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|
      t.string :action_made_by
      t.string :action
      t.references :stage, foreign_key: true

      t.timestamps
    end
  end
end
