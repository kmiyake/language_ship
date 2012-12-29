module ApplicationHelper
  def available_language_options
    options = []
    AVAILABLE_LANGUAGES.each do |locale, language|
      options << [language, locale]
    end
    options.sort_by {|o| o[0] }
  end

  def translation_language_options
    options = []
    AVAILABLE_LANGUAGES.each do |locale, language|
      options << [I18n.t("language.#{locale}"), locale]
    end
    options.sort_by {|o| o[0] }
  end

  def graph_facebook_picture_link(uid, size)
    "https://graph.facebook.com/#{uid}/picture?type=#{size}"
  end
end
