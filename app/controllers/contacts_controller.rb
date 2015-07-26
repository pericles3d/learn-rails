class ContactsController < ApplicationController

  def new
    @contact = Contact.new  #Instantiate an empty Contact model to @contact and render the new.html view.
  end

  def create
    @contact = Contact.new(secure_params)
    if @contact.valid?  #valid is an ActiveModel method and will check for the validations we set in the model.
      UserMailer.contact_email(@contact).deliver #we use the UserMailer class and call the contact_email method, passing the @contact variable and then we deliver it.
      flash[:notice] = "Message sent from #{@contact.name}." #If contact is valid, a flash message will display.
      redirect_to root_path  #We are then redirected to the root. Route routes shows this.
    else
      render :new  #If the validation fails, the new.html is rendered displaying the errors.
    end
  end

  private  #This assures that the secure_params method is only used in this controller.

  def secure_params
    params.require(:contact).permit(:name, :email, :content) #require(:contact) makes sure that params[:contact] is present. The permit field shows what can be used.
  end

end
