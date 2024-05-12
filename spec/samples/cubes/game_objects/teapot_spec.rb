# frozen_string_literal: true

require_relative "../../../../samples/cubes/game_objects/teapot"

include TestDriver

describe Cubes::Teapot do
  before do
    stub_const("ASSETS_DIR", File.expand_path(File.join(__dir__, "..", "..", "..", "..", "samples", "cubes", "assets")))
  end

  describe "When placed in the scene" do
    it "renders the teapot" do
      within_game_context(load_path: "./samples/cubes") do
        at(0) do
          Cubes::Teapot.new(Vector[100, 100], Vector[43, 68, 38], 500)
          Engine::GameObject.new(
            "light", pos: Vector[Engine.screen_width / 2, 500, 100], components: [
            Engine::Components::PointLight.new(
              range: 300,
              ambient: Vector[0.5, 0.5, 0.5],
              diffuse: Vector[1, 1, 1],
              specular: Vector[1, 1, 1]
            )
          ])
          Engine::GameObject.new(
            "Camera", pos: Vector[Engine.screen_width / 2, Engine.screen_height / 2, 1000],
            components: [
              Engine::Components::OrthographicCamera.new(width: Engine.screen_width, height: Engine.screen_height, far: 2000)
            ]
          )
        end
        at(1) { check_screenshot(__dir__ + "/teapot.png") }
        at(20) { Engine.stop_game }
      end
    end
  end
end
