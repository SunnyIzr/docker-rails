class Onboarding::Steps::ThisRaisesError < Workflows::SagaStep
  def perform
    p 'ERROR '*100
    sleep(5)
    raise "This is bad!"
    step_result(the_res: "This should not be passed!")
  end

  private
  def user
    @user ||= User.find(@input[:user_id])
  end
end