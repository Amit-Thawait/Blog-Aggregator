describe ReadBlogsController do
  describe "Get Index" do
     it "assigns all blogs details to @blog_objects" do     
      get :index 
      assigns(:blog_objects).should_not be_nil          
      response.should render_template(:index) 
     end
  end 
end