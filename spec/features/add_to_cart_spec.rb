require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "They can click the Add button for a product and see that My Cart increases by 1" do
    # ACT
    visit root_path
    find_button('Add', match: :first).click
    # DEBUG / VERIFY
    puts page.html
    # save_screenshot
    expect(page).to have_content('My Cart (1)')
  end
end
