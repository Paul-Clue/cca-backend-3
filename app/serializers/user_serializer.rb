class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :phone_number, :address, :release_date, :employment_date, :employment_type, :employed, :work_hours, :residence, :manager, :user_type, :meeting
end
