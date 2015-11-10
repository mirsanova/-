class Request
  include ActiveModel::Validations

  attr_accessor :weight

  validates :weight, :presence => {:message => 'Name cannot be blank, Task not saved'}
end
