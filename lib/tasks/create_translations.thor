# -*- encoding : utf-8 -*-
require 'csv'

class CreateTranslations < Thor
  require_relative '../../config/environment.rb'
  desc "create_translations <csv_file>", "create translations from CSV file of product text"
  def create_translations(csv_file)
    CSV.foreach(csv_file, headers: true, skip_blanks: true) do |row|
      begin
        languages = row.headers.dup
        languages.shift unless languages.first == 'en'
        source_language = languages.shift
        if row[source_language].present?
          source = Source.new
          source.language = source_language.gsub(/_/,'-')
          if /^\s*$/.match(row[source_language])
            source.text = "<p>#{row[source_language].split(/^\s*$/).map(&:strip).join("</p><p>")}</p>"
          else
            source.text = row[source_language]
          end

          languages.each do |lang|
            t = Translation.new
            t.language = lang.dup
            if /^\s*$/.match(row[lang])
              t.text = "<p>#{row[lang].split(/^\s*$/).map(&:strip).join("</p><p>")}</p>"
            else
              t.text = row[lang]
            end
            source.translations << t
          end
          unless source.save
            puts "#{ source.errors.full_messages } for #{source.text}"
          end
        end
      rescue ActiveRecord::RecordNotUnique => e
        #NOOP
      end
    end
  end
end
