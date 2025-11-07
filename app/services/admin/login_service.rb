module Admin
    class LoginService
        Result = Struct.new(:success?, :user, :error_message)

        def initialize(email, password)
            @email = email
            @password = password
        end

        def call
            user = User.find_by(email: email)
            puts ">>> Đã vào MyService#call"
            if user && user.authenticate(password)
                Result.new(true, user, nil)
            else
                Result.new(false, nil, "Email hoặc mật khẩu không đúng")
            end
        end

        private

        attr_reader :email, :password
    end
end