class SendMatchSmsJob < ApplicationJob
  # TODO: Define retry_on policy: https://edgeapi.rubyonrails.org/classes/ActiveJob/Exceptions/ClassMethods.html#method-i-retry_on
  queue_as :critical

  def perform(match)
    return if match.user.nil? ||
      match.user.phone_number.blank? ||
      match.sms_sent_at.present? ||
      (match.expires_at && match.expires_at < Time.now.utc)

    match.update(expires_at: Time.now.utc + match.campaign_batch.duration_in_minutes.minutes) if match.expires_at.nil?

    client = Twilio::REST::Client.new
    client.messages.create(
      from: "COVIDLISTE",
      to: match.user.phone_number,
      body: "Bonne nouvelle ! Un vaccin #{match.campaign_batch.campaign.vaccine_type} est disponible. Réservez-le avant #{match.expires_at.strftime("%Hh%M")} en cliquant ici : #{cta_url(match)}"
    )
    match.update(sms_sent_at: Time.now.utc)
  end

  private

  def cta_url(match)
    Rails.application.routes.url_helpers.match_url(match_confirmation_token: match.match_confirmation_token)
  end
end
