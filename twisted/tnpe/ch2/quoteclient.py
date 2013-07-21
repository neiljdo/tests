from twisted.internet import protocol, reactor


class QuoteClient(protocol.Protocol):
    def __init__(self, factory):
        self.factory = factory

    def connectionMade(self):
        self.sendQuote()

    def dataReceived(self, data):
        print 'Received quote: "%s"' % (data, )
        self.transport.loseConnection()

    def sendQuote(self):
        self.transport.write(self.factory.quote)


class QuoteClientFactory(protocol.ClientFactory):
    def __init__(self, quote):
        self.quote = quote

    def buildProtocol(self, addr):
        print 'QuoteClientFactory addr: %s' % (addr, )
        return QuoteClient(self)

    def clientConnectionFailed(self, connector, reason):
        print 'Connection failed: %s' % (reason.getErrorMessage())
        maybeStopReactor()

    def clientConnectionLost(self, connector, reason):
        print 'Connection lost; %s' % (reason.getErrorMessage())
        maybeStopReactor()


def maybeStopReactor():
    global quote_counter
    quote_counter -= 1
    if not quote_counter:
        reactor.stop()

quotes = [
    'Quote 1',
    'Quote 2',
    'Quote 3',
]
quote_counter = len(quotes)

for q in quotes:
    reactor.connectTCP('127.0.0.1', 8000, QuoteClientFactory(q))

reactor.run()
