class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	validates :user_id, presence: true  
	belongs_to :user   

	validates :image, presence: true


	has_attached_file :image, styles: { :medium => "640x480", :thumb => "300x300#"},
					  :convert_options => { :medium => "-quality 80 -interlace Plane" }
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end  