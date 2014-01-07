namespace :db do
  desc 'Fill database with sample data'
  task populate: :environment do
    current_year = Time.now.year
    ((current_year - 3)..current_year).each do |y|
      year = Year.new(year: y)
      year.save
      10.times do |work_index|
        year.works.create!(title: "Work #{work_index + 1}",
                           start_date: (work_index + 10).days.ago,
                           end_date: (work_index + 5).days.ago,
                           claim_date: (work_index + 3).days.ago,
                           receipt_date: (work_index + 2).days.ago,
                           memo: "Lorem ipsum",
                           orderer_id: 1,
                           worktype_id: 1,
                           quote_amount: 15000,
                           receipt_amount: 15000)
      end
    end

    16.times do |orderer_index|
      Orderer.create!(name: "Orderer #{orderer_index + 1}",
                      color_index: orderer_index + 1)
    end

    6.times do |worktype_index|
      Worktype.create!(name: "Worktype #{worktype_index + 1}")
    end
  end
end
