class UserMailer < ApplicationMailer

  def contact_email(contact)
    @contact = contact  #This makes an instance variable so that contact can be used in the View.
    mail(to: Rails.application.secrets.owner_email, from: @contact.email, :subject => "Website Contact")
    #in the line above, mail is a method from ActionMailer and it renders the view. Creates an e-mail from the email specified in the Contact page with the subject "Website Contact"
  end
end
