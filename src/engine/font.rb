# frozen_string_literal: true

module Engine
  class Font
    TEXTURE_SIZE = 1024
    GLYPH_COUNT = 16
    CELL_SIZE = TEXTURE_SIZE / GLYPH_COUNT

    def initialize(font_file_path)
      @font_file_path = font_file_path
    end

    def texture
      @texture ||= generate_texture
    end

    private

    def generate_texture
      path = File.expand_path(@font_file_path).gsub(/\.ttf$/, ".png")
      return Engine::Texture.new(path) if File.exist?(path)

      image = Magick::Image.new(TEXTURE_SIZE, TEXTURE_SIZE,) do |options|
        options.background_color = "transparent"
      end

      draw = Magick::Draw.new
      (0..GLYPH_COUNT).each do |x|
        (0..GLYPH_COUNT).each do |y|
          index = x * GLYPH_COUNT + y
          next if index >= 255
          character = character(index)
          write_character(character, draw, image, coord(x), coord(y))
        end
      end

      image.write(path)
      Engine::Texture.new(path)
    end

    def write_character(character, draw, image, x, y)
      font_path = File.expand_path(@font_file_path)

      draw.annotate(image, 0, 0, x, y, character) do
        draw.gravity = Magick::CenterGravity
        draw.pointsize = CELL_SIZE
        draw.font = font_path
        draw.fill = "white"
        image.format = "PNG"
      end
    end

    def character(index)
      (index + 1).chr
    end

    def coord(x)
      start_x = x * CELL_SIZE - TEXTURE_SIZE / 2
      end_x = start_x + CELL_SIZE
      (start_x + end_x) / 2
    end
  end
end