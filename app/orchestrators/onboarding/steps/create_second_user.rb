class Onboarding::Steps::CreateSecondUser < Workflows::SagaStep
  def perform
    p 'SU2'*100
    sleep(5)
    User.create(
      first_name: @input[:first_name] + "2",
      last_name: @input[:last_name] + "2",
      email: 'SIGNUP2@gmail.com',
    )

    step_result
  end
end