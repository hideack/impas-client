# -*- coding: utf-8 -*-
require 'spec_helper'
require 'webmock/rspec'

WebMock.allow_net_connect!
REGISTRATION_API_URL = /http:\/\/impas-hideack.sqale.jp\/api\/registration\/[a-z0-9\/]*/
RANKING_API_URL = /http:\/\/impas-hideack.sqale.jp\/api\/ranking\/[a-z0-9\/]*/

describe Impas::Client do
  before do
    stub_request(:post, REGISTRATION_API_URL).to_return({:body => ADD_URL_SUCCESS_RESPONSE, :status => 200})
    stub_request(:get,  RANKING_API_URL).to_return({:body => RANKING_URL_SUCCESS_RESPONSE, :status => 200})
    @client = Impas::Client.new()
  end

  describe 'URL registration API' do
    subject{ @client.add_url("4862f27c8b8a483f8bc74e5b8ed22211", "http://remp.jp") }
    it { should == true}
  end

  describe 'Ranking API' do
    subject{ @client.ranking("4862f27c8b8a483f8bc74e5b8ed22211", "tw").count() }
    it { should == 3}
  end
end

# --- Response samples ---
ADD_URL_SUCCESS_RESPONSE = <<-EOF
{
  "result":"ok",
  "explain":"",
  "description":{}
}
EOF

RANKING_URL_SUCCESS_RESPONSE = <<-EOF
{

    "result": "ok",
    "explain": "",
    "description": {
        "ranking": [
            {
                "callcount": 3,
                "fb": 0,
                "hatena": 110,
                "tw": 5019,
                "url": "http://www.youtube.com/watch?v=UGP_hoQpLZQ"
            },
            {
                "callcount": 1,
                "fb": 5222,
                "hatena": 18,
                "tw": 1885,
                "url": "http://www.youtube.com/watch?v=iyw6-KVmgow"
            },
            {
                "callcount": 1,
                "fb": 0,
                "hatena": 4,
                "tw": 525,
                "url": "http://www.youtube.com/watch?v=r9pqRJgc5Wg"
            }
        ]
    }
}
EOF

