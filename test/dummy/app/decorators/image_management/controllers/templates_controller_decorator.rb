ImageManagement::TemplatesController.class_eval do
  before_filter :limit_templates, :only => :index

  private
  def limit_templates
    @templates = ImageManagement::Template.limit(10)
  end
end