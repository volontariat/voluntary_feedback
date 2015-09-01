class Voluntary::Api::V1::CommunityCategoriesController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    options = {}
  
    community = Community.friendly.find(params[:community_slug])
    
    collection = if params[:feedback_slug] 
      community.feedbacks.friendly.find(params[:feedback_slug]).categories
    else  
      community.categories
    end
    
    options[:json] = collection.paginate page: params[:page], per_page: params[:feedback_slug] ? 50 : 10
    
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
        render json: Community.friendly.find(params[:community_slug]).categories.friendly.find(params[:id])
      end
    end
  end
  
  def create
    community = Community.friendly.find(params[:community_category][:community_slug])
    
    raise CanCan::AccessDenied unless community.organization.user_id == current_user.id
    
    resource = community.categories.new params[:community_category]
    resource.save
    
    respond_to do |format|
      format.json do
        render json: resource.persisted? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def update
    community = Community.friendly.find(params[:community_category][:community_slug])
    
    raise CanCan::AccessDenied unless community.organization.user_id == current_user.id
    
    resource = community.categories.friendly.find(params[:id])
    resource.update_attributes params[:community_category]
    
    respond_to do |format|
      format.json do
        render json: resource.valid? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def destroy
    community = Community.friendly.find(params[:community_slug])
    
    raise CanCan::AccessDenied unless community.organization.user_id == current_user.id
    
    resource = community.categories.friendly.find(params[:id])
    resource.destroy
    
    respond_to do |format|
      format.json do
        render json: if resource.persisted?
          { error: I18n.t('activerecord.errors.models.community_category.attributes.base.deletion_failed') }
        else
          {}
        end
      end
    end
  end
end