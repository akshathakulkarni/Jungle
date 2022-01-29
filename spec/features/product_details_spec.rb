require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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
  scenario "They see the product details when clicked on product" do
    # ACT
    visit root_path
    find_link('Details', match: :first).click
    # DEBUG / VERIFY
    puts page.html
    save_screenshot
    expect(page).to have_css 'section.products-show'
  end
end
