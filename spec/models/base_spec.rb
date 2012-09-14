require 'spec_helper'

module ActiveRecord
  describe Base do
    describe "allow mass assignment of nested attributes with module namespace" do

      describe "create" do
        it "should allow mass assigment of attributes with one to one relationship" do
          template_xml = "<template></template>"
          b = ImageManagement::BaseImage.create({:template => {:xml => template_xml}}, :as => :admin)
          b.new_record?.should == false
          b.template.xml.should == template_xml
        end
      end

      describe "update_attributes" do
        it "should allow mass assigment of attributes with one to one relationship" do
          template_xml = "<template></template>"
          b = ImageManagement::BaseImage.new
          b.update_attributes({:template => {:xml => template_xml}})
          b.reload
          b.template.xml.should == template_xml
        end
      end

      describe "new" do
        it "should allow mass assigment of attributes with one to one relationship" do
          template_xml = "<template></template>"
          b = ImageManagement::BaseImage.new({:template => {:xml => template_xml}})
          b.new_record?.should == true
          b.template.xml.should == template_xml
        end
      end

    end
  end
end
