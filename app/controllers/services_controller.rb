class ServicesController < ApplicationController
    before_action :set_post  # Set the post for the service
    before_action :set_service, only: [:edit, :update, :destroy]  # Set the specific service for edit, update, and destroy
  
    # GET /posts/:post_id/services/new
    def new
      @service = @post.services.build
    end
  
    # POST /posts/:post_id/services
    def create
      @service = @post.services.build(service_params)
      if @service.save
        redirect_to @post, notice: 'Service was successfully created.'
      else
        render :new
      end
    end
  
    # GET /posts/:post_id/services/:id/edit
    def edit
    end
  
    # PATCH/PUT /posts/:post_id/services/:id
    def update
      if @service.update(service_params)
        redirect_to @post, notice: 'Service was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /posts/:post_id/services/:id
    def destroy
      @service.destroy
      redirect_to @post, notice: 'Service was successfully destroyed.'
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_service
      @service = @post.services.find(params[:id])
    end
  
    def service_params
      params.require(:service).permit(:name, :description, :price, :image)
    end
  end
  