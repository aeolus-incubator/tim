module Tim
  class ProviderImageObserver < ActiveRecord::Observer
    observe ::Tim::ProviderImage

    def after_create(pi)
      pi.fsm_create_requested
    end

    def after_save(pi)
      handle_factory_callback(pi) if !pi.new_record? && pi.status_changed?
    end

    def after_fsm_create_requested(pi, transition)
      if pi.imported?
        if pi.send(:create_import)
          pi.fsm_create_accepted
          pi.fsm_create_start
          pi.fsm_create_complete
        else
          pi.fsm_create_failed
        end
      else
        begin
          pi.send(:create_factory_provider_image)
          pi.fsm_create_accepted
        rescue => e
          pi.fsm_create_state_message = e.message
          pi.fsm_create_failed
        end
      end
    end

    private
    # We ensure that the state is correctly transition through the state 
    # machine. This will ensure all the correct events are fired.
    def handle_factory_callback(pi)
      case pi.status
        when "COMPLETE"
          pi.fsm_create_start if pi.fsm_create_state == "queued"
          pi.fsm_create_completed
        # Factory has not yet implemented callbacks on this state.  This is 
        # pre-emptive
        when "IN_PROGRESS"
          pi.fsm_create_start
        when "FAILED"
          pi.fsm_create_start if pi.fsm_create_state == "queued"
          pi.fsm_create_failed
      end
    end

  end
end