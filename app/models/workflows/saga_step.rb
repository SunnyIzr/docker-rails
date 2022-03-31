class Workflows::SagaStep
  def initialize(input:)
    @input = input
  end

  def step_result(skip_reason: nil, **data)
    if skip_reason
      status = "skipped"
    else
      status = "success"
    end
    {
      status: status,
      skip_reason: skip_reason,
      **data
    }
  end
end