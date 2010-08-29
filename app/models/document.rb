class Document < ActiveRecord::Base
  belongs_to :document_status
  belongs_to :folder

  #has_attached_file :doc
  has_attached_file :doc,
      :storage => :s3,
      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
      :path => ":attachment/:id/:style.:extension",
      :bucket => 'bharatfilemanager'

  validates_attachment_presence :doc
  validates_attachment_size :doc, :less_than => 20.kilobytes
  validates_presence_of :title
  validates_uniqueness_of :title, :scope => :folder_id

  def status
    self.document_status.name
  end
  
end
