class Voluntary::Api::V1::CommunitiesController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    options = {}
  
    options[:json] = Community.paginate page: params[:page], per_page: 10
    
    options[:meta] = { 
      pagination: {
        total_pages: options[:json].total_pages, current_page: options[:json].current_page,
        previous_page: options[:json].previous_page, next_page: options[:json].next_page
      }
    }
    
    respond_with do |format|
      format.json { render options }
    end
  end
  
  def show
    respond_to do |format|
      format.json do
        render json: Community.friendly.find(params[:id])
      end
    end
  end
  
  def create
    current_user.organizations.find(params[:community][:organization_id])
    resource = Community.create params[:community]
    
    respond_to do |format|
      format.json do
        render json: resource.persisted? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def update
    resource = current_user.communities.friendly.find params[:id]
    resource.update_attributes params[:community]
    
    respond_to do |format|
      format.json do
        render json: resource.valid? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def destroy
    resource = current_user.communities.friendly.find params[:id]
    resource.destroy
    
    respond_to do |format|
      format.json do
        render json: if resource.persisted?
          { error: I18n.t('activerecord.errors.models.resource.attributes.base.deletion_failed') }
        else
          {}
        end
      end
    end
  end
end