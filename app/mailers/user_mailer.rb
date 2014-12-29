class UserMailer < ActionMailer::Base
  default from: "stanforday@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = new_user_session_url
    mail(to: @user.email, subject: 'Welcome to SAY')
  end

  def account_for_you(user)
    @user = user
    @url  = new_user_session_url
    mail(to: @user.email, bcc: 'stanforday@gmail.com', subject: 'Your SAY Account')
  end
end
