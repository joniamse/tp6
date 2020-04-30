class Turn < ApplicationRecord
	belongs_to :medic
	belongs_to :patient

	validates :price, presence: true
	
	validate :calculate_discount
	validate :turn_time

	def calculate_discount
		if medic.speciality.charge < patient.social_work.discount
			t = 0
		else
			t = medic.speciality.charge - patient.social_work.discount
		end
		t
	end

	def turn_time
        for t in Turn.all
            if  (t.date.year== date.year) and (t.date.month == date.month) and (t.date.day == date.day) and (t.date.hour == date.hour) and  (t.date.min == date.min)
                if (t.medic == medic) and (t.patient == patient)
                    errors.add(:date, "That date is already busy for that medic and patient")
                elsif (t.medic == medic)
                    errors.add(:date, "That date is already busy for that medic")
                elsif (t.patient == patient)
                    errors.add(:date, "That date is already busy for that patient")
                end
            end

            if (date < Time.now) 
                errors.add(:date, "You can't select a date from the past")
                break
            end
        end
        date
    end

end
