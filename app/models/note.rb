class Note < ActiveRecord::Base
  attr_accessible :content, :tag_list, :title, :user_id

  belongs_to :user

  acts_as_taggable_on :tags

  default_scope order("updated_at DESC")

  # @param [User] user
  # @param [Integer] id Note Id
  # @return [Note]
  def self.for_user(user, id)
    where("user_id = ? AND id = ?", user.id, id).first
  end

  # Looks for user's notes that have *all* given keywords (in content or tags) separated by spaces.
  #
  # = Example
  #   TaggedNote.search(current_user.id, "ruby rails")
  #
  # @param [Integer] user_id
  # @param [String] keywords_string
  # @return [ActiveRecord]
  def self.search(user_id, keywords_string)
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

    query = query.where(:user_id => user_id)
    query
  end

  # @param [User] user
  # @return [String] tags
  def user_tags(user)
    tags_from(user).to_s
  end

  # @param [User] user
  # @param [String] tag_list
  # @param [Boolean] skip_save
  def tag_by_user(user, tag_list, skip_save: false)
    user.tag(self, :with => tag_list, :on => :tags, skip_save: skip_save)
  end
end