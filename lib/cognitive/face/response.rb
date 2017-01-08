module Cognitive
  module Face
    class Response
      def initialize(http_response,json: true, response_custom: nil)
        @json = json
        @response_custom = response_custom
        @http_response = http_response
      end

      def get
        return @response_custom.call(@http_response) unless @response_custom.nil?
        if @json
          data = JSON.parse @http_response.body
          data.map! { |data|
            OpenStruct.new(data)
          } if data.kind_of?(Array)
          data = OpenStruct.new(data) if data.kind_of?(Hash)
          return data
        end
      end

    end
  end
end





