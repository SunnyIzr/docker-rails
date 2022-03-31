class StepExecution < ApplicationRecord
  serialize :input, JSON
  serialize :result, JSON
end
