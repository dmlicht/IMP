FactoryGirl.define do
  factory :user do
  	first_name 'first'
  	last_name 'last'
  	email { "#{first_name}.#{last_name}@incentivementoringprogram.org".downcase }
  	provider 'google_oauth2'
  	uid '1902472324043272'
  end

  factory :first_name do |n|
  	"first#{n}"
  end
end
