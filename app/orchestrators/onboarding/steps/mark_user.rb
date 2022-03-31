class Onboarding::Steps::MarkUser < Workflows::SagaStep
  def perform
    p 'MARKING '*100
    sleep(5)
    user.update!(email: "#{user.email}-SIGNED!!")
    
    step_result(special_code: "Will Smith Was Ok!")
  end

  private
  def user
    @user ||= User.find(@input[:user_id])
  end
end