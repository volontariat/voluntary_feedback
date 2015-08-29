class Voluntary::Api::V1::RepliesController < ActionController::Base
  include Voluntary::V1::BaseController
  
  respond_to :json
  
  def index
    options = {}
    collection = Feedback.find(params[:feedback_id]).replies.includes(:user).paginate page: params[:page], per_page: 10
    
    options[:meta] = { 
      pagination: {
        total_pages: collection.total_pages, current_page: collection.current_page,
        previous_page: collection.previous_page, next_page: collection.next_page
      }
    }
    
    collection = collection.to_a
    
    if current_user
      likes = Reply.likes_or_dislikes_for(current_user, collection.map(&:id))
      
      collection.map! do |reply|
        reply.positive = likes[reply.id].try(:positive)
        reply
      end
    end

    options[:json] = collection
    
    respond_with do |format|
      format.json { render options }
    end
  end
  
  def show
    respond_to do |format|
      format.json do
        render json: Reply.find(params[:id])
      end
    end
  end
  
  def create
    resource = Feedback.find(params[:reply][:feedback_id]).replies.new params[:reply]
    resource.user_id = current_user.id
    resource.save
    
    respond_to do |format|
      format.json do
        render json: resource.persisted? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def update
    resource = Reply.find(params[:id])
    
    raise CanCan::AccessDenied unless resource.user_id == current_user.id
    
    resource.update_attributes params[:reply]
    
    respond_to do |format|
      format.json do
        render json: resource.valid? ? resource : { errors: resource.errors.to_hash }
      end
    end
  end
  
  def destroy
    resource = Reply.find(params[:id])
    
    raise CanCan::AccessDenied unless resource.user_id == current_user.id
    
    resource.destroy
    
    respond_to do |format|
      format.json do
        render json: if resource.persisted?
          { error: I18n.t('activerecord.errors.models.reply.attributes.base.deletion_failed') }
        else
          {}
        end
      end
    end
  end
end