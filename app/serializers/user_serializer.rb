class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :binder_name
end