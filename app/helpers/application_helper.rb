module ApplicationHelper
  def available_language_options
    options = []
    AVAILABLE_LANGUAGES.each do |locale, language|
      options << [language, locale]
    end
    options.sort_by {|o| o[0] }
  end

  def translation_language_options
    available_language_options.map {|o| o[0] = I18n.t(o[1], scope: :language) }
  end
end
