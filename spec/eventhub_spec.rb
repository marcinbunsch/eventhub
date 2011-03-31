require 'spec_helper'

describe EventHub do
  
  describe 'initialization' do
    
    it "should start unauthenticated" do
      hub = EventHub.new('user', 'pass')
      hub.authenticated?.should be_false
    end
    
  end
  
end