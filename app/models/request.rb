class Request
  include ActiveModel::Validations
  validates_presence_of :weight, :message => "не должен быть пустым"
  validates :weight, :numericality => { :greater_than => 0, :less_than_or_equal_to => :max_weight, :message => "должен быть больше 0 и меньше"}, :allow_blank => true

  attr_reader :weight
  attr_accessor :max_weight

  def initialize(args)
    @weight = args[:weight]
  end
end