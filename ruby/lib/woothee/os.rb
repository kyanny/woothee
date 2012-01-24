module Woothee
  module OS
    include Util
    include DataSet
    
    def self.challenge_windows(ua, result)
      if ua.index("Windows") < 0
        return false
      end
      
      data = dataset("Win")
      
      unless $ua.match(/Windows ([ .a-zA-Z0-9]+)[;\\)]/o)
        # Windows, but version unknown
        update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
        update_os(result, Woothee::DataSet.const('KEY_NAME'))
        return true
      end
      
      version = $1
      case version
      when "NT 6.1"
        data = dataset("Win7")
      when "NT 6.0"
        data = dataset("WinVista")
      when "NT 5.1"
        data = dataset("WinXP")
      when /^Phone OS/o
        data = dataset("WinPhone")
      when "NT 5.0"
        data = dataset("Win2000")
      when "NT 4.0"
        data = dataset("WinNT4")
      when "98"
        data = dataset("Win98") # wow, WinMe is shown as 'Windows 98; Win9x 4.90', fxxxk
      when "95"
        data = dataset("Win95")
      when "CE"
        data = dataset("WinCE")
      else
        update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
        update_os(result, data[Woothee::DataSet.const('KEY_NAME')])
      end
      
      return true
    end
    
    def self.challenge_osx(ua, result)
      if ua.index("Mac OS X") < 0
        return false
      end
      
      data = dataset("OSX")
      if ua.index("like Mac OS X") > -1
        if ua.index("iPhone") > -1
          data = dataset("iPhone")
        elsif ua.index("iPad") > -1
          data = dataset("iPad")
        elsif ua.index("iPod") > -1
          data = dataset("iPod")
        end
      end
      
      update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
      update_os(result, data[Woothee::DataSet.const('KEY_NAME')])
      
      return true
    end
    
    def self.challenge_linux(ua, result)
      if ua.index("Linux") < 0
        return false
      end
      
      data = nil
      if ua.index("Android") > -1
        data = dataset("Android")
      else
        data = DataSet("Linux")
      end
      
      update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
      update_os(result, data[Woothee::DataSet.const('KEY_NAME')])
      
      return true
    end
    
    def self.challenge_smartphone(ua, result)
      data = nil
      if ua.index("iPhone") > -1
        data = dataset("iPhone")
      elsif ua.index("iPad") > -1
        data = dataset("iPad")
      elsif ua.index("iPod") > -1
        data = dataset("iPod")
      elsif ua.index("Android") > -1
        data = dataset("Android")
      elsif ua.index("CFNetwork") > -1
        data = dataset("iOS")
      elsif ua.index("BlackBerry") > -1
        data = dataset("BlackBerry")
      end
      
      return false unless data
      
      update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
      update_os(result, data[Woothee::DataSet.const('KEY_NAME')])
      return true
    end
    
    def self.challenge_mobilephone(ua, result)
      if ua.index("KDDI-") > -1
        if ua.match(%r{KDDI-[^- /;()"']+)}o) # " #double-quote in regexp break ruby-mode syntax highlight
          term = $1
          data = dataset("au")
          update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
          update_os(result, data[Woothee::DataSet.const('KEY_OS')])
          update_version(result, term)
          return true
        end
      end
      
      if (ua.index("WILLCOM") > -1) || (ua.index("DDIPOCKET") > -1)
        if ua.match(%r!(?:WILLCOM|DDIPOCKET);[^/]+/([^ /;()]+)!o)
          term = $1
          data = dataset("willcom")
          update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
          update_os(result, data[Woothee::DataSet.const('KEY_OS')])
          update_version(result, term)
          return true
        end
      end
      
      if ua.index("SymbianOS") > -1
        data = dataset("SymbianOS")
        update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
        update_os(result, data[Woothee::DataSet.const('KEY_OS')])
        return true
      end
      
      if ua.index("Google Wireless Transcoder") > -1
        update_map(result, dataset("MobileTranscoder"))
        update_version(result, "Google")
        return true
      end
      
      if ua.index("Naver Transcoder") > -1
        update_map(result, dataset("MobileTranscoder"))
        update_version(result, "Naver")
        return true
      end
      
      return false
    end
    
    def self.challenge_appliance(ua, result)
      if ua.index("Nintendo DSi;")
        data = dataset("NintendoDSi")
        update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
        update_os(result, data[Woothee::DataSet.const('KEY_OS')])
        return true
      end
      
      if ua.index("Nintendo Wii;") > -1
        data = dataset("NintendoWii")
        update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
        update_os(result, data[Woothee::DataSet.const('KEY_OS')])
        return true
      end
      
      return false
    end
    
    def self.challenge_misc(ua, result)
      data = nil
      if ua.index("(Win98;") > -1
        data = dataset("Win98")
      elsif ua.index("Macintosh; U; PPC;") > -1
        data = dataset("MacOS")
      elsif ua.index("X11; FreeBSD") > -1
        data = dataset("BSD")
      end
      
      if data
        update_category(result, data[Woothee::DataSet.const('KEY_CATEGORY')])
        update_os(result, data[Woothee::DataSet.const('KEY_NAME')])
        return true
      end
      
      return false
    end
  end
end
