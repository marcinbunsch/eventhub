require 'digest/sha1'

class EventHub::Event
  
  attr_accessor :uuid, :kind, :user, :repo, :time, :gravatar, :message
  def initialize(attributes = {})
    [:kind, :user, :repo, :time, :gravatar, :message].each do |attribute|
      self.send("#{attribute}=", attributes[attribute])
    end
    self.uuid = Digest::SHA1.hexdigest("#{kind}-#{user}-#{repo}-#{time}")
  end

end