# -*- encoding : utf-8 -*-
require 'csv'
require 'pp'
class CreateTranslations < Thor
  require_relative '../../config/environment.rb'
  desc "create_translations <csv_file>", "create translations from CSV file of product text"
  def create_translations(csv_file)
      CSV.foreach(csv_file, encoding: 'ISO-8859-1:UTF-8', headers: true) do |row|
        languages = row.headers.dup
        source_language = languages.shift
        source = Source.new
        source.language = source_language.gsub(/_/,'-')
        source.text = row[source_language]
        
        languages.each do |lang|
          t = Translation.new
          t.language = lang.dup.gsub(/_/,'-')
          t.text = row[lang]
          source.translations << t
        end  
        source.save!
      end
  end
end
