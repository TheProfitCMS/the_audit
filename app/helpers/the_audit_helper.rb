module TheAuditHelper
  def bot_marker agent
    return nil unless agent.to_s.match(/bot|riddler/mix)
    name = case agent
      when /yandex/mix
        :Yandex
      when /google/mix
        :Google
      when /ahrefs/mix
        :Arefs
      when /exabot/mix
        :Exa
      when /interfax/mix
        :Interfax
      when /bing/mix
        :Bing
      when /riddler/mix
        :Riddler
      else
        :Bot
    end

    content_tag :span, name, class: 'btn btn-warning btn-xs'
  end
end
