require 'rails_helper'

RSpec.describe Comment do
  subject { FactoryGirl.build(:comment) }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:author_id) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }

  it { should belong_to(:commentable) }
  it { should belong_to(:author)
    .class_name("User")
    .with_foreign_key(:author_id) }

  let(:author) { double("User", id: 1) }
  let(:target) { double("User", id: 2) }
  let(:comment)  { FactoryGirl.build(:comment, author_id: 1, commentable_type: "User", commentable_id: 2) }

  describe "Comment#is_by?" do

    it "returns true when the passed user is the author" do
      expect(comment.is_by?(author)).to be true
    end

    it "returns false when the passed user is not the author" do
      expect(comment.is_by?(target)).to be false
    end
  end

  describe "Comment#is_about?" do

    it "returns true when the passed object is the commentable" do
      expect(comment.is_about?(target)).to be true
    end

    it "returns false when the passed object is not the commentable" do
      expect(comment.is_about?(author)).to be false
    end
  end

end
