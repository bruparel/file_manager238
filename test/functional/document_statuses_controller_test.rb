require 'test_helper'

class DocumentStatusesControllerTest < ActionController::TestCase

  setup {Role.create(:name => 'eclient', :display_name => 'External Client')}

  context "on GET to :index" do
    setup do
      @admin = Factory(:admin_user)
      set_current_user(@admin)
      get :index
    end
    should assign_to(:current_objects)
    should assign_to(:search_fields_array)
    should assign_to(:controller_name)
    should assign_to(:klass)
    #should_render_a_form
    should respond_with(:success)
    should render_template(:index)
  end

  context "on GET to :new" do
    setup do
      @admin = Factory(:admin_user)
      set_current_user(@admin)
      get :new
    end
    should_not set_the_flash
    should assign_to(:controller_name)
    should assign_to(:klass)
    should assign_to(:current_object)
    #should_render_a_form
    should respond_with(:success)
    should render_template(:new)
  end

  context "on POST to :create with valid document status data" do
    setup do
      @admin = Factory(:admin_user)
      post :create, {:document_status => {:name => 'Test Status'}}, {:user_id => @admin.id}
    end
    should "increment the document count to 1 upon creation" do
      assert_equal 1, DocumentStatus.count
    end
    should set_session(:user_id) { @admin.id }
    should assign_to(:current_object)
    should set_the_flash.to(/was successfully created./)
    should redirect_to("the document statuses' list") { document_statuses_path }
  end

  context "on GET to :edit for document status record" do
    setup do
      @admin = Factory(:admin_user)
      @document_status = Factory(:document_status)
      get :edit, {:id => @document_status.id}, {:user_id => @admin.id}
    end
    should assign_to(:current_object)
    should respond_with(:success)
    should render_template(:edit)
    should_not set_the_flash
  end

  context "on PUT to :update an existing document status record" do
    setup do
      @admin = Factory(:admin_user)
      @document_status = Factory(:document_status)
      put :update, { :id => @document_status.id, :document_status => {:name => 'New Status'}},
                   {:user_id => @admin.id}
    end
    should "Keep the document status count to 1 upon update" do
      assert_equal 1, DocumentStatus.count
    end
    should set_session(:user_id) { @admin.id }
    should assign_to(:current_object)
    should set_the_flash.to(/was successfully updated./)
    should redirect_to("the document statuses' list") { document_statuses_path }
  end

  context "on GET to :show for an existing document status record" do
    setup do
      @admin = Factory(:admin_user)
      @document_status = Factory(:document_status)
      get :show, {:id => @document_status.id}, {:user_id => @admin.id}
    end
    should assign_to(:current_object)
    should respond_with(:success)
    should render_template(:show)
    should_not set_the_flash
  end

  context 'on DELETE to :destroy for a document status record' do
    setup do
      @admin = Factory(:admin_user)
      @document_status = Factory(:document_status)
      delete :destroy, {:id => @document_status.id}, {:user_id => @admin.id}
    end
    should assign_to(:current_object)
    should set_the_flash.to(/Sucessfully destroyed/)
    should respond_with(:redirect)
    should redirect_to("Document statuses' list") {document_statuses_path }
  end

end
