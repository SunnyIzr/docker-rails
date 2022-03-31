class AddDefaultToStepExecution < ActiveRecord::Migration[7.0]
  def up
    change_column :step_executions, :status, :string, default: "started"
  end

  def down
    change_column :step_executions, :status, :string, default: nil
  end
end
