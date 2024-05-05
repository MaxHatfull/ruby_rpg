# frozen_string_literal: true

module Engine
  class Camera
    attr_reader :pos, :front, :up, :right

    def initialize(pos:, front:, up:, right:)
      @pos = pos
      @front = front
      @up = up
      @right = right
    end

    def pos=(new_pos)
      @pos = new_pos
    end

    def self.instance
      @instance ||= new(
        pos: Vector[Engine.screen_width / 2.0, Engine.screen_height / 2.0, 1000.0],
        front: Vector[0, 0, 0.001],
        up: Vector[0, 2.0 / Engine.screen_height, 0],
        right: Vector[2.0 / Engine.screen_width, 0, 0],
      )
    end

    def matrix
      Matrix[
        [right[0], up[0], -front[0], 0],
        [right[1], up[1], -front[1], 0],
        [right[2], up[2], -front[2], 0],
        [-pos.dot(right), -pos.dot(up), pos.dot(front), 1]
      ]
    end
  end
end