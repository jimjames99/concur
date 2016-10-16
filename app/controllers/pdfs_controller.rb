class PdfsController < ApplicationController

  PAGES = %w(overview clear_fraud clear_recent_history clear_risk_indicators)

  def new
    @pages = PAGES.dup

  end

  def create
    return(redirect_to(new_pdf_url)) unless pages_params[:pages].present?
    new_doc = CombinePDF.new
    pages_params[:pages].split(',').compact.each do |page|
      new_doc << CombinePDF.load("#{page}.pdf") if PAGES.include?(page)
    end
    new_doc.number_pages(
      location: :bottom,
      font_size: 9,
      number_format: 'Page %s'
    )
    new_doc.author = 'Jim James' # current_user.name
    new_doc.title = "Prepared for #{pages_params[:customer]} on #{Date.today}" if pages_params[:customer].present?

    send_data new_doc.to_pdf, filename: "combined_#{Time.now.to_s('%H%M%S')}.pdf", type: 'application/pdf'
  end

  private

  def pages_params
    params.permit([:pages, :customer])
  end

end
