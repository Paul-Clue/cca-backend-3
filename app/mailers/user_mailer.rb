class UserMailer < ApplicationMailer
  def correct_email_check(user, tok)
    @user = user
    @tokk = tok
    # mail(to: @user.email, subject: 'Yo it worked!')
    mail(to: @user, subject: 'Yo it worked!')
  end
end