class UserSerializer < ActiveModel::serializer
    attributes :id, :username, :binder_name
end