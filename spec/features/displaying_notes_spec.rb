require 'spec_helper'

describe 'displaying notes', :notes_feature => true, :login => true do
  context 'default' do
    before do
      @note = FactoryGirl.create(:note, :content => 'Lorem ipsum')
      visit '/'
    end

    it 'shows note\'s tag list' do
      within note_element(@note.id) do
        page.should have_text(@note.tag_list.to_s)
      end
    end

    it 'shows note\'s content' do
      within note_element(@note.id) do
        page.should have_text(@note.content)
      end
    end

    it 'shows formatted note\'s creation time' do
      within note_element(@note.id) do
        page.should have_text(@note.created_at.strftime("%d-%m-%Y %H:%M"))
      end
    end

    it 'shows note\'s title' do
      within note_element(@note.id) do
        page.should have_text(@note.title)
      end
    end

    describe 'buttons' do
      it 'shows "expand" button' do
        within note_element(@note.id) do
          page.should have_css "a[title='#{NotesConstants::EXPAND_TITLE}']"
        end
      end

      it 'shows "edit" button' do
        within note_element(@note.id) do
          page.should have_css "a[title='#{NotesConstants::EDIT_TITLE}']"
        end
      end

      it 'shows "delete" button' do
        within note_element(@note.id) do
          page.should have_css "a[title='#{NotesConstants::DELETE_TITLE}']"
        end
      end
    end
  end

  context 'when content is too long' do
    before :all do
      @limit = 400
      @note = FactoryGirl.create(:note, :content => 'foo' * (@limit * 2))
      visit '/'
    end

    it 'truncates it' do
      within note_element(@note.id) do
        page.should have_text(@note.content[0..(@limit-1)] + " …")
      end
    end
  end

  describe 'note controls' do
    before do
      @note = FactoryGirl.create(:note)
      visit '/'
    end

    it 'doesn\'t show menu by default' do
      within note_element(@note.id) do
        page.all('.control').each do |node|
          node.visible?.should == false
        end
      end
    end

    it 'shows menu when focused' do
      within note_element(@note.id) do
        page.execute_script("$('#{note_element(@note.id)}').trigger('mouseenter')")
        page.all('.control').each do |node|
          node.visible?.should == true
        end
      end
    end

    it 'hides menu when blurred' do
      within note_element(@note.id) do
        page.execute_script("$('#{note_element(@note.id)}').trigger('mouseenter')")
        page.execute_script("$('#{note_element(@note.id)}').trigger('mouseleave')")
        page.all('.control').each do |node|
          node.visible?.should == false
        end
      end
    end
  end
end