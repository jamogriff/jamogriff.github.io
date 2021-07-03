RSpec.describe 'About Me section', type: :feature do

  it 'has a section for leisure and for tech' do
    visit '/blog'

    expect(page).to have_content "Tech"
    expect(page).to have_content "Leisure"
  end

end
