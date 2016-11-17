module Manufacturer
  def set_company(company_name)
    self.company = company_name
  end

  def get_company
    self.company
  end

  protected

  attr_accessor :company

end