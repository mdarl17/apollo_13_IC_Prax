require "rails_helper"

RSpec.describe  do 
  it "has a list of astronauts with their name, age, and job" do

    buzz = Astronaut.create!(name: "Buzz Armstrong", age: 37, job: "Navigator")
    neil = Astronaut.create!(name: "Neal Aldrin", age: 12, job: "Pilot")
    
    visit "/astronauts"

    expect(page).to have_content(buzz.name)
    expect(page).to have_content(buzz.age)
    expect(page).to have_content(buzz.job)
    
    expect(page).to have_content(neil.job)
    expect(page).to have_content(neil.job)
    expect(page).to have_content(neil.job)

    it "shows the average age of all astronauts" do

      buzz = Astronaut.create!(name: "Buzz Armstrong", age: 37, job: "Navigator")
      neil = Astronaut.create!(name: "Neal Aldrin", age: 12, job: "Pilot")

      visit "/astronauts"

      expect(page).to have_content("Average Age: 24.5")
    end
  end

end