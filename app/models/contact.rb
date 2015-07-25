class Contact
  include ActiveModel::Model  #this line adds behaviors from the ActiveModel class
  attr_accessor :name, :string  #creates attributes (data fields) for the model.
  attr_accessor :email, :string
  attr_accessor :content, :string

  validates_presence_of :name  #Validates using ActiveModel. If fields are empty or e-mail format uses bad characters it will return an error.
  validates_presence_of :email
  validates_presence_of :content
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_length_of :content, :maximum => 500 #validates and sets maximum characters to 500.

end
