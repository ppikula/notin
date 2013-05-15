module Notin
  module Entities
    class NoteEntity < Grape::Entity
      expose :id, :title, :content, :created_at, :updated_at
      expose :tag_list do |note, options|
        note.user_tags(options[:current_user])
      end
    end
  end
end