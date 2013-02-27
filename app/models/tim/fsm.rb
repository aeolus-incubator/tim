module Tim
  module FSM
    def self.included base
      base.state_machine :fsm_create_state, :initial => :new do
        event :fsm_create_requested do
          transition :new => :pending
        end

        event :fsm_create_accepted do
          transition :pending => :queued
        end

        event :fsm_create_start do
          transition :queued => :in_progress
        end

        event :fsm_create_failed do
          transition [:pending, :in_progress] => :failed
        end

        event :fsm_create_completed do
          transition [:in_progress] => :complete
        end
      end

      base.state_machine :fsm_delete_state, :initial => :inactive do
        event :fsm_delete_requested do
          transition [:inactive, :failed] => :pending
        end

        event :fsm_delete_accepted do
          transition :pending => :queued
        end

        event :fsm_delete_started do
          transition :queued => :in_progress
        end

        event :fsm_delete_completed do
          transition :in_progress => :complete
        end

        event :fsm_delete_failed do
          transition :in_progress => :failed
        end
      end
    end
  end
end