require 'test/unit'
require File.join(File.dirname(__FILE__), 'helper')

class ConfiguratorTest < Test::Unit::TestCase

  def setup
    setup_db
    @user = User.create
    @company = Company.create
  end
 
  def teardown
    teardown_db
  end
  
  def test_basic
    @user.config[:favorite_color] = 'red'
    assert_equal 'red', @user.config[:favorite_color]
    @user.config['favorite_city'] = 'New York'
    assert_equal 'New York', @user.config[:favorite_city] # sym/string indifference
  end
  
  def test_booleans
    @user.config[:likes_cats?] = 'true'
    assert_equal true, @user.config[:likes_cats?]
    @user.config[:likes_dogs?] = true
    assert_equal true, @user.config[:likes_dogs?]
  end
  
  def test_default_configuration_settings
    assert_equal '$55,000', @company.config[:default_employee_salary]
    @company.config[:default_employee_salary] = '$65,000'
    assert_equal '$65,000', @company.config[:default_employee_salary]
  end

  def test_mass_assignment
    hash = { :favorite_color => 'red', :favorite_city => 'New York', :favorite_artist => 'Radiohead' }
    @user.config = hash
    hash.each do |key, value|
      assert_equal @user.config[key], value
    end
  end

end
