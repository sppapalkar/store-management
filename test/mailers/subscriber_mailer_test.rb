require 'test_helper'

class SubscriberMailerTest < ActionMailer::TestCase
  test "subscribe_email" do
    mail = SubscriberMailer.subscribe_email
    assert_equal "Subscribe email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
