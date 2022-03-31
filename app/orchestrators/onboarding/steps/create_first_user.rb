class Onboarding::Steps::CreateFirstUser < Workflows::SagaStep
  def perform
    p 'SU1'*100
    sleep(5)
    User.create(
      first_name: @input[:first_name] + "1",
      last_name: @input[:last_name] + "1",
      email: 'SIGNUP1@gmail.com',
    )

    step_result
  end
end