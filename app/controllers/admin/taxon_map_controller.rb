class Admin::TaxonMapController < Spree::Admin::BaseController
  def new
    super
  end
  
  def edit
    super
  end
  
  def update
    super
  end
  
  def destroy
    super
  end

  def index
    @taxons = Spree::Taxon.find(:all)
    @taxons.each do |taxon|
      if !taxon.taxon_map
        taxon_map = Spree::TaxonMap.new(:product_type => '', :taxon_id => taxon.id, :priority => 0)
        taxon_map.save
        taxon.taxon_map = taxon_map
      end
    end
  end

  def create
    Spree::TaxonMap.delete(Spree::TaxonMap.find(:all))
    params[:tax_id].each do |k, v|
      taxon_map = Spree::TaxonMap.new(:product_type => v, :taxon_id => k, :priority => params[:priority][k].to_i || 0)
      taxon_map.save
    end
    if Spree::TaxonMap.count == params[:tax_id].size
      flash[:notice] = "Google Base taxons mapping saved successfully."
    end
    redirect_to admin_taxon_map_index_url
  end
end
