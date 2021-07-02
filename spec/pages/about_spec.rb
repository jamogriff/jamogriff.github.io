RSpec.describe 'About Me section', type: feature do

  it 'has image of myself' do
    visit "/about"

    find(:image, "about/profile-pic.jpg")
  end

end
