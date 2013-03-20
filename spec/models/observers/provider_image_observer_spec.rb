require 'spec_helper'

module Tim
  describe ProviderImageObserver do

    before(:each) do
      TargetImage.any_instance.stub(:create_factory_target_image)
        .and_return(true)
      ProviderImage.any_instance.stub(:create_factory_provider_image)
        .and_return(true)
      @pi = FactoryGirl.build(:provider_image_with_full_tree)
      @pio = ProviderImageObserver.instance
    end

    describe "Create FSM" do

      it "should transition from new to pending when provider image is created" do
        @pi.should_receive(:fsm_create_request)
        @pi.save
      end

      describe "factory images (non-imported)" do
        before(:each) do
          @pi.stub(:imported?).and_return(false)
        end

        it "should send factory request after transition from pending to queued" do
          @pi.should_receive(:create_factory_provider_image)
          @pio.after_fsm_create_request(@pi, nil)
        end

        it "should transition to failed if factory request fails" do
          @pi.stub(:create_factory_provider_image).and_raise(Errno::ECONNREFUSED)
          @pi.should_receive(:fsm_create_fail)
          @pio.after_fsm_create_request(@pi, nil)
        end

        describe "after factory callback" do
          before(:each) do
            @pi.fsm_create_state = "queued"
          end

          it "should transition from queued through to completed when factory 
                  returns complete" do
            @pi.status = "COMPLETE"
            @pi.should_receive(:fsm_create_start)
            @pi.should_receive(:fsm_create_complete)
            @pi.save
          end
  
          it "should transition from queued to in_progress when factory returns 
               in_progress" do
            @pi.status = "BUILDING"
            @pi.should_receive(:fsm_create_start)
            @pi.save
          end
  
          it "should transition from queued through to failed when factory returns
               failed" do
            @pi.status = "FAILED"
            @pi.should_receive(:fsm_create_start)
            @pi.should_receive(:fsm_create_fail)
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
          @pi.should_receive(:fsm_create_accept)
          @pi.should_receive(:fsm_create_start)
          @pi.should_receive(:fsm_create_complete)
          @pio.after_fsm_create_request(@pi, nil)
        end

        it "should transition directly to failed on failed import" do
          @pi.stub(:create_import).and_return(false)
          @pi.should_receive(:fsm_create_fail)
          @pio.after_fsm_create_request(@pi, nil)
        end
      end
    end

    describe "Delete FSM", :delete => true do
      before (:each) do
        TargetImage.any_instance.stub(:delete_factory_target_image)
          .and_return(true)
        ProviderImage.any_instance.stub(:delete_factory_provider_image)
          .and_return(true)
      end

      it "should transition from inactive to pending when provider image destroy
            with credentials is called" do
        @pi.should_receive(:fsm_delete_request)
        @pi.destroy
      end

      describe "imported images (non-factory images)" do
        before(:each) do
          @pi.stub(:imported?).and_return(true)
        end

        it "should transition from pending through to completed when imported 
            image is deleted" do
          @pi.should_receive(:fsm_delete_accept)
          @pi.should_receive(:fsm_delete_start)
          @pi.should_receive(:fsm_delete_complete)
          @pio.after_fsm_delete_request(@pi, nil)
        end
      end

      describe "factory images (non-imported)" do
        before(:each) do
          @pi.stub(:imported?).and_return(false)
        end

        it "should send factory delete request after transition from inactive to
              pending" do
          @pi.should_receive(:delete_factory_provider_image)
          @pio.after_fsm_delete_request(@pi, nil)
        end

        it "should transition to failed if factory delete request fails" do
          @pi.stub(:delete_factory_provider_image).and_raise(Errno::ECONNREFUSED)
          @pi.should_receive(:fsm_delete_fail)
          @pio.after_fsm_delete_request(@pi, nil)
        end

        describe "after factory callback" do
          before(:each) do
            @pi.fsm_delete_state = "queued"
          end

          it "should transition from queued through to completed when factory 
                  returns deleted" do
            @pi.status = "DELETED"
            @pi.should_receive(:fsm_delete_start)
            @pi.should_receive(:fsm_delete_complete)
            @pi.save
          end
  
          it "should transition from queued to in_progress when factory returns 
               deleting" do
            @pi.status = "DELETING"
            @pi.should_receive(:fsm_delete_start)
            @pi.save
          end
  
          it "should transition from queued through to failed when factory returns
               delete failed" do
            @pi.status = "DELETEFAILED"
            @pi.should_receive(:fsm_delete_start)
            @pi.should_receive(:fsm_delete_fail)
            @pi.save
          end

          it "should transition from in progress to complete when factory returns
               deleted and status is deleting" do
            @pi.fsm_delete_state = "in_progress"
            @pi.status = "DELETED"
            @pi.should_receive(:fsm_delete_complete)
            @pi.save
          end
        end
      end
    end

  end
end