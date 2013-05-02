module Seeder
  # :fragment is used for note recognition since the rest of the content is randomy generated.
  NOTES_ATTRIBUTES = [
      {:id => 1, :tags => 'zeus, athena, poseidon', :fragment => 'alpha'},
      {:id => 2, :tags => '', :fragment => 'beta'},
      {:id => 3, :tags => 'athena, zeus', :fragment => 'gamma', :title => 'furion'},
      {:id => 4, :tags => 'poseidon', :fragment => 'delta'},
      {:id => 5, :tags => 'zeus, apollo', :fragment => 'epsilon', :title => 'naix'},
      {:id => 6, :tags => 'athena, apollo', :fragment => 'zeta'},
      {:id => 7, :tags => 'apollo, poseidon, athena', :fragment => 'eta'},
      {:id => 8, :tags => 'zeus', :fragment => 'theta'},
      {:id => 9, :tags => '', :fragment => 'iota'},
      {:id => 10, :tags => 'poseidon', :fragment => 'kappa'},
      {:id => 11, :tags => 'apollo, poseidon', :fragment => 'lambda', :title => 'lina'},
      {:id => 12, :tags => 'apollo, zeus, athena, poseidon', :fragment => 'mu'}
  ]

  # @return [Array<Note>]
  def self.create_notes
    notes = []

    NOTES_ATTRIBUTES.each do |attrs|
      note = FactoryGirl.create(:note)
      note.id = attrs[:id]
      note.tag_list = attrs[:tags]
      note.title = attrs[:title]
      note.content = "#{attrs[:fragment]}\n\n#{note.content}"
      note.save!
      notes << note
    end

    notes
  end
end