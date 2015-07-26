class VisitorsController < ApplicationController

  def new
    @visitor = Visitor.new  #assigns the Visitor model to a visitor instance variable
  end

  def create
    @visitor = Visitor.new(secure_params)
    if @visitor.valid? #valid is an ActiveModel method and will check for the validations we set in the Visitor model.
      @visitor.subscribe #subscribes the visitor to MailChimp mailing list
      flash[:notice] = "Signed up #{@visitor.email}"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def secure_params
    params.require(:visitor).permit(:email)
  end

end
