class BaseJob
  include Sidekiq::Job

  sidekiq_options retry: 10

  def perform(args = {})
    p "RUNNING PERFORM"
    p '*'*500
    result = begin
      execute(args)
    rescue StandardError => e
      {
        errors: [
          {
            message: e.message,
            backtrace: e.backtrace
          }
        ]
      }
    end

    process_result(args, result)
  end

  def execute(_args)
    raise NoMethodError, "#{self.class}##{__method__}"
  end

  def retry_count
    @retry_count || 0
  end

  private

  def process_result(_args, _result)
    # raise NoMethodError, "#{self.class}##{__method__}"
    p '!'*500
    p _result
    p '!'*500
  end
end