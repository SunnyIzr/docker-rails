class OnboardingOrchestrator < Workflows::Orchestrator
  event :signed_up do
    step Onboarding::Steps::CreateFirstUser
    step Onboarding::Steps::CreateSecondUser
  end

  event :tos_signed, for_resource: User do
    step Onboarding::Steps::MarkUser
    step Onboarding::Steps::SkipThisStep
    step Onboarding::Steps::ConfirmUser
  end
  event :tos_canned, for_resource: User do
    step Onboarding::Steps::ThisRaisesError
    step Onboarding::Steps::ThisShouldNotRun
  end
end