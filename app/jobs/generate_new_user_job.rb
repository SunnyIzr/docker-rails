class GenerateNewUserJob
  include Sidekiq::Job

  def perform
    user = User.last
    last_name = "#{user.last_name} #{1}"
    sleep(5)
    User.create(first_name: user.first_name, last_name: last_name, email: user.email)
  end
end