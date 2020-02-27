# Preview all emails at http://localhost:3000/rails/mailers/subscriber_mailer
class SubscriberMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/subscriber_mailer/subscribe_email
  def subscribe_email
    SubscriberMailer.subscribe_email
  end

end
