require 'test_helper'

class ReturnMailerTest < ActionMailer::TestCase
  test "return_email" do
    mail = ReturnMailer.return_email
    assert_equal "Return email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
