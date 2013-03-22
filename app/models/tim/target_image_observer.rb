module Tim
  class TargetImageObserver < ActiveRecord::Observer
    observe ::Tim::TargetImage
    include ::Tim::StateMachine::TargetImage::FSMCreate
    include ::Tim::StateMachine::TargetImage::FSMDelete

    def after_save(ti)
      handle_factory_callback(ti) if !ti.new_record? && ti.status_changed?
    end

    private
    # We ensure that the state is correctly transition through the state
    # machine. This will ensure all the correct events are fired.
    def handle_factory_callback(ti)
      case ti.status.upcase
        when "COMPLETE"
          ti.fsm_create_start    if ti.fsm_create_state == "queued"
          ti.fsm_create_complete unless ti.fsm_create_state == "complete"
        when "BUILDING"
          ti.fsm_create_start    unless ti.fsm_create_state == "in_progress"
        when "FAILED"
          ti.fsm_create_start    if ti.fsm_create_state == "queued"
          ti.fsm_create_fail     unless ti.fsm_create_state == "failed"
        when "DELETING"
          ti.fsm_delete_start    unless ti.fsm_delete_state == "in_progress"
        when "DELETEFAILED"
          ti.fsm_delete_start    if ti.fsm_delete_state == "queued"
          ti.fsm_delete_fail     unless ti.fsm_delete_state == "failed"
        when "DELETED"
          ti.fsm_delete_start    if ti.fsm_delete_state == "queued"
          ti.fsm_delete_complete unless ti.fsm_delete_state == "complete"
      end
    end
  end
end