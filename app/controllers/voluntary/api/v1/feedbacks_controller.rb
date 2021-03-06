class Voluntary::Api::V1::FeedbacksController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    options = {}
  
    community = Community.friendly.find(params[:community_slug])
    collection = community.feedbacks.includes(:user)
    collection = collection.for_category(community.id, params[:category_slug]) if params[:category_slug].present?
    collection = collection.where(feedback_type: params[:feedback_type]) if params[:feedback_type].present?
    options[:json] = collection.order('feedbacks.created_at DESC').paginate page: params[:page], per_page: 10
    
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
    resource = Community.friendly.find(params[:community_slug]).feedbacks.friendly.find(params[:id])
    
    if current_user
      resource.positive = Feedback.likes_or_dislikes_for(current_user, [resource.id])[resource.id].try(:positive)
    end
      
    respond_to do |format|
      format.json do
        render json: resource
      end
    end
  end
  
  def create
    resource = Community.friendly.find(params[:feedback][:community_slug]).feedbacks.new params[:feedback]
    resource.user_id = current_user.id
    resource.save
    resource.category_ids = params[:feedback][:category_ids] || [] if resource.persisted?
    
    respond_to do |format|
      format.json do
        render json: resource.persisted? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def update
    resource = Community.friendly.find(params[:feedback][:community_slug]).feedbacks.friendly.find(params[:id])
    
    raise CanCan::AccessDenied unless resource.user_id == current_user.id
    
    resource.update_attributes params[:feedback]
    resource.category_ids = params[:feedback][:category_ids] || [] if resource.valid?

    respond_to do |format|
      format.json do
        render json: resource.valid? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def destroy
    resource = Community.friendly.find(params[:community_slug]).feedbacks.friendly.find(params[:id])
    resource.destroy
    
    respond_to do |format|
      format.json do
        render json: if resource.persisted?
          { error: I18n.t('activerecord.errors.models.feedback.attributes.base.deletion_failed') }
        else
          {}
        end
      end
    end
  end
end