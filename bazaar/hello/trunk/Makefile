all: hello.c.bin HelloWorld.class

%.c.bin: %.c
	gcc -o $@ $<

%.class: %.java
	javac $<

clean:
	rm -f *.bin *.class
