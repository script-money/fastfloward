import KittyItemsMarket from Project.KittyItemsMarket

transaction() {

  let saleCollection: &KittyItemsMarket.SaleCollection
  let itemIDs: [UInt64]

  prepare(signer: AuthAccount) {
      // Borrows the signer's SaleCollection
      self.saleCollection = signer.borrow<&KittyItemsMarket.SaleCollection>(from: KittyItemsMarket.MarketStoragePath) 
          ?? panic("Could not borrow the signer's SaleCollection")
      self.itemIDs = self.saleCollection.getIDs()
  }

  execute {
      // Unlist all Kitty Items from sale
      for itemID in self.itemIDs {
        self.saleCollection.unlistSale(itemID: itemID)  
      }
  }
}
