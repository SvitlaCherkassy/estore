require "selenium-webdriver"
require "rspec"
require "spec_helper"
include RSpec::Expectations

describe "SignInSelenium" do
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
  
  it "test_sign_in_selenium" do
    @driver.get(@base_url + "/")
    @driver.find_element(:id, "user_email").clear
    @driver.find_element(:id, "user_email").send_keys user.email
    @driver.find_element(:id, "user_password").clear
    @driver.find_element(:id, "user_password").send_keys user.password
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
