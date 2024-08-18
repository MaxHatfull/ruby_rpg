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

    def self.create_gallery
      1.upto(302) do |i|
        RoadTile.create("%03d" % i, Vector[i * 5, 0, 0], Vector[0, 0, 0])
        Text.create(Vector[i * 5 + 1.5, -1, 0], Vector[0, 0, 0], 1, "%03d" % i)
      end
    end
  end
end
