class PostSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :post, :created_at
end