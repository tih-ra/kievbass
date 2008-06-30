class UserSubscribe < ActiveRecord::Base
belongs_to :user
#before_save :make_subscribe_params
belongs_to :subscribtable, :polymorphic => true



end
