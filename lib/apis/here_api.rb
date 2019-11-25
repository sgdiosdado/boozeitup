
module Apis
    class HereApi 
        include HTTParty
        base_uri "http://autocomplete.geocoder.api.here.com"

        def initialize(address)
            @options = { 
                query: {
                    app_id: Rails.application.credentials.here[:app_id], 
                    app_code: Rails.application.credentials.here[:app_code], 
                    query: address,
                    country: "MEX",
                    beginHighlight: "<b>",
                    endHighlight: "</b>"
                }   
            }
        end
        
        def get_suggestions
            self.class.get("/6.2/suggest.json", @options)
        end
    end
end