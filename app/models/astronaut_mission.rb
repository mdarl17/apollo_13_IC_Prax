class AstronautMission < ApplicationRecord
  has_many :missions
  has_many :astronauts
end
