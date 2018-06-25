if @user.persisted?
  json.user(@user, :username, :email, :bio, :image)
  json.token User.generate_jwt(@user.id)
else
  json.error "Error: #{@user.errors.full_messages.to_sentence}"
end