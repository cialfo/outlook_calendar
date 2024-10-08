module OutlookCalendar
  class UserEvents
    attr_reader :token, :params, :calendar_id

    def initialize(token, params, calendar_id = nil)
      @token = token
      @params = params
      @calendar_id = calendar_id
    end

    def call
      events
    end

    private

    def events
      ParseEventResponse.new(caller).call
    end


    def caller
      RestCaller.new('get', url, headers).call
    end

    def headers
      {
        'Authorization' => "Bearer #{token}",
        'Content-Type' => 'application/json'
      }
    end

    def url
      return "#{Constants::Api::BASE_URL}/me/calendars/#{calendar_id}/calendarview?#{params}" if calendar_id.present?
      "#{Constants::Api::BASE_URL}/me/calendarview?#{params}"
    end
  end
end