# frozen_string_literal: true

module ShrinkRacer
  module RoadTrack

    CELL_SIZE = 3

    def self.create
      30.times do |i|
        RoadTile.create_straight_road(Vector[0, 0, -i * CELL_SIZE], Vector[0, 90, 0])
      end
      RoadTile.create_corner_road(Vector[0, 0, -30 * CELL_SIZE], Vector[0, 90, 0])
      30.times do |i|
        RoadTile.create_straight_road(Vector[(i + 1) * CELL_SIZE, 0, -29 * CELL_SIZE], Vector[0, 0, 0])
      end
    end
  end
end
