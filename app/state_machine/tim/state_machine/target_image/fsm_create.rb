module Tim
  module StateMachine
    module TargetImage
      module FSMCreate

        def after_commit(ti)
          # check :on => :create
          if ti.created_at == ti.updated_at
            ti.fsm_create_request
          end
        end

        def after_fsm_create_request(ti, transition)
          if ti.imported?
            ti.fsm_create_accept
            ti.fsm_create_start
            ti.fsm_create_complete
          else
            begin
              ti.send(:create_factory_target_image)
              ti.fsm_create_accept
            rescue => e
              ti.fsm_create_state_message = e.message
              ti.fsm_create_fail
            end
          end
        end

      end
    end
  end
end