require 'rails_helper'

RSpec.describe 'application', type: :feature do

  it 'displays a link to all pets' do
    visit '/'
    expect(page).to have_content("Adopt, don't shop!")
    expect(page).to have_link("Pets")
    click_link("Pets")
    expect(page).to have_current_path('/pets')
  end

  it 'displays a link to all shelters' do
    visit '/'

    expect(page).to have_link("Shelters")
    click_link("Shelters")
    expect(page).to have_current_path('/shelters')
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it 'displays a link to all veterinary offices' do
    visit '/'

    expect(page).to have_link("Veterinary Offices")
    click_link("Veterinary Offices")
    expect(page).to have_current_path('/veterinary_offices')
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it 'displays a link to all veterinarians' do
    visit '/'

    expect(page).to have_link("Veterinarians")
    click_link("Veterinarians")
    expect(page).to have_current_path('/veterinarians')
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  describe "application index page" do
    before :each do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
      @pet_2 = @shelter.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
      @bob = @pet_1.applications.create!(name: "Bob Ross", street_address: "123 Trees St.", city: "Nantuket", state: "MA", zip: "12554")
      ApplicationPet.create!(pet: @pet_1, application: @bob)
      # @bob.pets << @pet_1
    end

    it "index" do
      visit '/applications'

      expect(page).to have_content("Bob Ross")
    end
  end
end
