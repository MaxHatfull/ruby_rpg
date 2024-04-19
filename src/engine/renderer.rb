module Engine
  class Renderer
    def self.draw_circle(x, y, radius, r: 1, g: 1, b: 1)
      GL.Begin(GL::TRIANGLE_FAN)
      GL.Color3f(r, g, b)
      GL.Vertex2f(x, y)
      0.step(to: 360, by: 30) do |i|
        angle = i * Math::PI / 180
        GL.Vertex2f(x + Math.cos(angle) * radius, y + Math.sin(angle) * radius)
      end
      GL.End()
    end
  end
end