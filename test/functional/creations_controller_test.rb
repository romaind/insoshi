require File.dirname(__FILE__) + '/../test_helper'

class CreationsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:creations)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_creation
    assert_difference('Creation.count') do
      post :create, :creation => { }
    end

    assert_redirected_to creation_path(assigns(:creation))
  end

  def test_should_show_creation
    get :show, :id => creations(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => creations(:one).id
    assert_response :success
  end

  def test_should_update_creation
    put :update, :id => creations(:one).id, :creation => { }
    assert_redirected_to creation_path(assigns(:creation))
  end

  def test_should_destroy_creation
    assert_difference('Creation.count', -1) do
      delete :destroy, :id => creations(:one).id
    end

    assert_redirected_to creations_path
  end
end
