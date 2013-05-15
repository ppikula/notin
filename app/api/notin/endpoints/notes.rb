module Notin
  module Endpoints
    class Notes < Grape::API
      before do
        authenticate!
      end

      resource :notes do
        desc 'Returns list of notes.'
        params do
          optional :keywords, :type => String, :desc => 'Perform search by this keyword'
        end

        get '/' do
          keywords = params[:keywords]
          if keywords.present?
            notes = Note.search(current_user.id, keywords)
          else
            notes = current_user.notes
          end

          Entities::NoteEntity.represent(notes, :current_user => current_user)
        end

        desc 'Returns note.'
        get '/:id' do
          note = Note.for_user(current_user, params[:id])
          Entities::NoteEntity.represent(note, :current_user => current_user)
        end

        desc 'Creates a new note.'
        post '/' do
          note = Note.create({:content => params[:content], :title => params[:title], :user_id => current_user.id})
          note.tag_by_user(current_user, params[:tag_list])

          Entities::NoteEntity.represent(note, :current_user => current_user)
        end

        desc 'Updates note.'
        put '/:id' do
          note = Note.for_user(current_user, params[:id])
          note.update_attributes({:content => params[:content], :title => params[:title]})
          note.tag_by_user(current_user, params[:tag_list])

          Entities::NoteEntity.represent(note.reload, :current_user => current_user)
        end

        desc 'Destroys note.'
        delete '/:id' do
          note = Note.for_user(current_user, params[:id]).destroy
          Entities::NoteEntity.represent(note, :current_user => current_user)
        end
      end
    end
  end
end