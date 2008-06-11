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
  
  def test_namespace
    @other_user = User.create
    
    @user.config[:animals, :likes_cats?] = true
    @user.config[:animals, :favorite] = 'cat'

    @other_user.config[:animals, :likes_cats?] = false
    @other_user.config[:animals, :favorite] = 'dog'

    assert_equal true, @user.config[:animals, :likes_cats?]
    assert_equal 'cat', @user.config[:animals, :favorite]
    assert_equal false, @other_user.config[:animals, :likes_cats?]
    assert_equal 'dog', @other_user.config[:animals, :favorite]

    assert_equal true, @user.config.namespace(:animals)[:likes_cats?]
    assert_equal 'cat', @user.config.namespace(:animals)[:favorite]
    assert_equal false, @other_user.config.namespace(:animals)[:likes_cats?]
    assert_equal 'dog', @other_user.config.namespace(:animals)[:favorite]
  end
  
  def test_finding_in_namespace
    @user.config[:animals, :cat] = 'Toby'
    @user.config[:animals, :dog] = 'Gabby'
    @user.config[:animals, :mouse] = 'Mickey'
    hsh = { :cat => 'Toby', :dog => 'Gabby', :mouse => 'Mickey' }
    assert_equal hsh, @user.config.namespace(:animals)
  end
  
  def test_default_configuration_settings
    assert_equal '$55,000', @company.config[:salary, :default_for_manager]
    @company.config[:salary, :default_for_manager] = '$65,000'
    assert_equal '$65,000', @company.config[:salary, :default_for_manager]
  end
 
  def test_mass_assignment
    hash = { :favorite_color => 'red', :favorite_city => 'New York', :favorite_artist => 'Radiohead', :animals => { :favorite => 'cat', :likes_elephants? => true } }
    @user.config = hash
    assert_equal @user.config[:favorite_color], 'red'
    assert_equal @user.config[:animals, :favorite], 'cat'
    assert_equal @user.config[:animals, :likes_elephants?], true
  end
  
  def test_basic_on_class
    User.config[:default_salary] = '$55,000'
    assert_equal User.config[:default_salary], '$55,000'
  end
  
  def test_defaults_on_class
    assert_equal Company.config[:salary, :default_for_manager], '$55,000'
  end
  
  def test_mass_assignment_on_class
    hash = { :favorite_color => 'red', :favorite_city => 'New York', :favorite_artist => 'Radiohead', :animals => { :favorite => 'cat', :likes_elephants? => true } }
    User.config = hash
    assert_equal User.config[:favorite_color], 'red'
    assert_equal User.config[:animals, :favorite], 'cat'
    assert_equal User.config[:animals, :likes_elephants?], true
  end
  
  def test_base_basics
    Configurator[:enable_quantum_accelerator?] = true
    assert Configurator[:enable_quantum_accelerator?]
    Configurator[:colors, :favorite] = 'red'
    assert_equal Configurator[:colors, :favorite], 'red'
  end
 
end