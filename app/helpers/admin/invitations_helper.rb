module Admin::InvitationsHelper
  def activation_code_form_column(record, input_name)
    @record.activation_code = 'ddd'
    text_field :record, :activation_code 
  end
end
