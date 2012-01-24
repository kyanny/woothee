require 'test/unit'
require 'woothee/dataset'

class TestWootheeDataSet < Test::Unit::TestCase
  def test_const
    assert_equal 'name', Woothee::DataSet.const('ATTRIBUTE_NAME')
  end

  def test_dataset
    set = Woothee::DataSet.dataset('GoogleBot')
    assert_equal 'GoogleBot', set.name
  end
end
