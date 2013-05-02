module Notin
  module Endpoints
    class Notes < Grape::API
      resource :notes do
        desc 'Return list of notes.'
        params do
          optional :keywords, :type => String, :desc => 'Perform search by this keyword'
        end

        get '/' do
          keywords = params[:keywords]
          if keywords.present?
            notes = Note.search(keywords)
          else
            notes = Note.all
          end

          Entities::NoteEntity.represent(notes)
        end

        desc 'Return note.'
        get '/:id' do
          Entities::NoteEntity.represent(Note.find(params[:id]))
        end

        desc 'Create a new note.'
        post '/' do
          note = Note.create({:content => params[:content], :title => params[:title], :tag_list => params[:tag_list]})

          Entities::NoteEntity.represent(note)
        end

        desc 'Update note.'
        put '/:id' do
          note = Note.find(params[:id])
          note.update_attributes({:content => params[:content], :title => params[:title], :tag_list => params[:tag_list]})

          Entities::NoteEntity.represent(note)
        end

        desc 'Destroy note.'
        delete '/:id' do
          Entities::NoteEntity.represent(Note.destroy(params[:id]))
        end
      end
    end
  end
end