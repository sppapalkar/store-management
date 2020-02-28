class SubscriberMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscriber_mailer.subscribe_email.subject
  #
  def subscribe_email(subscription, item)
    @item = item.name
    @brand = item.brand
    mail(to: subscription.email, subject: "You're subscribed!")
  end
end
