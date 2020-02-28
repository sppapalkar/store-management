class ReturnMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.return_mailer.return_email.subject
  #
  def return_approve(orderitem)
    @order = orderitem
    mail(to: @order.order.user.email, subject: 'Return Request')
  end

  def return_reject(orderitem)
    @order = orderitem
    mail(to: @order.order.user.email, subject: 'Return Request')
  end
end
