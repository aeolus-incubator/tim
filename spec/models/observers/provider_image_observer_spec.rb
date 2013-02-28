require 'spec_helper'

module Tim
  describe ProviderImageObserver do
    describe "Create FSM" do

      before (:each) do
        TargetImage.any_instance.stub(:create_factory_target_image)
          .and_return(true)
        ProviderImage.any_instance.stub(:create_factory_provider_image)
          .and_return(true)
        @pi = FactoryGirl.build(:provider_image_with_full_tree)
        @pio = ProviderImageObserver.instance
      end

      it "should transition from new to pending when provider image is created" do
        @pi.should_receive(:fsm_create_requested)
        @pi.save
      end

      describe "factory images (non-imported)" do
        before(:each) do
          @pi.stub(:imported?).and_return(false)
        end

        it "should send factory request after transition from pending to queued" do
          @pi.should_receive(:create_factory_provider_image)
          @pio.after_fsm_create_requested(@pi, nil)
        end

        it "should transition to failed if factory request fails" do
          @pi.stub(:create_factory_provider_image).and_raise(Errno::ECONNREFUSED)
          @pi.should_receive(:fsm_create_failed)
          @pio.after_fsm_create_requested(@pi, nil)
        end

        describe "after factory callback" do
          before(:each) do
            @pi.fsm_create_state = "queued"
          end

          it "should transition from queued through to completed when factory 
                  returns complete" do
            @pi.status = "COMPLETE"
            @pi.should_receive(:fsm_create_start)
            @pi.should_receive(:fsm_create_completed)
            @pi.save
          end
  
          it "should transition from queued to in_progress when factory returns 
               in_progress" do
            @pi.status = "IN_PROGRESS"
            @pi.should_receive(:fsm_create_start)
            @pi.save
          end
  
          it "should transition from queued through to failed when factory returns
               failed" do
            @pi.status = "FAILED"
            @pi.should_receive(:fsm_create_start)
            @pi.should_receive(:fsm_create_failed)
            @pi.save
          end
        end

      end

      describe "imported images" do
        before(:each) do
          @pi.stub(:imported?).and_return(true)
        end

        it "should transition through queued to complete on successful import" do
          @pi.stub(:create_import).and_return(true)
          @pi.should_receive(:fsm_create_accepted)
          @pi.should_receive(:fsm_create_start)
          @pi.should_receive(:fsm_create_complete)
          @pio.after_fsm_create_requested(@pi, nil)
        end

        it "should transition directly to failed on failed import" do
          @pi.stub(:create_import).and_return(false)
          @pi.should_receive(:fsm_create_failed)
          @pio.after_fsm_create_requested(@pi, nil)
        end
      end

    end
  end
end