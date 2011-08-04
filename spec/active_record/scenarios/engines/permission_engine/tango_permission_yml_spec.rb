require 'active_record/spec_helper'
require_all File.dirname(__FILE__) + "/../../shared/" 

describe 'Cantango config: tango_permissions.yml' do
  
  before(:each) {
    CanTango.configure do |config|
      config.permit_engine :off
      config.config_path = File.dirname(__FILE__)
      config.permission_engine :on
    end
    @user ||= User.create!(:email => "kris@gmail.com", :role => 'musician')
  }

  after(:each) { 
    CanTango.configure do |config|
      config.permit_engine :on
      config.permission_engine :off
    end
  }

  let(:current_user) { @user }
  let(:ability) { current_ability(:user) }
  let(:own_comment) { Comment.create(:user_id => @user.id) }
  let(:specific_post) { Post.create(:body => "Nice!") }

  context ":users group testing" do
    it "should be allowed to read Comment" do
      ability.should be_allowed_to(:read, Comment)
    end
  
    it "should be allowed to write own Comment" do
      ability.should be_allowed_to(:write, own_comment)
    end
    
    it "should be not be allowed to write not-own Comment" do
      ability.should_not be_allowed_to(:write, Comment.new)
    end

    it "should be allowed to write Post with :body => 'Nice!'" do
      ability.should be_allowed_to(:write, specific_post)
    end

    it "should not be allowed to write Post except specific_post" do
      ability.should_not be_allowed_to(:write, Post.new)
    end

  end

  context "various musical rules to ensure that all rules are evaluated" do
    it "should contain rules for musician role" do
      ability.should be_allowed_to(:read, Song)
      ability.should be_allowed_to(:read, Concerto)
      ability.should be_allowed_to(:create, Tune)
      ability.should be_allowed_to(:write, Song)
      ability.should be_allowed_to(:manage, Improvisation)
      ability.should_not be_allowed_to(:write, Concerto)
    end
  end

end

CanTango::Configuration.permission_engine :off
CanTango::Configuration.permit_engine :on