# frozen_string_literal: true

module Openlib
  require 'open-uri'
  USER_AGENT = "Ruby OpenLib/#{Openlib::VERSION}"

  class Client
    def initialize(user_agent: nil)
      @user_agent = user_agent || USER_AGENT
    end

    def get(id:, format: 'data', id_kind: :isbn)
      raise ArgumetError, "Kind must be one of #{ID_KINDS}"       unless ID_KINDS.include?(id_kind)
      
      resp = URI.open( "https://openlibrary.org/api/books?jscmd=#{format}&format=json&bibkeys=#{id_kind.to_s.upcase}#{id}", 'User-Agent' => @user_agent )
      
      byebug unless resp.status.first == '200'
      
      JSON.parse(resp.read)
    end

  end
end
