RSpec.describe Employer, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"  
  it 'has a valid factory' do
    expect(build(:employer)).to be_valid
  end    
end