require 'test_helper'

class OrganizationsControllerTest < ActionController::TestCase
  before do
    @proj1 = create(:project)
    @proj2 = create(:project)
    @proj3 = create(:project)
    @organization = @proj1.organization
    @account = create(:account, organization_id: @organization.id)
    create(:position, account: @account, project: @proj1, organization: @organization)
    create(:position, account: @account, project: @proj2, organization: @proj2.organization)
    create(:position, account: @account, project: @proj3, organization: @proj3.organization)
  end

  it '#outside_projects allows viewing by unlogged users' do
    login_as nil
    get :outside_projects, id: @organization
    must_respond_with :ok
  end

  it '#outside_projects gracefully handles non-existant organizations' do
    get :outside_projects, id: 'I_AM_A_BANANA'
    must_respond_with :not_found
  end

  it '#affiliated_committers allows viewing by unlogged users' do
    login_as nil
    get :affiliated_committers, id: @organization
    must_respond_with :ok
  end

  it '#affiliated_committers gracefully handles non-existant organizations' do
    get :affiliated_committers, id: 'I_AM_A_BANANA'
    must_respond_with :not_found
  end

  it 'should return affiliated projects for unlogged users' do
    login_as nil
    get :projects, id: @organization
    must_respond_with :ok
    assigns(:affiliated_projects).count.must_equal 1
  end

  it 'outside_committers' do
    get :outside_committers, id: @organization
    must_respond_with :ok
  end
end