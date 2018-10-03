should  = require('chai').should()
IexAPI  = require '..'
util    = require "util"
async   = require 'async'

iex       = new IexAPI
symbol    = "AAPL"
timeframe = "5y"

describe 'IexAPI', ->

  it 'should have version', (done) ->
    iex.version.should.not.be.blank
    done()

  it 'should have endPoint', (done) ->
    iex.endPoint.should.not.be.blank
    done()

  it 'should have attribution', (done) ->
    iex.attribution().should.not.be.blank
    done()

  it 'should have attributionHTML', (done) ->
    iex.attributionHTML().should.not.be.blank
    done()


  describe 'Stocks', ->

    it 'should get all IEX symbols', (done) ->
      iex.symbols (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'array'

        for element in body.data
          element.symbol.should.exist
          element.name.should.exist
          element.isEnabled.should.exist
          element.type.should.exist
          element.iexId.should.exist
        done()

    it "should get #{symbol} company info", (done) ->
      iex.company symbol, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'object'
        body.data.symbol.should.exist
        body.data.companyName.should.exist
        body.data.exchange.should.exist
        body.data.industry.should.exist
        body.data.website.should.exist
        body.data.description.should.exist
        body.data.CEO.should.exist
        body.data.issueType.should.exist
        body.data.sector.should.exist
        body.data.tags.should.exist
        done()

    it "should get #{symbol} earnings info", (done) ->
      iex.earnings symbol, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'object'
        body.data.symbol.should.exist
        body.data.earnings.should.be.an 'array'

        for element in body.data.earnings
          element.actualEPS.should.exist
          element.consensusEPS.should.exist
          element.estimatedEPS.should.exist
          element.announceTime.should.exist
          element.numberOfEstimates.should.exist
          element.EPSSurpriseDollar.should.exist
          element.EPSReportDate.should.exist
          element.fiscalPeriod.should.exist
          element.fiscalEndDate.should.exist
          element.yearAgo.should.exist
          element.yearAgoChangePercent.should.exist
          element.estimatedChangePercent.should.exist
        done()

    it "should get #{symbol} stats info", (done) ->
      iex.stats symbol, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'object'

        body.data.companyName.should.exist
        body.data.marketcap.should.exist
        body.data.beta.should.exist
        body.data.week52high.should.exist
        body.data.week52low.should.exist
        body.data.week52change.should.exist
        body.data.shortInterest.should.exist
        body.data.shortDate.should.exist
        body.data.dividendRate.should.exist
        body.data.dividendYield.should.exist
        body.data.exDividendDate.should.exist
        body.data.latestEPS.should.exist
        body.data.latestEPSDate.should.exist
        body.data.sharesOutstanding.should.exist
        body.data.float.should.exist
        body.data.returnOnEquity.should.exist
        body.data.consensusEPS.should.exist
        body.data.numberOfEstimates.should.exist
        #body.data.EPSSurpriseDollar.should.exist
        body.data.EPSSurprisePercent.should.exist
        body.data.EBITDA.should.exist
        body.data.revenue.should.exist
        body.data.grossProfit.should.exist
        body.data.cash.should.exist
        body.data.debt.should.exist
        body.data.ttmEPS.should.exist
        body.data.revenuePerShare.should.exist
        body.data.revenuePerEmployee.should.exist
        body.data.peRatioHigh.should.exist
        body.data.peRatioLow.should.exist
        body.data.returnOnAssets.should.exist
        #body.data.returnOnCapital.should.exist
        body.data.profitMargin.should.exist
        body.data.priceToSales.should.exist
        body.data.priceToBook.should.exist
        body.data.day200MovingAvg.should.exist
        body.data.day50MovingAvg.should.exist
        #body.data.insiderPercent.should.exist
        body.data.shortRatio.should.exist
        body.data.year5ChangePercent.should.exist
        body.data.year2ChangePercent.should.exist
        body.data.year1ChangePercent.should.exist
        body.data.ytdChangePercent.should.exist
        body.data.month6ChangePercent.should.exist
        body.data.month3ChangePercent.should.exist
        body.data.month1ChangePercent.should.exist
        body.data.day5ChangePercent.should.exist
        body.data.day30ChangePercent.should.exist
        done()

    it "should get #{symbol} largestTrades info", (done) ->
      iex.largestTrades symbol, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'array'
        done()

    it "should get #{symbol} peers info", (done) ->
      iex.peers symbol, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'array'

        for element in body.data
          element.should.exist
        done()

    it "should get #{symbol} relevant info", (done) ->
      iex.relevant symbol, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'object'

        body.data.peers.should.exist
        body.data.symbols.should.be.an 'array'

        for element in body.data.symbols
         element.should.exist
        done()

    it "should get #{symbol} relevant info", (done) ->
      iex.relevant symbol, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'object'

        body.data.peers.should.exist
        body.data.symbols.should.be.an 'array'

        for element in body.data.symbols
         element.should.exist
        done()

    it "should get #{symbol} chart info for timeframe: #{timeframe}", (done) ->
      iex.chart symbol, timeframe, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'array'

        for element in body.data
          element.date.should.exist
          element.open.should.exist
          element.high.should.exist
          element.low.should.exist
          element.close.should.exist
          element.volume.should.exist
          element.unadjustedVolume.should.exist
          element.change.should.exist
          element.changePercent.should.exist
          element.vwap.should.exist
          element.label.should.exist
          element.changeOverTime.should.exist
        done()


    it "should get #{symbol} financials info for timeframe: #{timeframe}", (done) ->
      iex.financials symbol, timeframe, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'object'
        body.data.symbol.should.equal symbol
        body.data.financials.should.be.an 'array'

        for element in body.data.financials
          element.reportDate.should.exist
          element.grossProfit.should.exist
          element.costOfRevenue.should.exist
          element.operatingRevenue.should.exist
          element.totalRevenue.should.exist
          element.operatingIncome.should.exist
          element.researchAndDevelopment.should.exist
          element.operatingExpense.should.exist
          element.currentAssets.should.exist
          element.totalAssets.should.exist
          #element.totalLiabilities.should.exist
          element.currentCash.should.exist
          element.currentDebt.should.exist
          element.totalCash.should.exist
          element.totalDebt.should.exist
          element.shareholderEquity.should.exist
          element.cashChange.should.exist
          element.cashFlow.should.exist
          #element.operatingGainsLosses.should.exist
        done()

    it "should get #{symbol} dividends info for timeframe: #{timeframe}", (done) ->
      iex.dividends symbol, timeframe, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'array'

        for element in body.data
          element.exDate.should.exist
          element.paymentDate.should.exist
          element.recordDate.should.exist
          element.declaredDate.should.exist
          element.amount.should.exist
          element.flag.should.exist
          element.type.should.exist
          element.qualified.should.exist
          element.indicated.should.exist
        done()

  describe 'Crypto', ->

    it "should get crypto info", (done) ->
      iex.crypto (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'array'

        for element in body.data
          element.symbol.should.exist
          element.companyName.should.exist
          element.primaryExchange.should.exist
          element.sector.should.exist
          element.calculationPrice.should.exist
          element.open.should.exist
          element.openTime.should.exist
          element.close.should.exist
          element.closeTime.should.exist
          element.high.should.exist
          element.low.should.exist
          element.latestPrice.should.exist
          element.latestSource.should.exist
          element.latestTime.should.exist
          element.latestUpdate.should.exist
          element.latestVolume.should.exist
          #element.iexRealtimePrice.should.exist
          #element.iexRealtimeSize.should.exist
          # element.iexLastUpdated.should.exist
          # element.delayedPrice.should.exist
          # element.delayedPriceTime.should.exist
          # element.extendedPrice.should.exist
          # element.extendedChange.should.exist
          # element.extendedChangePercent.should.exist
          # element.extendedPriceTime.should.exist
          element.previousClose.should.exist
          element.change.should.exist
          element.changePercent.should.exist
          #element.iexMarketPercent.should.exist
          # element.iexVolume.should.exist
          # element.avgTotalVolume.should.exist
          # element.iexBidPrice.should.exist
          # element.iexBidSize.should.exist
          # element.iexAskPrice.should.exist
          # element.iexAskSize.should.exist
          # element.marketCap.should.exist
          # element.peRatio.should.exist
          # element.week52High.should.exist
          # element.week52Low.should.exist
          # element.ytdChange.should.exist
          # element.bidPrice.should.exist
          # element.bidSize.should.exist
          # element.askPrice.should.exist
          # element.askSize.should.exist
        done()

  describe 'News', ->

    it "should get news info", (done) ->
      iex.newsMarket (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'array'

        for element in body.data
          element.datetime.should.exist
          element.headline.should.exist
          element.source.should.exist
          element.url.should.exist
          element.summary.should.exist
          element.related.should.exist
          element.image.should.exist
        done()

    it "should get news info for #{symbol}", (done) ->
      iex.newsStock symbol, (err, body) ->
        should.not.exist err
        body.should.be.an 'object'
        body.status.should.equal 200
        body.data.should.be.an 'array'

        for element in body.data
          element.datetime.should.exist
          element.headline.should.exist
          element.source.should.exist
          element.url.should.exist
          element.summary.should.exist
          element.related.should.exist
          element.related.should.contain symbol
          element.image.should.exist
        done()
