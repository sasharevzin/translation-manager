# -*- encoding : utf-8 -*-

# Thor task for exporting PO file
class ExportPo < Thor
  require_relative '../../config/environment.rb'
  require_relative '../unsupported_language_error'
  desc 'for <language>',
       "export PO file for the given language. Supported languages are #{Source.supported_languages.join(', ')}"
  def for(language)
    check_language(language)
    file = generate_file_with_comments(language)
    search_and_write_file(file, language)
    close_file_with_comments(file, language)
  end

  no_tasks do
    def check_language(language)
      raise UnsupportedLanguageError unless Source.supported_languages.include?(language)
    end

    def generate_file_with_comments(language)
      file = File.new("#{Rails.root}/tmp/#{language}.po", 'wb')
      file.write "# -*- encoding : utf-8 -*-\n"
      file.write "# Autogenerated file\n"
      file.write "#\n"
      file
    end

    def close_file_with_comments(file, language)
      file.write "\"Language: #{language}\""
      file.close
    end

    def search_and_write_file(file, language)
      Source.includes(:translations)
        .where('translations.language = ?', language)
        .references(:translations)
        .find_each do |source|
        translation = source.translations.find_by(language: language)
        next unless translation
        file.write("msgid: \"#{source.text}\" \n")
        file.write("msgstr: \"#{translation.text}\" \n\n")
      end
    end
  end
end
