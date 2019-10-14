require 'rails_helper'

describe 'System' do 
    context "should" do
        scenario "always display BoozeItUp in title" do
            visit '/'
            expect(page).to have_title('BoozeItUp')
        end
    end
end
