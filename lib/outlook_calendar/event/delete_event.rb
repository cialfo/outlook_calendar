module OutlookCalendar
  class DeleteEvent
    attr_reader :token, :event_id

    def initialize(token, event_id)
      @token = token
      @event_id = event_id
    end

    def call
      delete_event
    end

    private

    def delete_event
      caller
    end

    def caller
      RestCaller.new('delete', url, headers).call
    end

    def headers
      { 'Authorization' => "Bearer #{token}" }
    end

    def url
      "#{Constants::Api::BASE_URL}/me/events/#{event_id}"
    end
  end
end