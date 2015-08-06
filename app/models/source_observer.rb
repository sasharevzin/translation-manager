class SourceObserver < ActiveRecord::Observer # rubocop:disable Style/Documentation
  def before_update(source)
    return unless source.translations.any?

    TranslationCache.new.update(*source.translations)
  end
end
