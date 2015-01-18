class AuthMailer < ActionMailer::Base
  default from: "admin@feed--me.herokuapp.com"

  def signup_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Welcome to FeedMe"
    )
  end

  def username_email(user)
    @user = user
    mail(
    to: @user.email,
    subject: "FeedMe username"
    )
  end

  def password_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: "Feedme password reset"
    )
  end

end
