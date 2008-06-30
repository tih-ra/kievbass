require 'test/unit'

require 'rubygems'
require 'active_record'

require File.dirname(__FILE__) + '/../init'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")

ActiveRecord::Schema.define(:version => 1) do
  create_table :people do |t|
    t.string :name
    t.timestamps
  end

  create_table :tags do |t|
    t.string :name
  end

  add_index :tags, :name

  create_table :taggings do |t|
    t.integer :tag_id, :taggable_id
    t.string :taggable_type
  end

  add_index :taggings, [:tag_id, :taggable_type, :tag_id]
  add_index :taggings, [:taggable_id, :taggable_type, :tag_id]
end

class Person < ActiveRecord::Base
  acts_as_taggable
end

class ActsAsTaggableTest < Test::Unit::TestCase

  # TODO: Fix fixture loading so you don't have to run Person.destroy_all
  def setup
    Person.destroy_all
    @david = Person.create :name => "David"
  end

  def test_should_tagged_with_tags
    @david.tag_list = "ruby rails"
    assert_equal [@david], Person.find_tagged_with("ruby")
    assert_equal [], Person.find_tagged_with("java")
  end

  def test_should_tag_with_tag_list
    assert_difference 'Tagging.count', 2 do
      @david.tag_list = "ruby rails"
    end
  end

  def test_should_destroy_all_taggings
    assert_difference 'Tagging.count', 2 do
      @david.tag_list = "ruby rails"
      @david.tag_list = "ruby rails"
    end
  end

  def test_should_return_tag_list
    @david.tag_list = "ruby rails"
    assert_equal "ruby rails", @david.tag_list
  end

  def test_should_return_quoted_tag_name_list
    @david.tag_list = "ruby rails"
    assert_equal '"rails","ruby"', @david.tags.quoted_name_list
  end
end

class TagTest < Test::Unit::TestCase

  def setup
    @david = Person.create :name => "David"
    @tag = Tag.create :name => "ruby"
  end

  def test_should_find_tag_by_name
    assert_equal @tag, Tag.find("ruby")
  end

  def test_should_find_tag_by_id
    assert_equal @tag, Tag.find(1)
  end

  def test_should_parse_tag_list
    assert_equal %w(ruby), Tag.parse("ruby")
    assert_equal %w(ruby), Tag.parse(" ruby ")
    assert_equal %w(ruby), Tag.parse("ruby ruby")
    assert_equal %w(ruby rails), Tag.parse("ruby rails")
    assert_equal %w(ruby rails), Tag.parse("ruby, rails")
    assert_equal ["ruby on rails"], Tag.parse('"ruby on rails"')
    assert_equal ["ruby on rails", "framework"], Tag.parse('framework "ruby on rails"')
  end

  def test_should_find_taggings
    @tag.on(@david)
    assert_equal 1, @tag.taggings.count
  end

  def test_should_find_tagged
    @tag.on(@david)
    assert_equal [@david], @tag.tagged
  end

  def test_should_create_tagging
    assert_difference 'Tagging.count' do
      @tag.on(@david)
    end
  end

  def test_should_compare_tags
    another_tag = Tag.create :name => "ruby"
    assert @tag == another_tag
  end

  def test_should_coerce_into_params
    assert_equal "ruby", @tag.to_param
  end

  def test_should_coerce_into_string
    assert_equal "ruby", "#{@tag}"
  end
end

class TaggingTest < Test::Unit::TestCase

  def setup
    @david = Person.create :name => "David"
    @tag = Tag.create :name => "ruby"
    @tagging = Tagging.create :tag => @tag, :taggable => @david
  end

  def test_should_find_tag
    assert_equal @tag, @tagging.tag
  end

  def test_should_find_taggable
    assert_equal @david, @tagging.taggable
  end

  def test_should_determine_tagged_class
    assert_equal "Person", Tagging.tagged_class(@david)
  end

  def test_should_find_taggable
    assert_equal @david, Tagging.find_taggable("Person", @david.id)
  end
end
