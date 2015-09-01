class Voluntary::Api::V1::FeedbacksController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    options = {}
  
    community = Community.friendly.find(params[:community_slug])
    collection = community.feedbacks.includes(:user)
    collection = collection.for_category(community.id, params[:category_slug]) if params[:category_slug].present?
    collection = collection.where(feedback_type: params[:feedback_type]) if params[:feedback_type].present?
    options[:json] = collection.paginate page: params[:page], per_page: 10
    
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
    
    if resource.persisted?
      params[:feedback][:category_ids].each do |category_id|
        resource.categories << CommunityCategory.find(category_id)
      end
    end
    
    respond_to do |format|
      format.json do
        render json: resource.persisted? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def update
    resource = Community.friendly.find(params[:feedback][:community_slug]).feedbacks.friendly.find(params[:id])
    resource.update_attributes params[:feedback]
    
    if resource.valid?
      params[:feedback][:category_ids] ||= []
      
      resource.categories.select{|c| !params[:feedback][:category_ids].map(&:to_i).include?(c.id)}.each do |category|
        resource.categories.delete category
      end
      
      categories = resource.categories.where('community_categories.id IN(?)', params[:feedback][:category_ids])
      
      params[:feedback][:category_ids].each do |category_id|
        next if categories.map(&:id).include? category_id.to_i
          
        resource.categories << CommunityCategory.find(category_id)
      end
    end
    
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