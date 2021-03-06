require 'rails_helper'

RSpec.feature "CompanyUserSignUp", type: :feature do
  describe("Company signup creates a user and a company") do
    let! (:state) { State.create(abbr: "CO", id: 14) }

    let! (:usa_city1) { UsaCity.create(name: "Denver", state_id: 14) }

    it "can signup" do
      allow(User).to receive(:generate_password).and_return("abc123abc")
      visit '/'
      click_link_or_button("Sign Up")
      expect(page).to have_content("Start hiring")

      fill_in 'company[name]', with: "Orion"
      fill_in 'company[organization]', with: "Google"
      fill_in 'company[title]', with: "Web Developer"
      select 'Denver', from: "company_city"
      select 'CO', from: "company_state"
      fill_in 'company[email]', with: "orion@google.com"
      click_link_or_button('Create techHire account')
      visit new_user_session_path
      fill_in 'user[email]', with: "orion@google.com"
      fill_in 'user[password]', with: "abc123abc"
      click_link_or_button('Log in')

      expect(current_path).to eq(company_path(Company.last.id))
    end
  end
end
