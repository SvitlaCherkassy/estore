require "selenium-webdriver"
require "rspec"
require "spec_helper"
include RSpec::Expectations

describe "SignUpSelenium" do
  let(:product) { FactoryGirl.create(:product) }
  let!(:showroom) { FactoryGirl.create(:showroom, :user => User.first, :products => [product]) }
  let(:current_showroom) { User.first.current_showroom }

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://localhost:3000/"
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end
  
  after(:each) do
    @driver.quit
    @verification_errors.should == []
  end
  
  it "test_sign_up_selenium" do
    @driver.get(@base_url + "/users/sign_up")
    @driver.find_element(:name, "user[email]").clear
    @driver.find_element(:name, "user[email]").send_keys "person1@example.com"
    @driver.find_element(:name, "user[first_name]").clear
    @driver.find_element(:name, "user[first_name]").send_keys "ruby"
    @driver.find_element(:name, "user[last_name]").clear
    @driver.find_element(:name, "user[last_name]").send_keys "rails"
    @driver.find_element(:name, "user[password]").clear
    @driver.find_element(:name, "user[password]").send_keys "password"
    @driver.find_element(:name, "user[password_confirmation]").clear
    @driver.find_element(:name, "user[password_confirmation]").send_keys "password"
    @driver.find_element(:name, "commit").click
  end
  
  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end
  
  def verify(&blk)
    yield
  rescue ExpectationNotMetError => ex
    @verification_errors << ex
  end
end
