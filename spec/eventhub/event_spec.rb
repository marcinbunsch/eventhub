require 'spec_helper'

describe EventHub::Event do
  
  before do
    @event = EventHub::Event.new(:user => 'username', :repo => 'owner/repo', :kind => 'comment')
  end
  
  it "should initialize from a Hash" do
    @event.user.should == 'username'
    @event.repo.should == 'owner/repo'
    @event.kind.should == 'comment'
  end
  
  it "should have a uuid" do
    @event.uuid.should_not be_nil
    @event2 = EventHub::Event.new(:user => 'username', :repo => 'owner/repo', :kind => 'comment')
    @event.uuid.should == @event2.uuid
    @event3 = EventHub::Event.new(:user => 'otheruser', :repo => 'owner/repo', :kind => 'comment')
    @event.uuid.should_not == @event3.uuid
  end
    

end