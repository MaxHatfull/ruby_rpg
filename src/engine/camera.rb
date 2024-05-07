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
      @matrix = nil
    end

    def rotate(angle, axis)
      axis = axis.normalize
      theta = angle * Math::PI / 180
      rotation_matrix = Matrix[
        [Math.cos(theta) + axis[0] * axis[0] * (1 - Math.cos(theta)), axis[0] * axis[1] * (1 - Math.cos(theta)) - axis[2] * Math.sin(theta), axis[0] * axis[2] * (1 - Math.cos(theta)) + axis[1] * Math.sin(theta)],
        [axis[1] * axis[0] * (1 - Math.cos(theta)) + axis[2] * Math.sin(theta), Math.cos(theta) + axis[1] * axis[1] * (1 - Math.cos(theta)), axis[1] * axis[2] * (1 - Math.cos(theta)) - axis[0] * Math.sin(theta)],
        [axis[2] * axis[0] * (1 - Math.cos(theta)) - axis[1] * Math.sin(theta), axis[2] * axis[1] * (1 - Math.cos(theta)) + axis[0] * Math.sin(theta), Math.cos(theta) + axis[2] * axis[2] * (1 - Math.cos(theta))]
      ]
      @front = rotation_matrix * @front
      @right = rotation_matrix * @right
      @up = rotation_matrix * @up
      @matrix = nil
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
      @matrix ||=
        Matrix[
          [right[0], up[0], -front[0], 0],
          [right[1], up[1], -front[1], 0],
          [right[2], up[2], -front[2], 0],
          [-pos.dot(right), -pos.dot(up), pos.dot(front), 1]
        ]
    end
  end
end