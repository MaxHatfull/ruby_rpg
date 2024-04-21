require 'chunky_png'

module Engine
  class Texture
    attr_reader :texture

    def initialize(file_path)
      @file_path = file_path
      @texture = ' ' * 4
      load_texture
    end

    def load_texture
      tex = ' ' * 4
      GL.GenTextures(1, tex)
      @texture = tex.unpack('L')[0]
      GL.BindTexture(GL::TEXTURE_2D, @texture)
      GL.TexParameteri(GL::TEXTURE_2D, GL::TEXTURE_WRAP_S, GL::REPEAT)
      GL.TexParameteri(GL::TEXTURE_2D, GL::TEXTURE_WRAP_T, GL::REPEAT)
      GL.TexParameteri(GL::TEXTURE_2D, GL::TEXTURE_MIN_FILTER, GL::LINEAR)
      GL.TexParameteri(GL::TEXTURE_2D, GL::TEXTURE_MAG_FILTER, GL::LINEAR)

      image = read_image
      image_data = image.to_rgba_stream
      image_width = image.width
      image_height = image.height

      GL.TexImage2D(GL::TEXTURE_2D, 0, GL::RGBA, image_width, image_height, 0, GL::RGBA, GL::UNSIGNED_BYTE, image_data)
      GL.GenerateMipmap(GL::TEXTURE_2D)
    end

    def read_image
      image = ChunkyPNG::Image.from_file(@file_path)
      image.flip_vertically!
      image
    end
  end
end