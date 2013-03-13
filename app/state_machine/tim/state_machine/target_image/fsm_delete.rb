module Tim
  module StateMachine
    module TargetImage
      module FSMDelete

        def after_fsm_delete_request(ti, transition)
          begin
            ti.provider_images.each do |pi|
              if ["failed", "inactive"].include? pi.fsm_delete_state
                pi.fsm_delete_request
              end
            end

            if ti.imported?
              ti.fsm_delete_accept
              ti.fsm_delete_start
              ti.fsm_delete_complete
            else
              ti.send(:delete_factory_target_image)
              ti.fsm_delete_accept
            end
          rescue => e
            ti.fsm_delete_state_message = e.message
            ti.fsm_delete_fail
          end
        end

      end
    end
  end
end