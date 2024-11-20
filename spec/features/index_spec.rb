RSpec.describe 'Index page' do

  it 'has links for all site pages' do
    visit "/"

    expect(page).to have_link "About"
    expect(page).to have_link "Coding & Design"
    expect(page).to have_link "Musings"
  end
end
