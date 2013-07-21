from twisted.internet import protocol, reactor
from twisted.internet.protocol import Factory


class QuoteProtocol(protocol.Protocol):
    def __init__(self, factory):
        self.factory = factory

    def connectionLost(self, reason):
        self.factory.numConnections -= 1

    def connectionMade(self):
        self.factory.numConnections += 1

    def dataReceived(self, data):
        print 'Number of active connections: %d' % (self.factory.numConnections, )
        print '> Received: "%s"\n> Sending: "%s"' % (data, self.getQuote(), )

        self.transport.write(self.getQuote())
        self.updateQuote(data)

    def getQuote(self):
        return self.factory.quote

    def updateQuote(self, quote):
        self.factory.quote = quote


class QuoteFactory(Factory):
    numConnections = 0

    def __init__(self, quote=None):
        self.quote = quote or 'Initial quote...'

    def buildProtocol(self, addr):
        print 'QuoteFactory addr: %s' % (addr, )
        return QuoteProtocol(self)

reactor.listenTCP(8000, QuoteFactory())
reactor.run()
