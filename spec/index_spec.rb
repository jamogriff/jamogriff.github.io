RSpec.describe 'home page' do

  it 'has links in masthead for site pages' do
    visit "/"

    expect(page).to have_link "About"
  end
end
