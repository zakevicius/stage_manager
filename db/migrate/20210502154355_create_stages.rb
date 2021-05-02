# frozen_string_literal: true

class CreateStages < ActiveRecord::Migration[6.1]
  def change
    create_table :stages do |t|
      t.integer :stage
      t.integer :status, default: 0
      t.timestamp :claimed_since
      t.string :last_deployment_made_by
      t.string :actions

      t.timestamps
    end
  end
end
