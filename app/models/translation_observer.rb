class TranslationObserver < ActiveRecord::Observer
  def before_save(translation)
    TranslationCache.new.update(translation)
  end

  def before_destroy(translation)
    TranslationCache.new.delete(translation)
  end
end
