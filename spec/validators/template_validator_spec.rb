require 'spec_helper'

module Tim
  describe TemplateValidator do
    it "should not add errors on template with valid xml" do
      template = FactoryGirl.build(:template)
      TemplateValidator.new({}).validate(template)
      template.errors.size.should == 0
    end

    it "should add errors to template with invalid xml" do
      template = FactoryGirl.build(:template, 
                                   :xml => "<invalid_template>
                                            </invalid_template>")
      TemplateValidator.new({}).validate(template)
      template.errors.size.should > 0
    end
  end
end