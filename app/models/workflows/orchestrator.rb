class Workflows::Orchestrator < BaseJob
  class << self
    attr_accessor :entry_points, :resource_classes

    def event_entry_points
      self.entry_points ||= HashWithIndifferentAccess.new
    end

    def event_resource_classes
      self.resource_classes ||= HashWithIndifferentAccess.new
    end
    
    def event(key, for_resource: nil, &block)
      saga = Class.new(Workflows::SagaDefinition)
      saga_class = key.to_s.classify
      saga.class_eval(&block)
      event_entry_points[key] = saga
      event_resource_classes[key] = for_resource
    end

    def dispatch!(key, args)
      args.merge!(saga_name: key)
      perform_async(args)
    end
  end

  def execute(args)
    args = HashWithIndifferentAccess.new(args)
    saga_name = args[:saga_name]
    saga = self.class.entry_points[saga_name]
    resource_name = self.class.resource_classes[saga_name]
    resource_id = args["#{resource_name.to_s.downcase}_id"]

    pending_steps = saga.steps.clone
    input = args.clone
    error_raised = false

    # We keep running steps until either we no longer have steps OR 
    # if one of the steps has raised an error
    until pending_steps.empty? or error_raised
      # We need to create a step instance here (But be efficient and avoid repeats)
      current_step = pending_steps.shift
      step_instance = StepExecution.create(
        resource_type: resource_name,
        resource_id: resource_id,
        orchestrator_class: self.class.to_s,
        saga_name: saga_name,
        step_name: current_step.to_s,
        input: input
      )
      begin
        step_result = current_step.new(input: input).perform
      rescue => e
        error_raised = true
        step_result = {
          error: e.to_s,
          stacktrace: e.backtrace
        }
        step_instance.update!(
          status: "error",
          result: step_result
        )
      else
        result_data = step_result.except(:status, :skip_reason)
        step_instance.update!(
          status: step_result[:status],
          result: step_result
        )
        input = input.merge!(result_data)
      end
    end
  end

end