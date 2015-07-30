require 'i18n'

class TranslationCache
  def update(*translations)
    translations.each { |t| store_translation(t) }
  end

  # rescue Redis::CannotConnectError
  def delete(*translations)
    return unless delete_supported?
    translations.each do |t|
      key = key(t.language, t.source.text)
      I18n.backend.store.del(key)
    end
  end

  private

  def store_translation(t)
    if changed?(t)
      lang = t.language_changed?    ? t.language_changes[0]    : t.language
      text = t.source.text_changed? ? t.source.text_changes[0] : t.source.text
      key  = key(lang, text)

      I18n.backend.store.del(key)
    end

    key = key(t.language, t.source.text)
    I18n.backend.store_translations t.language, key => t.text
  end

  def changed?(t)
    # If the backend doesn't delete, then we don't care if it has changed
    delete_supported? && (t.language_changed? || t.source.text_changed?)
  end

  def delete_supported?
    I18n.backend.store.respond_to?(:del)
  end

  def key(locale, key)
    sprintf "%s.%s", locale, I18n::Backend::Flatten.escape_default_separator(key)
  end
end

