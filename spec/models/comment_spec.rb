require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.find_or_create_by(name: 'user1', email: 'user1@example.com')
  post = Post.find_or_create_by(body: 'post body', user_id: user.id)

  subject do
    described_class.new(body: 'comment body',
                        user_id: user.id,
                        post_id: post.id)
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

    it 'is not valid without a post_id' do
      subject.post_id = nil
      expect(subject).to_not be_valid
    end
  end
end
