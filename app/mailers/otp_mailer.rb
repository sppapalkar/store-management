class OtpMailer < ApplicationMailer
  default from: 'csc517.storemgmt@gmail.com'

  def otp_email(user)
    @user = user
    mail(to: @user.email, subject: 'OTP Email')
  end
end
