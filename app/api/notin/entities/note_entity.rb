module Notin
  module Entities
    class NoteEntity < Grape::Entity
      expose :id, :title, :content, :created_at, :updated_at
      expose :tag_list do |note|
        note.tag_list.to_s
      end
    end
  end
end