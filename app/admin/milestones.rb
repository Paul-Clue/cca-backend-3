ActiveAdmin.register Milestone do
  permit_params :title, :instructions, :user_id, :completed

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :instructions, :user_id, :done?
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :instructions, :user_id, :done?]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
