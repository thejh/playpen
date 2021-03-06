PREFIX = /usr/local

CFLAGS += -std=c11 -D_GNU_SOURCE -O2 \
	  -D_FORTIFY_SOURCE=2 -fPIE -fstack-check -fstack-protector-strong \
	  -fsanitize=undefined -fsanitize-undefined-trap-on-error \
	  -DVERSION=\"$(shell git describe)\"
LDLIBS = -lseccomp -lsystemd
LDFLAGS += -pie -Wl,--as-needed,-z,relro,-z,now

ifeq ($(CC), clang)
	CFLAGS += -Weverything \
		  -Wno-padded \
		  -Wno-disabled-macro-expansion
else
	CFLAGS += -Wall -Wextra -Wshadow
endif

playpen: playpen.c

install: playpen
	install -Dm755 $< $(DESTDIR)$(PREFIX)/bin/$<

uninstall:
	rm $(DESTDIR)$(PREFIX)/bin/playpen

.PHONY: install uninstall
