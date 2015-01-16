class AuthMailer < ActionMailer::Base
  default from: "admin@feed--me.herokuapp.com"

  def signup_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Welcome to FeedMe"
    )
  end

end
