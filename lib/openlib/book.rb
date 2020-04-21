require 'json'

module Openlib
  class Book    
    def initialize(id, id_kind: :isbn, user_agent: nil)
      @id = id
      @id_kind= id_kind.to_sym
      @client = Openlib::Client.new(user_agent: user_agent)
      @view = nil
      @data = nil
    end

    ##
    # Check that we got back the expected data
    def view
      @view ||= @client.get(id: @id, id_kind: @id_kind, format: 'viewapi')
    end

    def data
      @data ||= @client.get(id: @id, id_kind: @id_kind, format: 'data')
    end

    def view_data(req: )
      view.first.last.dig(req.to_s)
    end

    def data_data(req:)
      case req
      when :authors, :publishers, :subjects then data.first.last.dig(req.to_s).map {|p| p.dig('name') }
      else
        data.first.last.dig(req.to_s)
      end
    end
    
    def author
      authors
    end

    def method_missing(m, *args, &block)      
      case m
      when :info_url, :preview, :preview_url, :thumbnail_url 
        then self.send('view_data', req: m)
      when :url, :authors, :identifiers, :classifications, :subjects,
        :subject_places, :subject_people, :subject_times, :publishers,
        :publish_places, :publish_date, :excerpts, :links, :cover, :ebooks,
        :number_of_pages, :weight, :title
        then self.send('data_data', req: m)
      else
        super
      end
    end
 
  end
end