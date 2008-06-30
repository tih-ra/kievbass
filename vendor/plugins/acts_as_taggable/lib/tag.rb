class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :delete_all

  def self.find(*args)
    if args.first.is_a?(String)
      find_by_name(args.first.to_s)
    else
      super
    end
  end

  def self.parse(list)
    tag_names = []

    # first, pull out the quoted tags
    list.gsub!(/\"(.*?)\"\s*/ ) { tag_names << $1; "" }

    # then, replace all commas with a space
    list.gsub!(/,/, " ")

    # then, get whatever's left
    tag_names.concat list.split(/\s/)

    # strip whitespace from the names
    tag_names = tag_names.map { |t| t.strip }

    # delete any blank tag names
    tag_names = tag_names.delete_if { |t| t.empty? }

    # remove duplicates
    tag_names = tag_names.uniq

    return tag_names
  end

  def tagged
    @tagged ||= taggings.collect { |tagging| tagging.taggable }
  end

  def on(*taggables)
    taggables.each { |taggable| taggings.create :taggable => taggable }
  end

  def ==(comparison_object)
    super || name == comparison_object.to_s
  end

  def to_param
    name
  end

  def to_s
    name
  end
end
