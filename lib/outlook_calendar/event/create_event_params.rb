module OutlookCalendar
  class CreateEventParams
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      event_attributes
    end

    private

    def event_attributes
      {
        subject: params[:title],
        body: {
          contentType: params[:content_type],
          content: params[:content]
        },
        start: {
          dateTime: params[:start_time],
          timeZone: timezone
        },
        end: {
          dateTime: params[:end_time],
          timeZone: timezone
        },
        attendees: attendees
      }
    end

    def timezone
      return '' unless params[:content_type].present?
      params[:timezone]
    end

    def content_type
      return 'HTML' unless params[:content_type].present?
      params[:content_type]
    end

    def content
      return '' unless params[:content].present?
      params[:content]
    end

    def type
      return 'required' unless params[:type].present?
      params[:type]
    end

    def attendees
      return [] unless params[:attendees].present?
      attendees = []
      params[:attendees].each do |attendee|
        attendees.push(attendees_attributes(attendee))
      end
    end

    def attendees_attributes(attendee)
      {
        emailAddress: {
          address: attendee[:email],
          name: attendee[:name]
        },
        type: 'required'
      }
    end
  end
end


