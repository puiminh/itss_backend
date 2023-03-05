json.data do
    json.user do
        json.call(
            @user,
            :id,
            :email,
            :first_name,
            :last_name
        )
    end
end