require 'helper'

describe Desk do
  after do
    Desk.reset
  end

  # context "when delegating to a client" do
  #
  #   before do
  #     stub_get("statuses/user_timeline.json").
  #       with(:query => {:screen_name => "sferik"}).
  #       to_return(:body => fixture("statuses.json"), :headers => {:content_type => "application/json; charset=utf-8"})
  #   end
  #
  #   it "should get the correct resource" do
  #     Twitter.user_timeline('sferik')
  #     a_get("statuses/user_timeline.json").
  #       with(:query => {:screen_name => "sferik"}).
  #       should have_been_made
  #   end
  #
  #   it "should return the same results as a client" do
  #     Desk.user_timeline('sferik').should == Twitter::Client.new.user_timeline('sferik')
  #   end
  #
  # end

  describe ".client" do
    it "should be an Desk::Client" do
      Desk.client.should be_a Desk::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Desk.adapter.should == Desk::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Desk.adapter = :typhoeus
      Desk.adapter.should == :typhoeus
    end
  end

  describe ".subdomain=" do
    before do
      Desk.subdomain = "zencoder"
    end

    it "should set the subdomain" do
      Desk.subdomain.should == "zencoder"
    end

    it "should change the endpoint" do
      Desk.endpoint.should == "https://zencoder.desk.com/api/#{Desk::Configuration::DEFAULT_VERSION}/"
    end
  end

  describe ".support_email" do
    it "should return the default support_email" do
      Desk.support_email.should == Desk::Configuration::DEFAULT_SUPPORT_EMAIL
    end
  end

  describe ".support_email=" do
    it "should set the support_email" do
      Desk.support_email = "help@example.com"
      Desk.support_email.should == "help@example.com"
    end
  end

  describe ".version=" do
    before do
      Desk.version = "v4"
    end

    it "should set the subdomain" do
      Desk.version.should == "v4"
    end

    it "should change the endpoint" do
      Desk.endpoint.should == "https://#{Desk::Configuration::DEFAULT_SUBDOMAIN}.desk.com/api/v4/"
    end
  end

  describe ".format" do
    it "should return the default format" do
      Desk.format.should == Desk::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      Desk.format = 'xml'
      Desk.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Desk.user_agent.should == Desk::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Desk.user_agent = 'Custom User Agent'
      Desk.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    Desk::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Desk.configure do |config|
          config.send("#{key}=", key)
          Desk.send(key).should == key
        end
      end
    end
  end
end
