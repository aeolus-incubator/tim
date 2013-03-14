module Tim
  module StateMachine
    module FSM
      def self.included base
        base.state_machine :fsm_create_state, :initial => :new do
          event :fsm_create_request do
            transition :new => :pending
          end

          event :fsm_create_accept do
            transition :pending => :queued
          end

          event :fsm_create_start do
            transition :queued => :in_progress
          end

          event :fsm_create_fail do
            transition [:pending, :in_progress] => :failed
          end

          event :fsm_create_complete do
            transition :in_progress => :complete
          end
        end

        base.state_machine :fsm_delete_state, :initial => :inactive do
          event :fsm_delete_request do
            transition [:inactive, :failed] => :pending
          end

          event :fsm_delete_accept do
            transition :pending => :queued
          end

          event :fsm_delete_start do
            transition :queued => :in_progress
          end

          event :fsm_delete_complete do
            transition :in_progress => :complete
          end

          event :fsm_delete_fail do
            transition [:in_progress, :pending] => :failed
          end
        end
      end
    end
  end
end