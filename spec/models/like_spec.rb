require 'rails_helper'

RSpec.describe Like, type: :model do
  user = User.find_or_create_by(name: 'user1', email: 'user1@example.com')
  post = Post.find_or_create_by(body: 'post body', user_id: user.id)
  comment = Comment.find_or_create_by(body: 'comment body', user_id: user.id, post_id: post.id)

  describe 'post likes validations' do
    subject do
      described_class.new(user_id: user.id,
                          likeable_type: post.class.to_s,
                          likeable_id: post.id)
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a likeable_id' do
      subject.likeable_id = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a likeable_type' do
      subject.likeable_type = nil
      expect(subject).to_not be_valid
    end
  end

  describe 'comment likes validations' do
    subject do
      described_class.new(user_id: user.id,
                          likeable_type: comment.class.to_s,
                          likeable_id: comment.id)
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a likeable_id' do
      subject.likeable_id = nil
      expect(subject).to_not be_valid
    end
    it 'is not valid without a likeable_type' do
      subject.likeable_type = nil
      expect(subject).to_not be_valid
    end
  end
end
