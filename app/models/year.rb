class Year < ActiveRecord::Base
  has_many :works
  validates :year, presence: true, uniqueness: true, inclusion: { in: 2000..2100 }
  default_scope -> { order('year DESC') }

  def total_quote
    total_amount(:quote_amount)
  end

  def total_receipt
    total_amount(:receipt_amount)
  end

  private

    def total_amount(column_name)
      total = 0
      self.works.each do |work|
        total += work[column_name] if work[column_name]
      end
      total
    end
end
