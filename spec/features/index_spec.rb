RSpec.describe 'Index page' do

  it 'has links for all site pages' do
    visit "/"

    expect(page).to have_link "API Docs"
    expect(page).to have_link "Worklog"
    expect(page).to have_link "Programming"
    expect(page).to have_link "Musings"
  end
end
