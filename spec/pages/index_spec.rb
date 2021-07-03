RSpec.describe 'Index page', type: feature do

  it 'has links for all site pages' do
    visit "/"

    expect(page).to have_link "Travel"
    expect(page).to have_link "About"
    expect(page).to have_link "Music"
    expect(page).to have_link "Projects"
  end

  it 'links to about page' do
    visit "/"
    click_link "About"
    expect(current_path).to eq "/about/"
  end

  it 'links to travel page' do
    visit "/"
    within "nav#sidebar-nav-links" do
      click_link "Travel"
    end
    expect(current_path).to eq "/travel/"
  end

  it 'links to music page' do
    visit "/"
    within "nav#sidebar-nav-links" do
      click_link "Music"
    end
    expect(current_path).to eq "/music/"
  end
  it 'links to projects page' do
    visit "/"
    click_link "Projects"
    expect(current_path).to eq "/projects/"
  end
end
