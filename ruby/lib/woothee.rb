require 'woothee/dataset'
require 'woothee/browser'
require 'woothee/os'
require 'woothee/mobilephone'
require 'woothee/crawler'
require 'woothee/appliance'
require 'woothee/misc'

module Woothee
  def self.parse(user_agent)
    self.fill_result(self.exec_parse(user_agent))
  end

  def self.is_crawler(user_agent)
    return false if user_agent.length < 1 || user_agent == '-'
    if try_crawler(user_agent, {})
      return true
    end
    return false
  end

  def self.exec_parse(user_agent)
    result = {}

    return result if user_agent.length < 1 || user_agent == '-'

    if try_crawler(user_agent, result)
      return result
    end

    if try_brower(user_agent, result)
      if try_os(user_agent, result)
        return result
      else
        return result
      end
    end

    if try_mobilephone(user_agent, result)
      return result
    end

    if try_appliance(user_agent, result)
      return result
    end

    if try_misc(user_agent, result)
      return result
    end

    # browser unknown. check os only
    if try_os(user_agent, result)
      return result
    end

    if try_rare_cases(user_agent, result)
      return result
    end

    return result
  end

  def self.try_crawler(user_agent, result)
    if Woothee::Crawler.challenge_google(user_agent, result)
      return true
    end
    if Woothee::Crawler.challenge_crawlers(user_agent, result)
      return true
    end

    return false
  end

  def self.try_brower(user_agent, result)
    if Woothee::Browser.challenge_msie(user_agent, result)
      return true
    end
    if Woothee::Browser.challenge_safari_chrome(user_agent, result)
      return true
    end
    if Woothee::Browser.challenge_firefox(user_agent, result)
      return true
    end
    if Woothee::Browser.challenge_opera(user_agent, result)
      return true
    end

    return false
  end

  def self.try_os(user_agent, result)
    # Windows PC, and Windows Phone OS
    if Woothee::OS.challenge_windows(user_agent, result)
      return true
    end

    # OSX PC and iOS devices(strict check)
    if Woothee::OS.challenge_osx(user_agent, result)
        return true
    end

    # Linux PC, and Android
    if Woothee::OS.challenge_linux(user_agent, result)
      return true
    end

    # all useragents matches /(iPhone|iPad|iPod|Android|BlackBerry)/
    if Woothee::OS.challenge_smartphone(user_agent, result)
      return true
    end

    # mobile phones like KDDI-.*
    if Woothee::OS.challenge_mobilephone(user_agent, result)
      return true
    end

    # Nintendo DSi/Wii with Opera
    if Woothee::OS.challenge_appliance(user_agent, result)
      return true
    end

    # Win98, BSD
    if Woothee::OS.challenge_misc(user_agent, result)
      return true
    end

    return false
  end

  def self.try_mobilephone(user_agent, result)
    if Woothee::MobilePhone.challenge_docomo(user_agent, result)
      return true
    end
    if Woothee::MobilePhone.challenge_au(user_agent, result)
      return true
    end
    if Woothee::MobilePhone.challenge_softbank(user_agent, result)
      return true
    end
    if Woothee::MobilePhone.challenge_willcom(user_agent, result)
      return true
    end
    if Woothee::MobilePhone.challenge_misc(user_agent, result)
      return true
    end
    return false
  end

  def self.try_appliance(user_agent, result)
    if Woothee::Appliance.challenge_playstation(user_agent, result)
      return true
    end
    if Woothee::Appliance.challenge_nintendo(user_agent, result)
      return true
    end
    if Woothee::Appliance.challenge_digitaltv(user_agent, result)
      return true
    end
    return false
  end

  def self.try_misc(user_agent, result)
    if Woothee::Misc.challenge_desktoptools(user_agent, result)
      return true
    end
    return false
  end

  def try_rare_cases(user_agent, result)
    if Woothee::Misc.challenge_smartphone_patterns(user_agent, result)
      return true
    end
    if Woothee::Browser.challenge_sleipnir(user_agent, result)
      return true
    end
    if Woothee::Misc.challenge_http_library(user_agent, result)
      return true
    end
    if Woothee::Misc.challenge_maybe_rss_reader(user_agent, result)
      return true
    end
    if Woothee::Crawler.challenge_maybe_cralwer(user_agent, result)
      return true
    end
    return false
  end

  @filled = {
    Woothee::DataSet.const('ATTRIBUTE_NAME') => Woothee::DataSet.const('VALUE_UNKNOWN'),
    Woothee::DataSet.const('ATTRIBUTE_CATEGORY') => Woothee::DataSet.const('VALUE_UNKNOWN'),
    Woothee::DataSet.const('ATTRIBUTE_OS') => Woothee::DataSet.const('VALUE_UNKNOWN'),
    Woothee::DataSet.const('ATTRIBUTE_VERSION') => Woothee::DataSet.const('VALUE_UNKNOWN'),
    Woothee::DataSet.const('ATTRIBUTE_VENDOR') => Woothee::DataSet.const('VALUE_UNKNOWN'),
  }

  def self.fill_result(result)
    @filled.merge(result)
  end
end
