# frozen_string_literal: true

module Openlib
  require 'open-uri'
  USER_AGENT = "Ruby OpenLib/#{Openlib::VERSION}"

  class Client
    def initialize(user_agent: nil)
      @user_agent = user_agent || USER_AGENT
    end

    def get(id:, format: 'data', id_kind: :isbn)
      unless ID_KINDS.include?(id_kind)
        raise ArgumetError, "Kind must be one of #{ID_KINDS}"
      end

      url = "https://openlibrary.org/api/books?jscmd=#{format}&format=json&bibkeys=#{id_kind.to_s.upcase}:#{id}"

      resp = URI.open(url, 'User-Agent' => @user_agent)

      puts resp.status.first.to_s unless resp.status.first == '200'

      JSON.parse(resp.read)
    end
  end
end
