# There is a bug in Rails which causes issues when using accepts_nested_attrs
# and inverse_of on associations:  https://github.com/rails/rails/issues/7809/
# This code was lifted from the pull request of the bug shown above.  It solves
# the issue.  Until this is merged into rails we will have to carry the patch
# ourselves.

module ActiveRecord
  module AutosaveAssociation
    extend ActiveSupport::Concern

    # Returns whether or not this record has been changed in any way (including whether
    # any of its nested autosave associations are likewise changed)
    def changed_for_autosave?
      @_changed_for_autosave_called ||= false
      if @_changed_for_autosave_called
        # traversing a cyclic graph of objects; stop it
        result = false
      else
        begin
          @_changed_for_autosave_called = true
          result = new_record? || changed? || marked_for_destruction? || nested_records_changed_for_autosave?
        ensure
          @_changed_for_autosave_called = false
        end
      end
      result
    end
  end
end