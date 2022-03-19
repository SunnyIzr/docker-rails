class OnboardingOrchestrator < Orchestrator
  event :app_installed do
    step_1
    step_2
    step_3
  end

  event :contracts_signed do
    step_4
    step_5
  end
end

class StepExecution
  def run_step
    # Save step to db
    # Run all the logic in step
    # Update step
  end
end

class Orchestrator
  def dispatch(event_name)
    # This method will dispatch an event and trigger a job to run all of the logic
    
  end

  def perform(event_name)
    # Do all the logic defined in this class, but only limit to the event logic
  end
end


