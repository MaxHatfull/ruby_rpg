# frozen_string_literal: true

module Engine
  class FontImporter
    TEXTURE_SIZE = 1024
    GLYPH_COUNT = 16
    CELL_SIZE = TEXTURE_SIZE / GLYPH_COUNT

    attr_reader :source, :destination

    def initialize(source, destination)
      @source = source
      @destination = destination
    end

    def import
      image = Magick::Image.new(TEXTURE_SIZE, TEXTURE_SIZE,) do |options|
        options.background_color = "transparent"
      end

      draw = Magick::Draw.new
      (0...GLYPH_COUNT).each do |x|
        (0...GLYPH_COUNT).each do |y|
          index = x * GLYPH_COUNT + y
          next if index >= 255
          character = character(index)
          write_character(character, draw, image, coord(x), coord(y))
        end
      end

      FileUtils.mkdir_p(File.dirname(destination)) unless File.directory?(File.dirname(destination))
      image.write(destination)
    end

    private

    def write_character(character, draw, image, x, y)
      font_path = File.expand_path(source)

      draw.annotate(image, CELL_SIZE, CELL_SIZE, x, y, character) do |_|
        draw.gravity = Magick::WestGravity
        draw.pointsize = CELL_SIZE - 5
        draw.font = font_path
        draw.fill = "white"
        image.format = "PNG"
      end
    end

    def character(index)
      (index + 1).chr
    end

    def coord(x)
      x * CELL_SIZE
    end
  end
end
