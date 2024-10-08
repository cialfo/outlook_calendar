module OutlookCalendar
  class CreateEvent
    attr_reader :token, :calendar_id, :params, :select

    def initialize(token, calendar_id, params, select = {})
      @token = token
      @calendar_id = calendar_id
      @params = params
      @select = select
    end

    def call
      create_event
    end

    private

    def create_event
      caller
    end

    def event_attributes
      CreateEventParams.new(params).call
    end

    def caller
      RestCaller.new('post', url, headers, event_attributes.to_json).call
    end

    def headers
      {
        'Authorization' => "Bearer #{token}",
        'content-type' => 'application/json'
      }
    end

    def calendar?
      calendar_id.present?
    end

    def url
      return create_calendar_event_url if calendar?
      create_event_url
    end

    def select_params?
      select.present?
    end

    def create_calendar_event_url
      "#{base_url}/me/calendars/#{calendar_id}/events?#{select_attributes}" if select_params?
      "#{base_url}/me/calendars/#{calendar_id}/events?"
    end

    def create_event_url
      "#{base_url}/me/events?#{select_attributes}" if select_params?
      "#{base_url}/me/events?"
    end

    def select_attributes
      "?$Select=#{select}"
    end

    def base_url
      @base_url ||= Constants::Api::BASE_URL
    end
  end
end

