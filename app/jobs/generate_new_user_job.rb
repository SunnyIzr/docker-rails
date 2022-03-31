class GenerateNewUserJob < BaseJob
  def execute(args)
    p '*'*500
    user = User.last
    last_name = "#{user.last_name} #{1}"
    sleep(5)
    # raise StandardError, "This job has failed!"
    User.create(first_name: user.first_name, last_name: last_name, email: user.email)
  end
end