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
  end

  it "shows the average age of all astronauts" do

    buzz = Astronaut.create!(name: "Buzz Armstrong", age: 37, job: "Navigator")
    neil = Astronaut.create!(name: "Neal Aldrin", age: 12, job: "Pilot")

    visit "/astronauts"
    expect(page).to have_content("Average Age: 24.5")
  end

  it "shows a list of missions for each astronaut" do
    buzz = Astronaut.create!(name: "Buzz Armstrong", age: 37, job: "Navigator")
    sally = Astronaut.create(name: "sally", age: 37, job: "navigator")
    neil = Astronaut.create!(name: "Neal Aldrin", age: 12, job: "Pilot")
    neil = Astronaut.create!(name: "Neal Aldrin", age: 12, job: "Pilot")
    apollo_13 = Mission.create(title: "Apollo 13", time_in_space: 654)
    gemini = Mission.create(title: "Gemini 7", time_in_space: 234)
    armageddon = Mission.create(title: "Armageddon", time_in_space: 2)

    AstronautMission.create(mission: armageddon, astronaut: buzz)
    AstronautMission.create(mission: armageddon, astronaut: neil)
    AstronautMission.create(mission: armageddon, astronaut: sally)

    buzz.missions.push(gemini)
    gemini.astronauts.push(sally)

    AstronautMission.create(mission: apollo_13, astronaut: buzz)
    AstronautMission.create(mission: apollo_13, astronaut: neil)

    visit "/astronauts"

    within("#astronaut-#{buzz.id}") do
      expect("Apollo 13").to appear_before("Armageddon")
      expect("Armageddon").to appear_before("Gemini 7")
    end

    within("#astronaut-#{neil.id}") do
      expect("Apollo 13").to appear_before("Armageddon")
    end
    
    within("#astronaut-#{sally.id}") do
      expect("Armageddon").to appear_before("Gemini 7")
      expect(page).to_not have_content("Apollo 13")
    end
  end

  it "shows a list of missions for each astronaut" do
    buzz = Astronaut.create!(name: "Buzz Armstrong", age: 37, job: "Navigator")
    sally = Astronaut.create(name: "sally", age: 37, job: "navigator")
    neil = Astronaut.create!(name: "Neal Aldrin", age: 12, job: "Pilot")
    neil = Astronaut.create!(name: "Neal Aldrin", age: 12, job: "Pilot")
    apollo_13 = Mission.create(title: "Apollo 13", time_in_space: 654)
    gemini = Mission.create(title: "Gemini 7", time_in_space: 234)
    armageddon = Mission.create(title: "Armageddon", time_in_space: 2)

    AstronautMission.create(mission: armageddon, astronaut: buzz)
    AstronautMission.create(mission: armageddon, astronaut: neil)
    AstronautMission.create(mission: armageddon, astronaut: sally)

    buzz.missions.push(gemini)
    gemini.astronauts.push(sally)

    AstronautMission.create(mission: apollo_13, astronaut: buzz)
    AstronautMission.create(mission: apollo_13, astronaut: neil)

    visit "/astronauts"

    within("#astronaut-#{buzz.id}") do
      expect(page).to have_content("Total Time in Space: 890 Days")
    end

    within("#astronaut-#{neil.id}") do
      expect(page).to have_content("Total Time in Space: 656 Days")
    end
    
    within("#astronaut-#{sally.id}") do
      expect(page).to have_content("Total Time in Space: 236 Days")
    end
  end

end