require "impas-client/version"
require 'faraday'
require 'json'

module Impas
  class Client
    attr_accessor :api_url, :op_key

    def initialize(args ={})
      @api_url  = (args[:api_url].nil?) ? API_URL : args[:api_url]
      @op_key   = args[:op_key]

      @@conn = Faraday.new(:url => @api_url) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end

    end

    def add_group(group_name)
      entry_point = "/api/group/#{@op_key}"

      res = @@conn.post do |req|
        req.url entry_point
        req.headers['Content-Type'] = 'application/json'
        req.body = "{\"name\":\"#{group_name}\"}"
      end

      if res.status == 200
        desc = JSON.parse(res.body)

        if desc["result"] != "ok"
          raise StandardError.new("Process error. message:#{desc['explain']}")
        end
      else
        raise StandardError.new("HTTP status:#{res.status}")
      end

      true
    end

    def delete_group(grp_key)
      entry_point = "/api/group/#{@op_key}/#{grp_key}"
      res = @@conn.delete entry_point

      if res.status != 200
        raise StandardError.new("HTTP status:#{res.status}")
      end

      true
    end

    def groups
      entry_point = "/api/group/#{@op_key}"
      res = @@conn.get entry_point

      if res.status != 200
        raise StandardError.new("HTTP status:#{res.status}")
      end

      desc = JSON.parse(res.body)
      desc["description"]["groups"]
    end

    def add_url(grp_key, url, user = nil)
      entry_point = "/api/registration/#{grp_key}"

      res = @@conn.post do |req|
        req.url entry_point
        req.headers['Content-Type'] = 'application/json'

        if user.nil?
          req.body = "{\"url\":\"#{url}\"}"
        else
          req.body = "{\"url\":\"#{url}\", \"user\":\"#{user}\"}"
        end

      end

      if res.status == 200
        desc = JSON.parse(res.body)

        if desc["result"] != "ok"
          raise StandardError.new("Process error. message:#{desc['explain']}")
        end
      else
        raise StandardError.new("HTTP status:#{res.status}")
      end

      true
    end

    def ranking(grp_key, type = "all", limit = 10)
      entry_point = "/api/ranking/#{grp_key}/#{type}/#{limit}"
      res = @@conn.get entry_point

      if res.status != 200
        raise StandardError.new("HTTP status:#{res.status}")
      end

      desc = JSON.parse(res.body)
      desc["description"]["ranking"]
    end

    def recommend(grp_key, visitor, limit=10)
      entry_point = "/api/recommend/#{grp_key}/#{visitor}/#{limit}"
      res = @@conn.get entry_point

      if res.status == 200
        desc = JSON.parse(res.body)

        if desc["result"] != "ok"
          raise StandardError.new("Process error. message:#{desc['explain']}")
        end
      else
        raise StandardError.new("HTTP status:#{res.status}")
      end

      desc = JSON.parse(res.body)
      desc["description"]["recommends"]
    end
  end
end
