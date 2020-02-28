class SubscriberMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscriber_mailer.subscribe_email.subject
  #
  def subscribe_email(subscription)
    @email = subscription.email
    @item_name = subscription.item_id
    mail(to: @email, subject: "You're subscribed!")
  end
end
