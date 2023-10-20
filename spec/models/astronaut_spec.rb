require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe "class methods" do 
    describe "sef#average_age" do 
      it "calculates average age of all astronauts" do 
        Astronaut.create!(name: "Buzz Armstrong", age: 345, job: "Navigator")
        Astronaut.create!(name: "Neal Aldrin", age: 34, job: "Pilot")
        Astronaut.create!(name: "Neal Aldrin", age: 37, job: "Pilot")

        expect(Astronaut.average_age).to eq(73.4)
      end
    end
  end
  describe "instance methods" do
    describe "#alpha_missions" do
      it 'alphabetizes missions' do
        buzz = Astronaut.create!(name: "Buzz Armstrong", age: 37, job: "Navigator")
        sally = Astronaut.create(name: "sally", age: 37, job: "navigator")
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

        expect(buzz.alpha_missions).to eq([apollo_13, armageddon, gemini])
        expect(neil.alpha_missions).to eq([apollo_13, armageddon])
        expect(sally.alpha_missions).to eq([armageddon, gemini])
      end
    end
    describe "#total_time_in_space" do 
      it 'gets the total time in space for each astronaut' do

        buzz = Astronaut.create!(name: "Buzz Armstrong", age: 37, job: "Navigator")
        sally = Astronaut.create(name: "sally", age: 37, job: "navigator")
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

        expect(buzz.total_time_in_space).to eq(890)
        expect(neil.total_time_in_space).to eq(656)
        expect(sally.total_time_in_space).to eq(236)
      end
    end
  end
end

