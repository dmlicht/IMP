FactoryGirl.define do
	factory :reimbursement do
		title "Snacks"
		location "Snack Store"
		quantity "$20"
		description "We ate so many burger cookies. I threw up and cried."
		association :user
	end
end