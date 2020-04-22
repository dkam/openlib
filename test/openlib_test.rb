# frozen_string_literal: true

require 'test_helper'
require 'byebug'

class OpenlibTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Openlib::VERSION
  end

  def test_it_does_something_useful
    TESTCASES.each do |tc|
      b = Openlib::Book.new(id: tc.dig(:isbn))
      b.view = tc.dig(:view)
      b.data = tc.dig(:data)

      assert_equal tc.dig(:data).first.last.dig('authors').map { |e| e.dig('name') }, b.authors
      assert_equal tc.dig(:data).first.last.dig('title'), b.title
    end
  end

  TESTCASES = [
    isbn: '9780316030571',
    view: { 'ISBN:9780316030571' => { 'bib_key' => 'ISBN:9780316030571', 'preview' => 'borrow', 'thumbnail_url' => 'https://covers.openlibrary.org/b/id/2379038-S.jpg', 'preview_url' => 'https://archive.org/details/useofweapons00bank_0', 'info_url' => 'https://openlibrary.org/books/OL10426208M/Use_of_Weapons' } },
    data: { 'ISBN:9780316030571' => { 'publishers' => [{ 'name' => 'Orbit' }], 'identifiers' => { 'isbn_13' => ['9780316030571'], 'openlibrary' => ['OL10426208M'], 'isbn_10' => ['0316030570'], 'librarything' => ['141'], 'goodreads' => ['3395563'] }, 'title' => 'Use of Weapons', 'url' => 'https://openlibrary.org/books/OL10426208M/Use_of_Weapons', 'number_of_pages' => 480, 'cover' => { 'small' => 'https://covers.openlibrary.org/b/id/2379038-S.jpg', 'large' => 'https://covers.openlibrary.org/b/id/2379038-L.jpg', 'medium' => 'https://covers.openlibrary.org/b/id/2379038-M.jpg' }, 'subjects' => [{ 'url' => 'https://openlibrary.org/subjects/fiction', 'name' => 'Fiction' }, { 'url' => 'https://openlibrary.org/subjects/science_fiction', 'name' => 'Science Fiction' }, { 'url' => 'https://openlibrary.org/subjects/science_fiction_&_fantasy', 'name' => 'Science Fiction & Fantasy' }, { 'url' => 'https://openlibrary.org/subjects/long_now_manual_for_civilization', 'name' => 'Long Now Manual for Civilization' }, { 'url' => 'https://openlibrary.org/subjects/space_warfare', 'name' => 'Space warfare' }], 'subject_people' => [{ 'url' => 'https://openlibrary.org/subjects/person:cheradenine_zakalwe', 'name' => 'Cheradenine Zakalwe' }, { 'url' => 'https://openlibrary.org/subjects/person:diziet_sma', 'name' => 'Diziet Sma' }, { 'url' => 'https://openlibrary.org/subjects/person:skaffen-amtiskaw', 'name' => 'Skaffen-Amtiskaw' }], 'key' => '/books/OL10426208M', 'authors' => [{ 'url' => 'https://openlibrary.org/authors/OL6924809A/Iain_M._Banks', 'name' => 'Iain M. Banks' }], 'publish_date' => 'July 28, 2008', 'ebooks' => [{ 'checkedout' => false, 'formats' => {}, 'preview_url' => 'https://archive.org/details/useofweapons00bank_0', 'borrow_url' => 'https://openlibrary.org/books/OL10426208M/Use_of_Weapons/borrow', 'availability' => 'borrow' }] } }
  ].freeze
end
