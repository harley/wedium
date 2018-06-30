if @user.persisted?
  json.user(@user, :username, :email, :bio, :image, :token)
else
  json.error "Error: #{@user.errors.full_messages.to_sentence}"
end