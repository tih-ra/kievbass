module CommentsHelper
    require 'hpricot'
    WhiteListHelper.tags += %w(object param embed)
    WhiteListHelper.tags += %w(table tbody tr th td)
    WhiteListHelper.tags += %w(font)
    WhiteListHelper.tags += %w(span u)
    WhiteListHelper.attributes.merge %w(id style flashvars wmode codebase classid value name type allowfullscreen)
end
