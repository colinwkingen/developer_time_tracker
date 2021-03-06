require 'rails_helper'
require 'devise'

describe 'the add activity to day process' do

  before do
    user = FactoryGirl.create(:user, :email => "mail@mail.mail")
    tag = FactoryGirl.create(:tag)
    login_as(user, :scope => :user, :run_callbacks => false)
  end

  it 'takes you to a page where you can add an activity to a day' do
    visit days_path
    click_link 'Log a Day'
    select 'Thursday', :from => 'Date'
    fill_in 'Datefield', :with => '03/24/1985'
    click_on 'Create Day'
    click_link 'Thursday'
    expect(page).to have_content 'Thursday'
    Warden.test_reset!
  end

  it 'takes you to a page where you can specify the activity to add' do
    visit days_path
    # user = FactoryGirl.create(:user)
    # login_as(user, :scope => :user)
    click_link 'Log a Day'
    select 'Thursday', :from => 'Date'
    fill_in 'Datefield', :with => '03/24/1985'
    click_on 'Create Day'
    click_link 'Thursday'
    click_on 'Add Activity'
    expect(page).to have_content 'Tag this activity for Thursday'
    Warden.test_reset!
  end

  it 'takes you to the add activity page and lets you return without adding' do
    visit days_path
    click_link 'Log a Day'
    select 'Thursday', :from => 'Date'
    fill_in 'Datefield', :with => '03/24/1985'
    click_on 'Create Day'
    click_link 'Thursday'
    click_on 'Back'
    expect(page).to have_content 'Days'
    Warden.test_reset!
  end

  it 'takes you to a page where you can create an activity' do
    visit days_path
    click_link 'Log a Day'
    select 'Thursday', :from => 'Date'
    fill_in 'Datefield', :with => '03/24/1985'
    click_on 'Create Day'
    click_link 'Thursday'
    click_on 'Add Activity'
    select 'Baking Cupcakes', :from => 'Activity'
    click_on 'Add A Tag'
    expect(page).to have_content 'Baking Cupcakes'
    Warden.test_reset!
  end

  it 'lets you delete a logged day from the main list' do
    visit days_path
    click_link 'Log a Day'
    select 'Thursday', :from => 'Date'
    fill_in 'Datefield', :with => '03/24/1985'
    click_on 'Create Day'
    click_link 'Thursday'
    click_on 'Delete'
    expect(page).to have_content 'Days'
    Warden.test_reset!
  end

end
