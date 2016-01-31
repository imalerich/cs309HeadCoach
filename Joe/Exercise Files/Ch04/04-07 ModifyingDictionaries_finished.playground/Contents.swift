//: ## Modifying Dictionaries

var stockPrices = ["AAPL": 110.37, "GOOG": 606.25, "MSFT": 43.5]

stockPrices["AMZN"] = 504.72

stockPrices["AAPL"] = 114.45

stockPrices["AMZN"] = nil

print(stockPrices)

stockPrices.removeAll()

stockPrices["DMI"] = 17.25

let dunderMifflinStockPrice = stockPrices.removeValueForKey("DMI")
