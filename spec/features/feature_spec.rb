# frozen_string_literal: true

feature 'index page' do
  scenario 'create a index page for the app' do
    visit('/bookmarks/new')
    expect(page).to have_content 'Bookmark Manager'
  end
end

feature 'view bookmarks' do
  scenario 'view a list of bookmarked URLs' do
    Bookmark.create(url: 'http://www.destroyallsoftware.com', title: 'Destroy All')
    Bookmark.create(url: 'http://www.google.com', title: 'Google')
    Bookmark.create(url: 'http://www.makers.tech', title: 'Makers')

    visit('/bookmarks')

    expect(page).to have_link('Destroy All', href: 'http://www.destroyallsoftware.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
    expect(page).to have_link('Makers', href: 'http://www.makers.tech')
  end
end

feature 'add bookmarks' do
  scenario 'complete a form to add a bookmark' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.facebook.com')
    fill_in('title', with: 'Facebook')
    click_button('add')
    expect(page).to have_link('Facebook', href: 'http://www.facebook.com')
  end
end

feature 'delete bookmark' do
  scenario 'click delete and bookmark is removed' do
    visit('/bookmarks/new')
    fill_in('url', with: 'http://www.facebook.com')
    fill_in('title', with: 'Facebook')
    click_button('add')
    click_button('delete')
    expect(page).not_to have_link('Facebook', href: 'http://www.facebook.com')
  end
end
