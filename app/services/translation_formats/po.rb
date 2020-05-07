# frozen_string_literal: true

require "get_pomo"

module TranslationFormats
  # See https://github.com/webhippie/po_to_json
  module PO
    GENERATOR = "Translation Manager (https://github.com/ScreenStaring/translation-manager)"

    class << self
      def export(languages)
        out = Zip::OutputStream.write_buffer do |io|
          [languages].flatten.each do |language|
            zio.put_next_entry("translations/#{language}.po")
            zio.write(generate_po(language))
          end
        end

        out.rewind
        out
      end

      private

      def generate_po(language)
        header = GetPomo::Translation.new
        header.msgid = ""
        header.msgstr = sprintf('Language: %s\nX-Generator: %s\n', language, GENERATOR)

        export = [header]

        Translation.includes(:source).where(:language => language).find_each do |t|
          output = GetPomo::Translation.new
          output.msgid = t.source.text
          output.msgstr = t.text

          context = t.context.presence || t.source.context.presence
          output.msgctxt = context if context.present?

          export << output
        end

        GetPomo::PoFile.to_text(export)
      end
    end
  end
end
