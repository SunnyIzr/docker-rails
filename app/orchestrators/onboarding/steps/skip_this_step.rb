class Onboarding::Steps::SkipThisStep < Workflows::SagaStep
  def perform
    p 'SKIPPING '*100
    sleep(5)
    
    return step_result(skip_reason: "This needs to be skipp!")

    user.update!(last_name: "THIS SHOULD NOT BE CHANGED!")
  end

  private
  def user
    @user ||= User.find(@input[:user_id])
  end
end