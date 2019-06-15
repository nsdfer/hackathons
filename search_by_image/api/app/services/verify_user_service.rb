# frozen_string_literal: true

class VerifyUserService
  def self.send_code(user)
    code = rand(100_000...999_999)

    user.update!(verification_code: code)

    TWILIO_CLIENT.api.account.messages.create(
      from: Settings.twilio.phone_number,
      to: user.phone_number,
      body: "Verification Code: #{code}"
    )
  end

  def self.verify(user:, code:)
    if user.verification_code == code
      user.update!(status: :active)

      return true
    end

    false
  end
end
