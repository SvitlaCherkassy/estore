require "selenium-webdriver"
require "rspec"
require "spec_helper"
include RSpec::Expectations

describe "UpdateProfile" do
  let(:user) { FactoryGirl.create(:user) }  
  let(:product) { FactoryGirl.create(:product) }
  let!(:showroom) { FactoryGirl.create(:showroom, :user => user, :products => [product]) }
  let(:current_showroom) { user.current_showroom }

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
  
  it "test_update_profile" do
    @driver.get(@base_url + "/")
    @driver.find_element(:name, "user[email]").clear
    @driver.find_element(:name, "user[email]").send_keys user.email
    @driver.find_element(:name, "user[password]").clear
    @driver.find_element(:name, "user[password]").send_keys user.password
    @driver.find_element(:name, "commit").click
    @driver.find_element(:link, user.full_name).click
    verify { (@driver.find_element(:id, "user_email").attribute("value")).should == user.email }
    verify { (@driver.find_element(:id, "user_first_name").attribute("value")).should == user.first_name }
    verify { (@driver.find_element(:id, "user_last_name").attribute("value")).should == user.last_name }
    @driver.find_element(:name, "user[password]").clear
    @driver.find_element(:name, "user[password]").send_keys user.password
    @driver.find_element(:name, "user[password_confirmation]").clear
    @driver.find_element(:name, "user[password_confirmation]").send_keys user.password_confirmation
    @driver.find_element(:name, "user[current_password]").clear
    @driver.find_element(:name, "user[current_password]").send_keys user.password
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
