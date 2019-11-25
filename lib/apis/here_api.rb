
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
        def get_location_details(location_id)
            @options = { 
                query: {
                    app_id: Rails.application.credentials.here[:app_id], 
                    app_code: Rails.application.credentials.here[:app_code], 
                    locationid: location_id,
                    gen: 9,
                    jsonattributes: 1,
                }   
            }
            self.class.get("http://geocoder.api.here.com/6.2/geocode.json", @options)
        end
    end
end