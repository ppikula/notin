class Note < ActiveRecord::Base
  attr_accessible :content, :tag_list, :title

  acts_as_taggable

  default_scope order("updated_at DESC")

  # Looks for notes that have *all* given keywords (in content or tags) separated by spaces.
  #
  # = Example
  #   TaggedNote.search("ruby rails")
  #
  # @param keywords_string [String]
  # @return [ActiveRecord]
  def self.search(keywords_string)
    keywords = keywords_string.split(/\s/)

    query = Note

    keywords.each do |keyword|
      keyword_string = "%#{keyword.strip}%"

      query_string = <<-SQL
          (
            SELECT GROUP_CONCAT(name)
            FROM tags
            LEFT JOIN taggings ON taggings.tag_id = tags.id
            WHERE taggings.taggable_id = notes.id AND taggings.taggable_type = 'Note'
          ) LIKE ?
          OR
            content LIKE ?
          OR title LIKE ?
      SQL

      query = query.where(query_string, keyword_string, keyword_string, keyword_string)
    end

    query
  end
end