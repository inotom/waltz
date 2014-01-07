class Work < ActiveRecord::Base
  belongs_to :year
  default_scope -> { order('start_date DESC') }
  validates :year_id, presence: true
  validates :start_date, presence: true
  validates :title, presence: true, length: { maximum: 255 }

  after_initialize do
    self.start_date = Time.now if self.start_date.nil?
  end

  def orderer
    o = Orderer.where("id = ?", self.orderer_id)
    o.first.name unless o.empty?
  end

  def orderer_color
    o = Orderer.where("id = ?", self.orderer_id)
    if o.empty?
      "0"
    else
      o.first.color_index
    end
  end

  def worktype
    w = Worktype.where("id = ?", self.worktype_id)
    w.first.name unless w.empty?
  end

  def year
    Year.where("id = ?", self.year_id).first
  end
end
