require 'i18n'

# In an attempt to insulate itself from I18n specifics (though I18n doesn't make this easy) this class
# goes a bit out of its way to use I18n's interface instead the raw  key/value store.
class TranslationCache
  CacheError = Class.new(StandardError)

  def update(*translations)
    translations.each { |t| store_translation(t) }
  rescue => e
    raise CacheError, e.message
  end

  def delete(*translations)
    return unless delete_supported?

    translations.each do |t|
      next unless t.source && t.language
      delete_from_cache(t.language, t.source.text)
    end
  rescue => e
    raise CacheError, e.message
  end

  private

  def store_translation(t)
    return unless t.source

    if changed?(t)
      lang = t.language_changed?    ? t.language_change[0]    : t.language
      text = t.source.text_changed? ? t.source.text_change[0] : t.source.text

      delete_from_cache(lang, text)
    end

    I18n.backend.store_translations t.language, t.source.text => t.text
  end

  def changed?(t)
    # If the backend doesn't delete, then we don't care if it has changed
    delete_supported? && (t.language_changed? || t.source.text_changed?)
  end

  def cache
    return @cache if defined?(@cache)

    be = Array( I18n.backend.respond_to?(:backends) ? I18n.backend.backends : I18n.backend ).
         find { |b| b.is_a?(I18n::Backend::KeyValue) }

    @cache = be.respond_to?(:store) ? be.store : nil
  end

  def delete_supported?
    cache.respond_to?(:del)
  end

  def key(locale, key)
    bef = I18n::Backend::Flatten
    sprintf "%s%s%s", locale, bef::FLATTEN_SEPARATOR, bef.escape_default_separator(key)
  end

  def delete_from_cache(lang, text)
    cache.del(key(lang, text))
  end
end
