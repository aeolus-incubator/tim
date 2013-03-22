module Tim
  class ProviderImageObserver < ActiveRecord::Observer
    observe ::Tim::ProviderImage
    include ::Tim::StateMachine::ProviderImage::FSMCreate
    include ::Tim::StateMachine::ProviderImage::FSMDelete

    def after_save(pi)
      handle_factory_callback(pi) if !pi.new_record? && pi.status_changed?
    end

    private
    # We ensure that the state is correctly transitioned through the state
    # machine. This will ensure all the correct events are fired.
    def handle_factory_callback(pi)
      case pi.status.upcase
        when "COMPLETE"
          pi.fsm_create_start    if pi.fsm_create_state == "queued"
          pi.fsm_create_complete unless pi.fsm_create_state == "complete"
        when "BUILDING"
          pi.fsm_create_start    unless pi.fsm_create_state == "in_progress"
        when "FAILED"
          pi.fsm_create_start    if pi.fsm_create_state == "queued"
          pi.fsm_create_fail     unless pi.fsm_create_state == "failed"
        when "DELETING"
          pi.fsm_delete_start    unless pi.fsm_delete_state == "in_progress"
        when "DELETEFAILED"
          pi.fsm_delete_start    if pi.fsm_delete_state == "queued"
          pi.fsm_delete_fail     unless pi.fsm_delete_state == "failed"
        when "DELETED"
          pi.fsm_delete_start    if pi.fsm_delete_state == "queued"
          pi.fsm_delete_complete unless pi.fsm_delete_state == "complete"
      end
    end
  end
end