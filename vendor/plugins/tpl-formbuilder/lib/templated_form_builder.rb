class TemplatedFormBuilder < ActionView::Helpers::FormBuilder
  (field_helpers + %w(date_select datetime_select collection_select select)).each do |helper|
    define_method(helper) do |*args|
      args << {} unless args.last.is_a? Hash

      label = args[-1].delete(:label) do
        args.first.to_s.humanize
      end

      render_form_element helper, label, args, super(*args)
    end
  end

  private
    def render_form_element(helper, label, helper_args, element)
      locals = {
        :label => label_for(helper_args.first, label),
        :element => element,
        :errors => @template.error_message_on("#{@object_name}","#{helper_args[0]}"),
        :options => helper_args.last
      }

      begin
        @template.render :partial => "forms/#{helper}", :locals => locals
      rescue ActionView::ActionViewError
        @template.render :partial => 'forms/element', :locals => locals
      end
    end

    def label_for(method, label)
      return '' if label.nil?
      @template.content_tag('label', label, {:for => "#{@object_name}_#{method}"})
    end
end
