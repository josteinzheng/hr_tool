require 'test_helper'

class UsedAnnualLeaveInfosControllerTest < ActionController::TestCase
  setup do
    @used_annual_leave_info = used_annual_leave_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:used_annual_leave_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create used_annual_leave_info" do
    assert_difference('UsedAnnualLeaveInfo.count') do
      post :create, used_annual_leave_info: { employee_id: @used_annual_leave_info.employee_id, number: @used_annual_leave_info.number, when: @used_annual_leave_info.when, whichyear: @used_annual_leave_info.whichyear }
    end

    assert_redirected_to used_annual_leave_info_path(assigns(:used_annual_leave_info))
  end

  test "should show used_annual_leave_info" do
    get :show, id: @used_annual_leave_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @used_annual_leave_info
    assert_response :success
  end

  test "should update used_annual_leave_info" do
    patch :update, id: @used_annual_leave_info, used_annual_leave_info: { employee_id: @used_annual_leave_info.employee_id, number: @used_annual_leave_info.number, when: @used_annual_leave_info.when, whichyear: @used_annual_leave_info.whichyear }
    assert_redirected_to used_annual_leave_info_path(assigns(:used_annual_leave_info))
  end

  test "should destroy used_annual_leave_info" do
    assert_difference('UsedAnnualLeaveInfo.count', -1) do
      delete :destroy, id: @used_annual_leave_info
    end

    assert_redirected_to used_annual_leave_infos_path
  end
end
