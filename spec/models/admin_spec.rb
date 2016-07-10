require 'rails_helper'

describe Admin do 
  it "is valid with a first name, last name, email, password" do
    admin = Admin.new(
      first_name: "Idina",
      last_name: "Menzel",
      email: "idina@gmail.com",
      password: "defying_gravity")
    expect(admin).to be_valid
  end
  it "in invalid without a first name"
  it "in invalid without a last name"
  it "returns an admin's full name as a string"
end