# frozen_string_literal: true

require_relative 'spec_helper'
require 'selenium-webdriver'
require 'rspec/expectations'

RSpec.describe "Google's Search Functionality" do
  before :all do
    Selenium::WebDriver::Chrome::Service.driver_path = '/usr/local/bin/chromedriver'
    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.timeouts.page_load = 10
  end

  before :each do
    @driver.get('https://www.google.com/')
    raise 'Unable to load Google.' unless @driver.title.include? 'Google'

    query = @driver.find_element :name, 'q'
    query.send_keys 'RTS Labs'
    query.submit
  end

  after :each do
    @driver.quit
  end

  it 'has first result of RTS Lab site' do
    @driver.find_element(:class, 'yuRUbf').find_element(:tag_name, 'a').click
    puts "current url: #{@driver.current_url}"
    expect(@driver.current_url).to match(/rtslabs/)
  end
end
