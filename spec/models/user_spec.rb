require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validataions' do
    it { should have_secure_password }
    it { should have_secure_token :api_key }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_length_of(:password).is_at_least(8) }
  end

  describe 'factorybot' do
    it 'creates valid factorybot object' do
      user = create(:user)

      expect(user).to be_a(User)
    end

    it 'creates factory object with all attributes' do
      user = create(:user, email: 'example@example.com', password: 'password!')

      expect(user).to have_attributes(email: 'example@example.com')
      expect(user).to have_attributes(password: 'password!')
      expect(user).to have_attribute(:api_key)
    end
  end
end
