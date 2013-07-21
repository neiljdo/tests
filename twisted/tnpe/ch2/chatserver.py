from twisted.internet import reactor
from twisted.internet.protocol import Factory
from twisted.protocols.basic import LineReceiver


class ChatProtocol(LineReceiver):
    def __init__(self):
        self.name = None
        self.state = 'REGISTER'

    def broadcastMessage(self, message):
        for name, protocol in self.factory.users.iteritems():
            if protocol != self:
                protocol.sendLine(message)

    def connectionLost(self, reason):
        if self.name in self.factory.users:
            del self.factory.users[self.name]
            self.broadcastMessage('%s has left the channel.' % (self.name, ))

    def connectionMade(self):
        self.sendLine('What\'s your name?')

    def handle_CHAT(self, message):
        message = '<%s> %s' % (self.name, message, )
        self.broadcastMessage(message)

    def handle_REGISTER(self, name):
        if name in self.factory.users:
            self.sendLine('Name "%s" already taken. Please use another.' % (name, ))
        else:
            self.sendLine('Welcome %s!' % (name,))
            self.broadcastMessage('%s has joined the channel.' % (name,))
            self.name = name
            self.factory.users[name] = self
            self.state = 'CHAT'

    def lineReceived(self, line):
        if self.state == 'REGISTER':
            self.handle_REGISTER(line)
        else:
            self.handle_CHAT(line)


class ChatFactory(Factory):
    protocol = ChatProtocol

    def __init__(self):
        self.users = {}


reactor.listenTCP(8000, ChatFactory())
reactor.run()
