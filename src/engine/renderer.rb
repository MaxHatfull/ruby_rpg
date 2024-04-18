module Engine
  class Renderer
    def self.draw_triangle(v1, c1, v2, c2, v3, c3)
      GL.Begin(GL::TRIANGLES)
      GL.Color3f(c1[:r], c1[:g], c1[:b])
      GL.Vertex3f(v1[:x], v1[:y], v1[:z] || 0.0)
      GL.Color3f(c2[:r], c2[:g], c2[:b])
      GL.Vertex3f(v2[:x], v2[:y], v2[:z] || 0.0)
      GL.Color3f(c3[:r], c3[:g], c3[:b])
      GL.Vertex3f(v3[:x], v3[:y], v3[:z] || 0.0)
      GL.End()
    end

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