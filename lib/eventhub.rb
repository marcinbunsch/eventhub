require 'mechanize'
require 'hpricot'

class EventHub
  autoload :Event, 'eventhub/event'
  
  def initialize(username, password)
    @username, @password = username, password
    @authenticated = false
  end
  
  def authenticated?
    @authenticated 
  end
  
  def connection
    @connection ||= Mechanize.new
  end
  
  def login
    page = connection.get('https://github.com/login')
    
    dashboard = page.form_with(:action => '/session') do |f|
      f.login    = @username
      f.password = @password
    end.click_button
    @authenticated = true
  end
  
  def events(options = {})
    page = options[:page] || 1
    login unless authenticated?
    dashboard = connection.get(:url => "/dashboard/index/#{page}", :headers => { 'X-Requested-With' => 'XMLHttpRequest' })
    
    parsed = Hpricot(dashboard.body)
    parsed.search('div.alert').collect do |object|
      repo     = object.at('.body .title a:nth-child(4)')
      repo     = object.at('.body .title a:nth-child(3)') if !repo
      debugger if !repo
      Event.new(
        :kind     => (object.attributes['class'].split(' ') - ['alert']).first, 
        :user     => object.at('.body .title a:nth-child(1)').html, 
        :repo     => repo.html, 
        :time     => object.at('.body .title abbr').html, 
        :gravatar => object.at("//div[@class='gravatar']/img").attributes['src'], 
        :message  => (object.at('.commits') || object.at('.message')).html.strip
      )
    end
    
  end
    
end

