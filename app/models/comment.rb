class Comment < ActiveRecord::Base
  attr_accessible :body
  
  default_scope order("created_at ASC")
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :author, :class_name => 'Member', :foreign_key => 'author_id'
end
