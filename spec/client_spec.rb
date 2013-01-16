# -*- coding: utf-8 -*-
require 'spec_helper'
require 'webmock/rspec'

WebMock.allow_net_connect!
EXAMPLE_API_URL = /http:\/\/impas-hideack.sqale.jp\/api\/[a-z]+\/[0-9a-z]+/

describe Impas::Client do
  before do
    stub_request(:post, EXAMPLE_API_URL).to_return({:body => ADD_URL_SUCCESS_RESPONSE, :status => 200})
    @client = Impas::Client.new()
  end

  describe 'API call' do
    subject{ @client.add_url("4862f27c8b8a483f8bc74e5b8ed22211", "http://remp.jp") }
    it { should == true}
  end
end

#Successful case 
ADD_URL_SUCCESS_RESPONSE = <<-EOF
{
  "result":"ok",
  "explain":"",
  "description":{}
}
EOF

