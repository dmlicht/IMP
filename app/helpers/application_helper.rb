module ApplicationHelper
  def title
  	(@sub_title.nil?) ? "IMP Reimbursements" : "IMP Reimbursements | " + @sub_title
  end
end
