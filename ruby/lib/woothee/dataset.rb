module Woothee
  module DataSet
    KEY_LABEL = "label"
    KEY_NAME = "name"
    KEY_TYPE = "type"
    KEY_CATEGORY = "category"
    KEY_OS = "os"
    KEY_VENDOR = "vendor"
    KEY_VERSION = "version"

    TYPE_BROWSER = "browser"
    TYPE_OS = "os"
    TYPE_FULL = "full"

    CATEGORY_PC = "pc"
    CATEGORY_SMARTPHONE = "smartphone"
    CATEGORY_MOBILEPHONE = "mobilephone"
    CATEGORY_CRAWLER = "crawler"
    CATEGORY_APPLIANCE = "appliance"
    CATEGORY_MISC = "misc"

    ATTRIBUTE_NAME = "name"
    ATTRIBUTE_CATEGORY = "category"
    ATTRIBUTE_OS = "os"
    ATTRIBUTE_VENDOR = "vendor"
    ATTRIBUTE_VERSION = "version"

    VALUE_UNKNOWN = "UNKNOWN"

    def self.const(const_name)
      unless const_name
        const_name = self.class
      end
      self.const_get(const_name)
    end

    @dataset = {}

    def self.dataset(label)
      unless label
        label = self.class
      end
      @dataset[label]
    end
  end
end
