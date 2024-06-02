# frozen_string_literal: true

require_relative "../../../../samples/cubes/game_objects/teapot"

include TestDriver

describe Cubes::Teapot do
  before do
    stub_const("ROOT", File.expand_path(File.join(__dir__, "..", "..", "..", "..", "samples", "cubes")))
  end

  describe "with an orthographic camera" do
    it "renders the teapot" do
      within_game_context(load_path: "./samples/cubes") do
        at(0) do
          Cubes::Teapot.new(Vector[100, 100], Vector[43, 68, 38], 500)
          Engine::GameObject.new(
            "light", pos: Vector[Engine.screen_width / 2, 500, 100], components: [
            Engine::Components::PointLight.new(
              range: 300,
              colour: Vector[0.5, 0.5, 0.5],
            )
          ])
          Engine::GameObject.new(
            "Camera", pos: Vector[Engine.screen_width / 2, Engine.screen_height / 2, 1000],
            components: [
              Engine::Components::OrthographicCamera.new(width: Engine.screen_width, height: Engine.screen_height, far: 2000)
            ]
          )
        end
        at(1) { check_screenshot(__dir__ + "/teapot_orthographic.png") }
        at(20) { Engine.stop_game }
      end
    end
  end

  describe "with a perspective camera" do
    it "renders the teapot" do
      within_game_context(load_path: "./samples/cubes") do
        at(0) do
          Cubes::Teapot.new(Vector[100, 100], Vector[43, 68, 38], 500)
          Engine::GameObject.new(
            "light", pos: Vector[Engine.screen_width / 2, 500, 100], components: [
            Engine::Components::PointLight.new(
              range: 300,
              colour: Vector[0.5, 0.5, 0.5],
            )
          ])
          Engine::GameObject.new(
            "Camera", pos: Vector[Engine.screen_width / 2, Engine.screen_height / 2, 1000],
            components: [
              Engine::Components::PerspectiveCamera.new(fov: 45.0, aspect: Engine.screen_width / Engine.screen_height, near: 0.1, far: 2000)
            ]
          )
        end
        at(1) { check_screenshot(__dir__ + "/teapot_perspective.png") }
        at(20) { Engine.stop_game }
      end
    end
  end
end
