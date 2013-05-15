module NotesSeeder
  # :fragment is used for note recognition since the rest of the content is randomy generated.
  TEST_NOTES_ATTRS = [
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

  SAMPLE_ATTRS = [
      {:tags => 'alpha, beta, gamma', :title => 'First note'},
      {:tags => 'beta, gamma', :title => 'Second note', :fragment => "poo"},
      {:tags => 'alpha', :title => 'Third note'},
      {:tags => '', :title => 'Fourth note'},
      {:tags => 'gamma, alpha', :title => 'Fifth note'},
  ]

  # @param [User] user
  # @param [Array] attributes
  # @param [Boolean] skip_save
  # @return [Array<Note>]
  def self.create(user, attributes: nil, skip_save: false)
    notes = []

    attributes = attributes || TEST_NOTES_ATTRS
    attributes.each do |attrs|
      note = Note.new

      if attrs[:id]
        note.id = attrs[:id]
      end

      note.title = attrs[:title]

      content = "#{Faker::Lorem.paragraphs(Random.rand(6) + 1).join("\n\n")}"
      if attrs[:fragment]
        content = "#{attrs[:fragment]}\n\n#{content}"
      end
      note.content = content

      note.tag_list = nil
      notes << note

      user.tag(note, :with => attrs[:tags], :on => :tags, :skip_save => skip_save)
    end

    unless skip_save
      user.notes = notes
      user.save
    end

    notes
  end

  # @param [User] user
  # @return [Array<Note>]
  def self.create_samples(user)
    create(user, attributes: SAMPLE_ATTRS)
  end
end