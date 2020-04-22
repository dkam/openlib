# frozen_string_literal: true

require 'json'

module Openlib
  class Book
    attr_writer :view, :data
    def initialize(id:, id_kind: :isbn, user_agent: nil)
      @id = id
      @id_kind = id_kind.to_sym
      @client = Openlib::Client.new(user_agent: user_agent)
      @view = nil
      @data = nil
    end

    def cache_clear
      @view = @data = nil
    end

    ##
    # Check that we got back the expected data
    def view
      @view ||= @client.get(id: @id, id_kind: @id_kind, format: 'viewapi')
    end

    def data
      @data ||= @client.get(id: @id, id_kind: @id_kind, format: 'data')
    end

    def web
      @web ||= @client.get(id: @id, id_kind: @id_kind, format: 'data')
    end

    def view_data(req:)
      view.first.last.dig(req.to_s)
    end

    def data_data(req:)
      case req
      when :authors, :publishers, :subjects then data.dig(req.to_s).map { |p| p.dig('name') }
      else
        data.dig(req.to_s)
      end
    end

    def author
      authors
    end

    def to_h
      return {} if data.empty?

      %i[url authors identifiers classifications subjects
         subject_places subject_people subject_times publishers
         publish_places publish_date excerpts links cover ebooks
         number_of_pages weight title].each_with_object({}) do |obj, memo|
        memo[obj] = send(obj) unless send(obj).nil?
        memo
      end
    end

    def method_missing(m, *args, &block)
      case m
      when :info_url, :preview, :preview_url, :thumbnail_url
        send('view_data', req: m)
      when :url, :authors, :identifiers, :classifications, :subjects,
        :subject_places, :subject_people, :subject_times, :publishers,
        :publish_places, :publish_date, :excerpts, :links, :cover, :ebooks,
        :number_of_pages, :weight, :title
        send('data_data', req: m)
      else
        super
      end
    end
  end
end
