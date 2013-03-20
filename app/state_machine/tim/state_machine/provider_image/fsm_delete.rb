module Tim
  module StateMachine
    module ProviderImage
      module FSMDelete

        def after_fsm_delete_request(pi, transition)
          begin
            if pi.imported?
              pi.fsm_delete_accept
              # TODO: We could add some checks here to see if the provider image
              # actually exists, and this user (based on credentials) has perms
              pi.fsm_delete_start
              pi.fsm_delete_complete
            else
              pi.send(:delete_factory_provider_image)
              pi.fsm_delete_accept
            end
          rescue => e
            pi.fsm_delete_fail
            pi.fsm_delete_state_message = e.message
          end
        end

      end
    end
  end
end