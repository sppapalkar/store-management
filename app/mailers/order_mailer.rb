class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.order_email.subject
  #
  def order_email(user, items)
    @user = user
    @final_item = items
    mail(to: @user.email, subject: 'Order Placed')
  end
end
