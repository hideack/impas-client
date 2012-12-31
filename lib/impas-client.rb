require "impas-client/version"
require 'faraday'

module Impas
  class Client
    attr_accessor :api_url, :op_key

    def initialize(args)
      @api_url  = (args[:api_url].nil?) ? API_URL : args[:api_url]
      @op_key   = args[:op_key]

      @@conn = Faraday.new(:url => @api_url) do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end

    def add_group(group_name)
      entry_point = "/api/group/#{@op_key}"

      @@conn.post do |req|
        req.url entry_point
        req.headers['Content-Type'] = 'application/json'
        req.body = "{\"name\":\"#{group_name}\"}"
      end
    end

    def groups
      entry_point = "/api/group/#{@op_key}"
      @@conn.get entry_point
    end

    def add_url(grp_key, url)
      entry_point = "/api/registration/#{grp_key}"

      @@conn.post do |req|
        req.url entry_point
        req.headers['Content-Type'] = 'application/json'
        req.body = "{\"url\":\"#{url}\"}"
      end
    end

  end
end
