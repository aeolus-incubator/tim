module Tim
  class ProviderImageObserver < ActiveRecord::Observer
    observe ::Tim::ProviderImage
    include ::Tim::StateMachine::ProviderImage::FSMCreate
  end
end