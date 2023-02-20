json.data do
    json.user do
        json.call(
            @user,
            :id,
            :email
        )
        # json.id @user.id
        # json.email @user.email
    end

end