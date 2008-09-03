require 'test_helper'

class BetaCouponsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:beta_coupons)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_beta_coupon
    assert_difference('BetaCoupon.count') do
      post :create, :beta_coupon => { }
    end

    assert_redirected_to beta_coupon_path(assigns(:beta_coupon))
  end

  def test_should_show_beta_coupon
    get :show, :id => beta_coupons(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => beta_coupons(:one).id
    assert_response :success
  end

  def test_should_update_beta_coupon
    put :update, :id => beta_coupons(:one).id, :beta_coupon => { }
    assert_redirected_to beta_coupon_path(assigns(:beta_coupon))
  end

  def test_should_destroy_beta_coupon
    assert_difference('BetaCoupon.count', -1) do
      delete :destroy, :id => beta_coupons(:one).id
    end

    assert_redirected_to beta_coupons_path
  end
end
