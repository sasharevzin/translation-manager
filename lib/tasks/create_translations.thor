# -*- encoding : utf-8 -*-
require 'csv'

class CreateTranslations < Thor
  require_relative '../../config/environment.rb'
  desc "update_translations <csv_file>", "update translations from CSV file of product text"
  def update_translations(csv_file)
    CSV.foreach(csv_file, skip_blanks: true) do |row|
      string = row[0].dup
      length = string.length
      string_to_search = string[5..(length/2)]
      search_results = Source.search(text: string_to_search)
      if search_results.any?
        first_result = search_results.first
        say "found #{search_results.count} search results for search"
        ask "Should I update \n #{first_result.text} \n with #{row[0]} \n please respond with y or n"
        if yes?('y')
          puts first_result.update_attribute(:text, row[0])
        end
      else
        say "no results found for the search #{string_to_search}"
      end
      puts "---------------------------------------------------------------------------------------"
    end
  end

end
