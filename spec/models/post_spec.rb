require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.find_or_create_by(name: 'user1', email: 'user1@example.com')

  subject do
    described_class.new(body: 'body',
                        user_id: user.id)
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a body' do
      subject.body = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a user_id' do
      subject.user_id = nil
      expect(subject).to_not be_valid
    end
  end
end
