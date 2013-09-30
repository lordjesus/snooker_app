require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    
    it "should have the content 'Turneringer'" do
      visit '/static_pages/home'
      expect(page).to have_content('Turneringer')
    end
  end

  describe "Help page" do

  	it "should have the content 'Hjælp'" do
  		visit '/static_pages/help'
  		expect(page).to have_content('Hjælp')
  	end
  end

  describe "About page" do

  	it "should have the content 'Omkring'" do
  		visit '/static_pages/about'
  		expect(page).to have_content('Omkring')
  	end
  end
end
