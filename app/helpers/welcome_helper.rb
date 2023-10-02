module WelcomeHelper
  def default_language
    if I18n.default_locale == :en
      "English (International)"
    else
      "Português Brasileiro"
    end
  end
end
