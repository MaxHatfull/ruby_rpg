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
      @texture ||=
        begin
          path = File.expand_path(File.join(ROOT, "_imported", @font_file_path.gsub(".ttf", ".png")))
          Engine::Texture.for(path)
        end
    end

    def vertex_data(string)
      text_indices = string_indices(string)
      offsets = string_offsets(string)
      text_indices.zip(offsets).flatten
    end

    def string_indices(string)
      string.chars.map { |char| index_table[char] }
    end

    def string_offsets(string)
      offsets = []
      font_path = File.expand_path(File.join(ROOT, @font_file_path))
      FreeType::API::Font.open(font_path) do |face|
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
  end
end
