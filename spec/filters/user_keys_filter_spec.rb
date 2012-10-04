require 'spec_helper'

module Tim
  describe UserKeysFilter do

    before(:all) do |spec|
      @user_keys = UserKeysFilter.class_variable_get(:@@user_keys)
      UserKeysFilter.class_variable_set(:@@user_keys, {:k1 => :a1, :k2 => :a2})
    end

    after(:all) do |spec|
      UserKeysFilter.class_variable_set(:@@user_keys, @user_keys)
    end

    describe "replace user keys" do
      it 'should replace user keys with respective specified alternate' do
        hash = UserKeysFilter.replace_user_keys({:k1 => :v1, :k2 => :v2})
        hash[:a1].should == :v1
        hash[:a2].should == :v2
        hash.has_key?(:k1).should == false
        hash.has_key?(:k2).should == false
      end

      it 'should replace nested user keys' do
        hash = UserKeysFilter.replace_user_keys({:k1 => {:k2 => :v2}})
        hash[:a1].should == {:a2 => :v2}
      end
    end

    describe "replace user keys" do
      it 'should get the correct hash from params via controller name' do
         controller = double("ApplicationController")
         controller.stub(:controller_name).and_return "resources"
         controller.stub(:params).and_return({:resource => {:k1 => {:k2 => :v2}}})

         UserKeysFilter.should_receive(:replace_user_keys).with({:k1 => {:k2 => :v2}})
         UserKeysFilter.stub(:replace_user_keys).and_return({:a1 => {:a2 => :v2}})

         UserKeysFilter.before(controller)
      end
    end
  end
end