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

    def string_indices(string)
      string.chars.map { |char| index_table[char] }
    end

    def string_offsets(string)
      offsets = []
      FreeType::API::Font.open(@font_file_path) do |face|
        widths = string.chars.map do |char|
          face.glyph(char).char_width
        end

        offsets << 0
        widths.each do |width|
          offsets << offsets.last + width
        end
      end
      offsets.map { |offset| (offset / 1024.0) / 2 }
    end

    private

    def generate_texture
      path = File.expand_path(@font_file_path).gsub(/\.ttf$/, ".png")
      File.delete(path) if File.exist?(path)
      return Engine::Texture.new(path) if File.exist?(path)

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

      image.write(path)
      Engine::Texture.new(path)
    end

    def write_character(character, draw, image, x, y)
      font_path = File.expand_path(@font_file_path)

      draw.annotate(image, CELL_SIZE, CELL_SIZE, x, y, character) do
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

    def index_table
      @index_table ||=
        begin
          hash = {}
          GLYPH_COUNT.times do |x|
            GLYPH_COUNT.times.each do |y|
              index = x * GLYPH_COUNT + y
              next if index >= 255
              character = character(index)
              hash[character] = index
            end
          end
          hash
        end
    end

    def coord(x)
      x * CELL_SIZE
    end
  end
end
