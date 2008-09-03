require File.dirname(__FILE__) + '/../spec_helper'
include ActivitiesHelper
include SharedHelper
include PeopleHelper
describe ActivitiesHelper do

  before(:each) do
    @current_person = login_as(:aaron)
    # It sucks that RSpec makes me do this.
    self.stub!(:logged_in?).and_return(true)
    self.stub!(:current_person).and_return(people(:aaron))
  end
  
  it "should have the right message for a wall comment" do
    # Quentin comments an Aaron's wall
    person = @current_person
    commenter = people(:quentin)
    comment = person.comments.create(:body => "The body",
                                     :commenter => commenter)
    activity = Activity.find_by_item_id(comment)
    # The message works even if logged in as Kelly.
    login_as(:kelly)
    feed_message(activity).should =~ /#{commenter.name}/
    feed_message(activity).should =~ /#{person.name}'s wall/
    # The message works even if logged in as the commenter
    login_as(commenter)
    feed_message(activity).should =~ /#{commenter.name}/
    feed_message(activity).should =~ /#{person.name}'s wall/
  end

  it "should have the right message for an own-comment" do
    person = @current_person
    commenter = person
    comment = person.comments.create(:body => "The body",
                                     :commenter => commenter)
    activity = Activity.find_by_item_id(comment)
    login_as(:kelly)
    feed_message(activity).should =~ /#{commenter.name}/
    feed_message(activity).should =~ /#{commenter.name}'s wall/
  end
  
  
  it "should have the right message for a blog comment" do
    post = posts(:blog_post)
    comment = post.comments.create(:body => "The body",
                                   :commenter => @current_person)
    activity = Activity.find_by_item_id(comment)
    feed_message(activity).should =~ /blog post/
  end
  
  it "should have the right message for a photo" do
    activity = Activity.new(:item => mock_photo, :person => @current_person)
    feed_message(activity).should =~ /profile picture/
  end

end
