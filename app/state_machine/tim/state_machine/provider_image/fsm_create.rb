module Tim
  module StateMachine
    module ProviderImage
      module FSMCreate

        def after_create(pi)
          pi.fsm_create_request
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

      end
    end
  end
end