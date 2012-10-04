Tim::TemplatesController.class_eval do
  before_filter :limit_templates, :only => :index

  private
  def limit_templates
    @templates = Tim::Template.limit(10)
  end
end