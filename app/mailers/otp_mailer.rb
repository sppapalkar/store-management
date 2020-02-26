class OtpMailer < ApplicationMailer
  default from: 'csc517.storemgmt@gmail.com'

  def otp_email(user, otp)
    @user = user
    @otp = otp
    mail(to: @user.email, subject: 'OTP Email')
  end
end
