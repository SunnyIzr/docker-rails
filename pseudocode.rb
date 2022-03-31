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

OnboardingOrchestrator.dispatch!(:signed_up, {first_name: "Johnny", last_name: "Depp"})
User.find(6).update!(first_name: "Johnny", last_name: "Walker", email: "johnny@gmail.com")
OnboardingOrchestrator.dispatch!(:tos_signed, {user_id: 6})
OnboardingOrchestrator.dispatch!(:tos_canned, {user_id: 6})

# 1. A base job that has retry logic, this will call the #execute method during #perform
# 2. An orchestrator that inherits from base job, this will create a list of event entry points, each event entry point represents a saga
# 3. Each Saga consists a bunch of sequential steps
# 4. The dispatch method will take in the exact saga that we want to run



# Running each saga step
# 1. Peform the step and supply the input
# 2. Upon completion of performance we return step complete which will have a status and all other data
# 3. We take the resulting data but exclude status and skip_reason and merge that with input
# 4. Run the next step


# Step Execution
  # resource_type
  # resource_id
  # orchestrator_class
  # saga_name
  # step_name
  # status
  # input
  # result
  # deleted_at?
  # timestamps