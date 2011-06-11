require 'spec_helper'

describe EventHub do

  before do
    @connection = YAML.load_file('spec/connection.yml')
    @hub = EventHub.new(@connection['username'], @connection['password'])
  end

  it "should start unauthenticated" do
    @hub.authenticated?.should be_false
  end

  it "should login to github" do
    VCR.use_cassette('github', :record => :new_episodes) do
      @hub.login
    end
    @hub.authenticated?.should be_true
  end

  it "should download first page" do
    events = nil
    VCR.use_cassette('github', :record => :new_episodes) do
      events = @hub.events
    end
    @hub.authenticated?.should be_true
    events.first.time.zone.should == 'UTC'
    events.size.should_not == 0
    events.first.class.should == EventHub::Event
  end

  it "should download futher pages" do
    events = nil
    VCR.use_cassette('github', :record => :new_episodes) do
      events = @hub.events(:page => 2)
    end
    @hub.authenticated?.should be_true
    events.first.time.zone.should == 'UTC'
    events.size.should_not == 0
    events.first.class.should == EventHub::Event
  end

end