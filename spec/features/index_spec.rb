RSpec.describe 'Index page', type: :feature do

  it 'has links for all site pages' do
    visit "/"

    expect(page).to have_link "Blog"
    expect(page).to have_link "Worklog"
  end

  it 'links to blog page' do
    visit "/"
    within "nav#sidebar-nav-links" do
      click_link "Blog"
    end
    expect(current_path).to eq "/blog"
  end

  it 'links to worklog page' do
    visit "/"
    within "nav#sidebar-nav-links" do
      click_link "worklog"
    end
    expect(current_path).to eq "/worklog"
  end
end
