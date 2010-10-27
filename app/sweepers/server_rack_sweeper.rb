class ServerRackSweeper < ActionController::Caching::Sweeper
  observe ServerRack

  def after_save(serverRack)
    expire_cache(serverRack)
  end

  def after_destroy(serverRack)
    expire_cache(serverRack)
  end

  private

    def expire_cache(serverRack)
      expire_fragment dom_id(serverRack)
    end

end