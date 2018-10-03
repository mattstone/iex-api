request       = require 'superagent'
io            = require 'socket.io-client'
io            = require 'socket.io-client'
async         = require 'async'
util          = require 'util'
h             = require './helpers'

axios         = require('axios')

module.exports = class iexAPI

  constructor: () ->
    @version  = 1.0
    @endPoint = "https://api.iextrading.com/1.0"

  # HTTP GET Requests
  iexRequest: (url, cb) =>
    axios.get(url).then (response) =>
      cb null, response
    .catch (err) =>
      cb err, null

  iexURL: (path) -> "#{@endPoint}/#{path}"

  # IEX
  attribution: -> "Data provided for free by IEX."

  attributionHTML: () ->
    "#{@attribution()} View IED's <a href=\"https://iextrading.com/api-exhibit-a/\" _target=\"Blank\">Terms of Use\"</a>"

  # Stocks
  symbols: (cb) -> @iexRequest @iexURL("ref-data/symbols"), cb

  company:  (symbol, cb) -> @iexRequest @iexURL("stock/#{symbol}/company"),  cb
  earnings: (symbol, cb) -> @iexRequest @iexURL("stock/#{symbol}/earnings"), cb
  stats:    (symbol, cb) -> @iexRequest @iexURL("stock/#{symbol}/stats"),    cb
  largestTrades: (symbol, cb) -> @iexRequest @iexURL("stock/#{symbol}/largest-trades"),    cb
  peers:    (symbol, cb) -> @iexRequest @iexURL("stock/#{symbol}/peers"),    cb
  relevant: (symbol, cb) -> @iexRequest @iexURL("stock/#{symbol}/relevant"), cb

  chart:      (symbol, timeframe, cb) -> @iexRequest @iexURL("stock/#{symbol}/chart/#{timeframe}"),     cb
  financials: (symbol, timeframe, cb) -> @iexRequest @iexURL("stock/#{symbol}/financials?period=#{timeframe}"), cb
  dividends:  (symbol, timeframe, cb) -> @iexRequest @iexURL("stock/#{symbol}/dividends/#{timeframe}"), cb

  # Crypto
  crypto: (cb)     -> @iexRequest @iexURL("stock/market/crypto"),       cb

  # News
  newsMarket: (cb)         -> @iexRequest @iexURL("stock/market/news/last.25"), cb
  newsStock:  (symbol, cb) -> @iexRequest @iexURL("stock/#{symbol}/news"),      cb

  #Batch
  batchSingleSymbol: (symbol,  types, timeframe, cb) -> @iexRequest @iexURL("stock/#{symbol}/batch?types=#{types}&range=#{timeframe}"), cb
  batchMultiSymbol:  (symbols, types, timeframe, cb) -> @iexRequest @iexURL("stock/market/batch?symbols=#{symbols}&types=#{types}&range=#{timeframe}"), cb
