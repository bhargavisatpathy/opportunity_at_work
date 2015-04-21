require 'rails_helper'

RSpec.feature "AdminLogins", type: :feature do
  describe("an admin can login") do
    let!(:admin) do
      User.create(email: 'admin@example.com', password: 'password')
    end

    it "visits login" do
      visit admin_login_path
      puts current_path

      save_and_open_page
      within('.login') do
        fill_in 'session[email]', with: admin.email
        fill_in 'session[password]', with: admin.password
      end
      click_link_or_button('Login')

      expect(current_path).to eq(admins_dashboard_index_path)
    end
  end
end
