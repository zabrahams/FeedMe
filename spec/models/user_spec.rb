require 'rails_helper'

RSpec.describe User do
  subject { FactoryGirl.create(:user) }

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
    let(:found_user) { FactoryGirl.build(:user) }
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
    let(:entry) { FactoryGirl.create(:entry) }
    before { subject.read_entry(entry) }

    it "should add a new entry to read_entries if entry isn't there." do
      expect(subject.read_entries.first).to eq(entry)
    end

    it "should add a new entry to the curated feed if entry isn't
    there." do
      expect(subject.curated_feed.entries.first).to be(entry)
    end

    it "should do nothing if entry is already read" do
      old_count = subject.read_entries.count
      subject.read_entry(entry)
      expect(subject.read_entries.count).to eq(old_count)
    end

  end

  describe "#setup_curated_feed" do
    let(:curator) { FactoryGirl.build(:user) }
    before { curator.setup_curated_feed }

    it "should create a curated feed" do
      expect(curator.curated_feed).to_not be_nil
    end

    it "should name the feed Username's Recent Reading!" do
      expect(curator.curated_feed.name).to eq("#{curator.username}'s Recent Reading!")
    end

    it "should create a feed with url: 'Local Feed'" do
      expect(curator.curated_feed.url).to eq("Local Feed")
    end

    it "should create a feed with curated flagged as true" do
      expect(curator.curated_feed.curated).to be(true)
    end

  end

  describe "#make_feed" do
    let(:feed) { subject.make_feed }

    it "should return an rss feed" do
      expect(feed.class).to eq(RSS::Atom::Feed)
    end

    describe "feed" do

      it "should have the user's username as author" do
        expect(feed.author.name.content).to eq(subject.username)
      end

      it "should have been last updated when created"

      it "should have as a title: Username's FeedMe Feed!!!!" do
        expect(feed.title.content).to eq("#{subject.username}'s FeedMe Feed!!!!")
      end

      it "should have as a url: feed--me.com/api/user/:id/personal_feed" do
        expect(feed.id.content).to eq("http://feed--me.com/api/user/#{subject.id}/personal_feed")
      end

      it "should have an item for each read entries" do
        expect(feed.entries.count).to eq(subject.read_entries.count)
        puts feed.entries.count
      end

      describe "item" do
        before { subject.read_entry(FactoryGirl.create(:entry,
          guid: "Test ID",
          title: "Test Title",
          link: "http://testlink.com")) }

        it "should have the entry's guid as an id" do
          expect(feed.entries.first.id.content).to eq("Test ID")
        end

        it "should have the entry's title as a title" do
          expect(feed.entries.first.title.content).to eq("Test Title")
        end

        it "should have the entry's link as a link" do
          expect(feed.entries.first.link.href).to eq("http://testlink.com")
        end

        # Include conditional tests for possible entry properties, updated, author, summary and content

      end

    end

  end

  describe "#verify_security_question" do
    let(:question) { FactoryGirl.create(:security_question) }
    let(:answer) { FactoryGirl.create(
        :security_question_answer,
        question_id: question.id,
        user_id: subject.id,
        answer: "GoodAnswer") }
    before do
      question.save
      answer.save
    end

    it "should return false if the answer is wrong" do
      expect(subject.verify_security_question(question.id, "BadAnswer")).to be false
    end

    it "should return true if the answer is right" do
      expect(subject.verify_security_question(question.id, "GoodAnswer")).to be true
    end

  end

  describe "#set_reset_token" do
    before { subject.set_reset_token }

    it "should set a reset token" do
      expect(subject.reset_token).to_not be_nil
    end

    it "should override a previous reset token" do
      old_token = subject.reset_token
      subject.set_reset_token
      expect(subject.reset_token).to_not eq(old_token)
    end
  end

  describe "#has_reset_token?" do
    before { subject.set_reset_token }
    let(:token) { subject.reset_token }

    it "should return true if the user has that reset token" do
      expect(subject.has_reset_token?(token)).to be true
    end

    it "should return false if the user doesn't have that reset token" do
      expect(subject.has_reset_token?("bad_token")).to be false
    end

  end

  describe "clear_reset_token" do
    before { subject.set_reset_token }

    it "should set the reset token to nil" do
      subject.clear_reset_token
      expect(subject.reset_token).to be_nil
    end

  end

  describe "#reset_session_token!" do
    before { subject.session_token = nil }
    before { subject.reset_session_token! }

    it "should assign a session token" do
      expect(subject.session_token).to_not be_nil
    end

    it "should overwrite the previous session token" do
      old_token = subject.session_token
      subject.reset_session_token!
      expect(subject.session_token).to_not eq(old_token)
    end

  end
end
