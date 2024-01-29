require 'rails_helper'

RSpec.describe Follow, type: :model do
  follower = User.find_or_create_by(name: 'user1', email: 'user1@example.com')
  followee = User.find_or_create_by(name: 'user2', email: 'user2@example.com')

  subject do
    described_class.new(follower: follower,
                        followee: followee)
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a follower' do
      subject.follower = nil
      expect(subject).to_not be_valid

    end

    it 'is not valid without a followee' do
      subject.followee = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid if follower is followee' do
      subject.follower = followee
      expect(subject).to_not be_valid
    end
  end
end
