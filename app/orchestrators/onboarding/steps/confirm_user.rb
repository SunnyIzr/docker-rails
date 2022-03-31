class Onboarding::Steps::ConfirmUser < Workflows::SagaStep
  def perform
    p 'CONFIRMING '*100
    sleep(5)
    user.update!(first_name: "#{user.first_name}-#{@input[:special_code]}!!")
    
    step_result
  end

  private
  def user
    @user ||= User.find(@input[:user_id])
  end
end