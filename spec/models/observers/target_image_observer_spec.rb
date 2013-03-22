require 'spec_helper'

module Tim
  describe TargetImageObserver do

    before(:all) do
      TargetImage.observers.enable Tim::TargetImageObserver
      @tio = TargetImageObserver.instance
    end

    after(:all) do
      TargetImage.observers.disable Tim::TargetImageObserver
    end

    before(:each) do
      TargetImage.any_instance.stub(:create_factory_target_image)
        .and_return(true)
      ProviderImage.any_instance.stub(:create_factory_provider_image)
        .and_return(true)
      @ti = FactoryGirl.build(:target_image_with_full_tree)
    end

    describe "Create FSM" do

      it "should transition from new to pending when target image is created" do
        @ti.should_receive(:fsm_create_request)
        @ti.save
      end

      describe "factory images (non-imported)" do
        before(:each) do
          @ti.stub(:imported?).and_return(false)
        end

        it "should send factory request after transition from pending to queued" do
          @ti.should_receive(:create_factory_target_image)
          @tio.after_fsm_create_request(@ti, nil)
        end

        it "should transition to failed if factory request fails" do
          @ti.stub(:create_factory_target_image).and_raise(Errno::ECONNREFUSED)
          @ti.should_receive(:fsm_create_fail)
          @tio.after_fsm_create_request(@ti, nil)
        end

        describe "after factory callback" do
          before(:each) do
            @ti.fsm_create_state = "queued"
          end

          it "should transition from queued through to completed when factory
                  returns complete" do
            @ti.status = "COMPLETE"
            @ti.should_receive(:fsm_create_start)
            @ti.should_receive(:fsm_create_complete)
            @ti.save
          end

          it "should transition from queued to in_progress when factory returns
               in_progress" do
            @ti.status = "BUILDING"
            @ti.should_receive(:fsm_create_start)
            @ti.save
          end

          it "should transition from queued through to failed when factory returns
               failed" do
            @ti.status = "FAILED"
            @ti.should_receive(:fsm_create_start)
            @ti.should_receive(:fsm_create_fail)
            @ti.save
          end
        end

      end

      describe "imported images" do
        before(:each) do
          @ti.stub(:imported?).and_return(true)
        end

        it "should transition through queued to complete on successful import" do
          @ti.stub(:create_import).and_return(true)
          @ti.should_receive(:fsm_create_accept)
          @ti.should_receive(:fsm_create_start)
          @ti.should_receive(:fsm_create_complete)
          @tio.after_fsm_create_request(@ti, nil)
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

      it "should transition from inactive to pending when target image destroy
            with credentials is called" do
        @ti.should_receive(:fsm_delete_request)
        @ti.destroy
      end

      describe "imported images (non-factory images)" do
        before(:each) do
          @ti.stub(:imported?).and_return(true)
        end

        it "should call fsm_delete_request on and all provider images after "\
            "fsm_delete_request" do
          2.times do
            pi = ProviderImage.new
            @ti.provider_images << pi
            pi.should_receive(:fsm_delete_request)
          end
          @tio.after_fsm_delete_request(@ti, :fsm_delete_request)
        end

        it "should transition from pending through to completed when imported
            image is deleted" do
          @ti.should_receive(:fsm_delete_accept)
          @ti.should_receive(:fsm_delete_start)
          @ti.should_receive(:fsm_delete_complete)
          @tio.after_fsm_delete_request(@ti, nil)
        end
      end

      describe "factory images (non-imported)" do
        before(:each) do
          @ti.stub(:imported?).and_return(false)
        end

        it "should send factory delete request after transition from inactive to
              pending" do
          @ti.should_receive(:delete_factory_target_image)
          @tio.after_fsm_delete_request(@ti, nil)
        end

        it "should transition to failed if factory delete request fails" do
          @ti.stub(:delete_factory_target_image).and_raise(Errno::ECONNREFUSED)
          @ti.should_receive(:fsm_delete_fail)
          @tio.after_fsm_delete_request(@ti, nil)
        end

        describe "after factory callback" do
          before(:each) do
            @ti.fsm_delete_state = "queued"
          end

          it "should transition from queued through to completed when factory
                  returns deleted" do
            @ti.status = "DELETED"
            @ti.should_receive(:fsm_delete_start)
            @ti.should_receive(:fsm_delete_complete)
            @ti.save
          end

          it "should transition from queued to in_progress when factory returns
               deleting" do
            @ti.status = "DELETING"
            @ti.should_receive(:fsm_delete_start)
            @ti.save
          end

          it "should transition from queued through to failed when factory returns
               delete failed" do
            @ti.status = "DELETEFAILED"
            @ti.should_receive(:fsm_delete_start)
            @ti.should_receive(:fsm_delete_fail)
            @ti.save
          end

          it "should transition from in progress to complete when factory returns
               deleted and status is deleting" do
            @ti.fsm_delete_state = "in_progress"
            @ti.status = "DELETED"
            @ti.should_receive(:fsm_delete_complete)
            @ti.save
          end
        end
      end
    end

  end
end