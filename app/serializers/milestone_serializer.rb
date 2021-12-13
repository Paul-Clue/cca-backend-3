class MilestoneSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :user_id, :completed
end
