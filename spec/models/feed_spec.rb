require 'webmock/rspec'
require 'feedjira'
require 'rails_helper'
require 'byebug'

RSpec.describe Feed do
  subject { FactoryGirl.build(:feed) }

  it { should validate_presence_of(:url).on(:save) }

  it { should validate_uniqueness_of(:name).on(:save) }



  it { should have_many(:user_feeds).dependent(:destroy) }
  it { should have_many(:users).through(:user_feeds) }

  it { should have_many(:feed_entries) }
  it { should have_many(:entries)
    .through(:feed_entries)
    .source(:entry)
  }

  it { should have_many(:category_feeds)
    .inverse_of(:feed)
    .dependent(:destroy)}
  it { should have_many(:categories).through(:category_feeds) }

  it { should belong_to(:curator)
    .class_name("User")
    .with_foreign_key(:curator_id)
  }

  # Write tests for custom validation: url_must_lead to rss Feed
  # write test for callbacks: before_validation, after_save, before_destroy

  describe "Feed#set_name_and_url" do
    it "should set self.name if self.url points to a feed" do
      #  name_feed = FactoryGirl.build(:feed, url: 'www.testfeed.com')
      # expect(Feedjira::Feed.fetch_and_parse('')).to eq(4)
      subject.set_name_and_url
      expect(subject.name).to eq("TestFeed")
    end

    describe "if the url doesn't point to a feed" do
      let(:bad_feed) { FactoryGirl.build(:feed, url: "file:///absent.xml") }

      describe "but the page has a link to an rss feed" do
        before do
          WebMock::API::stub_request(:any, "http://file///absent.xml")
            .to_return(body: '<link rel="alternate" type="application/rss+xml" title="test_feed" href="file:///home/zach/aa/FeedMe/spec/models/feeds_data/test_feed.xml">')
        end
        before { bad_feed.set_name_and_url}

        it "should find the new url" do
          expect(bad_feed.url).to eq("file:///home/zach/aa/FeedMe/spec/models/feeds_data/test_feed.xml")
        end

        it "should set the name" do
          expect(bad_feed.name).to eq("TestFeed")
        end
      end

      it "should not set self.name if self.url doesn't point to a feed." do
        WebMock::API::stub_request(:any, "http://file///absent.xml")
            .to_return(body: "Not a Feed")
        bad_feed.set_name_and_url
        expect(bad_feed.name).to be_nil
      end

    end
  end

  describe "Feed#fetch_entries" do

    it "should return the curators read entries when curated"

    it "should create new entries if there are entries."

    it "should not add more than 40 entries"

  end

  describe "Feed#need_update?" do
      let(:new_feed) { FactoryGirl.build(:feed, updated_at: Time.now) }
      let(:old_feed) { FactoryGirl.build(:feed, updated_at: 10.years.ago) }

    it "should return true if feed hasn't been updated in three minutes." do
      expect(new_feed.need_update?).to be false
    end

    it "should return false if feed has been updated in the last three minutes." do
      expect(old_feed.need_update?).to be true
    end
  end

  describe "Feed#update_entries" do

    it "should not add more than 40 entries"

    it "should remove entries no longer in the feed"

    it "should create new entries"

    it "should change the feed's updated_at attribute"

  end

  describe "Feed#entry_to_json" do

    it "returns a json object"

    it "return an object whith certain keys"

    it "Doesn't return an object with other keys"

  end

  describe "Feed#destroy_entries_unless_curated" do
    before { subject.save }

    it "destroys all entries if feed isn't curated" do
      debugger
      expect(subject.entries.length).to eq(2)
      subject.destroy_entries_unless_curated
      expect(subject.entries.length).to eq(0)
    end

    it "doesn't destroy entries if feed is curated" do
      subject.curated = true;
      subject.destroy_entries_unless_curated
      expect(subject.entries.length).to eq(2)
    end
  end

end
