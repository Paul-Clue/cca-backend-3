class MilestoneSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :user_id, :done?
end
