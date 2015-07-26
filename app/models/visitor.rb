class Visitor
  include ActiveModel::Model #Gives us behaviors from the ActiveModel class. Because there is no database. With database we would inherit from ActiveRecord.
  attr_accessor :email, :string  #creates email attribute and specify it as string.
  validates_presence_of :email #sets up validation for e-mail presence and format.
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  def subscribe
    mailchimp = Gibbon::API.new(Rails.application.secrets.mailchimp_api_key) #Gibbon provides connectivity with MailChimp. We provide it with an api key and store it in mailchimp variable.
    result = mailchimp.lists.subscribe({
      :id => Rails.application.secrets.mailchimp_list_id, #Access to Mail chimp list
      :email => {:email => self.email}, #address of the visitor
      :double_optin => false, #setting true would send a double opt-in confirmation msg.
      :update_existing => true, #updates a subscriber record if it already exists.
      :send_welcome => true #Sends a welcome e-mail to the new subscriber.
      })
      Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
  end

end
