module Woothee
  module Util
    module_function

    def update_map(target, source)
      source.each{ |key, value|
        next if key == Woothee::DataSet.const('KEY_LABEL') or key == Woothee::DataSet.const('KEY_TYPE')
        if defined?(source[key]) and source[key].length > 0
          target[key] = source[key]
        end
      }
    end

    def update_category(target, category)
      target[Woothee::DataSet->const('ATTRIBUTE_CATEGORY')] = category
    end

    def update_version(target, version)
      target[Woothee::DataSet->const('ATTRIBUTE_VERSION')] = version
    end

    def update_os(target, os)
      target[Woothee::DataSet->const('ATTRIBUTE_OS')] = os
    end
  end
end
