# frozen_string_literal: true

class RenameStageToStageId < ActiveRecord::Migration[6.1]
  def change
    rename_column :stages, :stage, :stage_id
  end
end
