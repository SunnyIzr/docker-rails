class Onboarding::Steps::ThisShouldNotRun < Workflows::SagaStep
  def perform
    p 'SHOULD NOT RUN'*100
    sleep(5)
    User.create(
      first_name: "Should Not",
      last_name: "EXIST",
      email: 'no_exist@gmail.com',
    )

    step_result
  end
end