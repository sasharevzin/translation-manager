require "csv"

module TranslationFormats
  module CSV
    def self.import(path)
      CSV.foreach(path, :headers => true, :skip_blanks => true) do |row|
        languages = row.headers.dup

        source_language = languages.shift
        next unless row[source_language]

        source = Source.find_or_initialize_by(:language => source_language.tr("_", "-"), :text => row[source_language].strip)
        languages.each do |lang|
          next unless row[lang]

	  t = Translation.new
	  t.language = lang.dup
	  t.text = row[lang].strip

	  source.translations << t
        end

	source.save!
      end
    end
  end
end
