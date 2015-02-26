require 'rails_helper'

RSpec.describe User do
  subject { FactoryGirl.build(:user) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:activation_token) }


  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:session_token) }

  it { should have_many(:watcher_user_follows) }
  it { should have_many(:curator_user_follows) }
  it { should have_many(:watchers) }
  it { should have_many(:curators) }

  it { should have_many(:user_feeds) }
  it { should have_many(:feeds) }
  it { should have_many(:categories) }
  it { should have_many(:user_read_entries) }
  it { should have_many(:read_entries) }

  it { should have_many(:security_question_answers)
      .inverse_of(:user)
      .dependent(:destroy)}
  it { should have_many(:security_questions) }

  describe "::find_by_credentials" do
    let(:found_user) { FactoryGirl.create(:user) }
    before { found_user.save }

    it "should return a user if given a valid username and password" do
      expect(User.find_by_credentials("John", "123456")).to eq(found_user)
    end

    it "should return nil if not given a valid username" do
      expect(User.find_by_credentials("BadUsername", "123456")).to be_nil
    end

      it "should return nil if the password is incorrect." do
      expect(User.find_by_credentials("John", "BadPassword")).to be_nil
    end

  end

  describe "#password=" do
    before { subject.password_digest = nil }
    before { subject.password = "abcdef" }

    it "should set @password" do
      expect(subject.instance_variable_get(:@password)).to eq("abcdef")
    end

    it "should set the password digest" do
      expect(subject.password_digest).to_not be_nil
    end
    it "should not set the password digest equal to the password." do
      expect(subject.password_digest).not_to be(subject.password)
    end
  end

  describe "#has_password?" do

    it "should return true if the user's password is password" do
      expect(subject.has_password?('123456')).to be_truthy
    end

    it "should return false if the user's password is not password." do
      expect(subject.has_password?('111111')).to be_falsey
    end
  end

  describe "#read_entry" do

    it "should add a new entry to read_entries if entry isn't there."

    it "should add a new entry to the curated feed if entry isn't there."

    it "should do nothing if entry is already read"

  end

  describe "#setup_curated_feed" do

    it "should create a curated feed"

    it "should name the feed Username's Recent Reading!"

    it "should create a feed with url: 'Local Feed'"

    it "should create a feed with curated flagged as true"

  end

  describe "#make_feed" do

    it "should return an rss feed"

    describe "feed" do

      it "should have the user's username as author"

      it "should have been last updated when created"

      it "should have as a title: Username's FeedMe Feed!!!"

      it "should have as a url: feed--me.com/api/user/:id/personal_feed"

      it "should have an item for each read entries"

      describe "item" do

        it "should have the entry's guid as an id"

        it "should have the entry's title as a title"

        it "should have the entry's link as a link"

        # Include conditional tests for possible entry properties, updated, author, summary and content

      end

    end

  end

  describe "#verify_security_questions" do

    it "should return false if the first answer is wrong"

    it "should return false if the second answer is wrong"

    it "should return true if both answers are right"

  end

  describe "#set_reset_token" do

    it "should set a reset token"

    it "should override a previous reset token"

  end

  describe "#has_reset_token?" do

    it "should return true if the user has a reset token"

    it "should return false if the user doesn't have a reset token"

  end

  describe "clear_reset_token" do

    it "should set the reset token to nil"

  end

  describe "#reset_session_token!" do

    it "should assign a session token"

    it "should overwrite the previosu session token"

  end


end
