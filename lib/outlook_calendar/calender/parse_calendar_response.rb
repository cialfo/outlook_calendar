module OutlookCalendar
  class ParseCalendarResponse
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def call
      parse_response
    end

    private

    def parse_response
      attributes
    end

    def attributes
      {
        content: response['@odata.context'],
        calendars: calendars
      }
    end

    def values
      response['value']
    end

    def calendars
      calenders = []
      values.to_a.each do |value|
        calenders.push(calendar_attributes(value))
      end
      calenders
    end

    def calendar_attributes(value)
      {
        id: value['id'],
        url: value['@odata.id'],
        name: value['name'],
        change_key: value['changeKey'],
        color: value['color'],
        can_share: value['canShare'],
        can_view_private_items: value['canViewPrivateItems'],
        CanEdit: value['canEdit'],
        owner: owner(value['owner'])
      }
    end

    def owner(owner_value)
      return {} unless owner_value.present?
      { name: owner_value['name'], address: owner_value['address'] }
    end
  end
end