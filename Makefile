PROJECT := arc-colors
DOCS := AUTHORS ../LICENSE README.md
WALLPAPER := \
	Arc-Brave.png \
	Arc-Dust.png \
	Arc-Human.png \
	Arc-Illustrious.png \
	Arc-Noble.png \
	Arc-Wine.png \
	Arc-Wise.png \
	Arc-Brave-Old.png \
	Arc-Dust-Old.jpg \
	Arc-Human-Old.png \
	Arc-Noble-Old.png \
	Arc-Wine-Old.png \
	Arc-Wise-Old.png \
PROPERTIES := $(wildcard gnome-background-properties/arc-*.xml)

all:

help:
	@echo "make targets:"
	@echo "    all          Does nothing (default target)."
	@echo "    clean        Deletes all files created by this makefile."
	@echo "    fixperms     Fixes permissions of all files."
	@echo "    dist         Creates a distribution tar file for $(PROJECT)."
	@echo "    help         Displays this help."
	@echo "    bz2          Create a distribution .tar.bz2 file."
	@echo "    gz           Create a distribution .tar.gz file."
	@echo "    install      Installs $(PROJECT) system-wide."
	@echo "    uninstall    Removes $(PROJECT) from the system."

fixperms:
	find * ! -wholename '*/.*' -a -type f -a ! -perm 644 -exec chmod 644 {} \; -printf "chmod 644 %p\n"

install:
# install wallpapers
	for FILE in $(WALLPAPER); do \
		install -D -m 644 "$$FILE" "$(DESTDIR)/usr/share/backgrounds/$$FILE"; \
		THEME=$$(echo $$FILE | sed 's/\.[^\.]*$$//'); \
		EXTENSION=$$(echo $$FILE | sed 's/.*\.//g'); \
	done
# install gnome-background-properties files
	for FILE in $(PROPERTIES); do \
		install -D -m 644 "$$FILE" "$(DESTDIR)/usr/share/$$FILE"; \
	done

uninstall:
	rm -f $(addprefix $(DESTDIR)/usr/share/backgrounds/,$(WALLPAPER))
	rm -f $(addprefix $(DESTDIR)/usr/share/,$(PROPERTIES))

.PHONY: clean help install uninstall
