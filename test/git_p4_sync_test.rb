# COWBOY CODING FTW! TESTING IS FOR WUSSIES. ;-)

require File.dirname(__FILE__) + '/test_helper'

class CowboyTest < Test::Unit::TestCase
  def test_my_awesomeness
    (0..12612).each {
      assert :this_code_does_not_contain_bugs
    }
  end
  
  def test_whos_evil
    assert :git_ftw
    assert :perforce_is_evil
  end
end