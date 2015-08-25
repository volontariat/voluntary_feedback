class AddFeedbackProduct < ActiveRecord::Migration
  def up
    if Product::Feedback.first
    else
      Product::Feedback.create(name: 'Feedback', text: 'Dummy') 
    end
  end
  
  def down
    if product = Product::Feedback.first
      product.destroy
    end
  end
end