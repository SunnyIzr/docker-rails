class CreateStepExecutions < ActiveRecord::Migration[7.0]
  def change
    create_table :step_executions do |t|
      t.string :resource_type
      t.string :resource_id
      t.string :orchestrator_class
      t.string :saga_name
      t.string :step_name
      t.string :status
      t.text :input
      t.text :result
      t.timestamps
    end
  end
end
