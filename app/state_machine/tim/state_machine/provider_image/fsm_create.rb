module Tim
  module StateMachine
    module ProviderImage
      module FSMCreate

        def after_create(pi)
          pi.fsm_create_request
        end

        def after_save(pi)
          handle_factory_callback(pi) if !pi.new_record? && pi.status_changed?
        end

        def after_fsm_create_request(pi, transition)
          if pi.imported?
            if pi.send(:create_import)
              pi.fsm_create_accept
              pi.fsm_create_start
              pi.fsm_create_complete
            else
              pi.fsm_create_fail
            end
          else
            begin
              pi.send(:create_factory_provider_image)
              pi.fsm_create_accept
            rescue => e
              pi.fsm_create_state_message = e.message
              pi.fsm_create_fail
            end
          end
        end

        private
        # We ensure that the state is correctly transition through the state
        # machine. This will ensure all the correct events are fired.
        def handle_factory_callback(pi)
          case pi.status.upcase
            when "COMPLETE"
              pi.fsm_create_start if pi.fsm_create_state == "queued"
              pi.fsm_create_complete
            # Factory has not yet implemented callbacks on this state.  This is
            # pre-emptive
            when "IN_PROGRESS"
              pi.fsm_create_start
            when "FAILED"
              pi.fsm_create_start if pi.fsm_create_state == "queued"
              pi.fsm_create_fail
          end
        end

      end
    end
  end
end