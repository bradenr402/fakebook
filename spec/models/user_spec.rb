require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: 'John Doe',
                        email: 'john@doe.com',
                        password: 'some_password')
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end
end
