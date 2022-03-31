class Workflows::SagaDefinition
  class << self
    attr_accessor :step_blocks

    def steps
      self.step_blocks ||= []
    end

    def step(klass)
      steps.push(klass)
    end
  end
end