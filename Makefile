# Copyright (C) 2015 Onion Corporation
# 
# Author: 	Lazar Demin  <lazar@onion.io>
# Date:		Oct 6, 2015
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

SRCDIR := www
SOURCES := $(shell find $(SRCDIR) -maxdepth 1 -mindepth 1 -type d)
SOURCES += www/index.html

DSTDIR := dist

all: clean copy

copy:
	@mkdir -p $(DSTDIR)
	@cp -r $(SOURCES) $(DSTDIR)
	@rm -rf `find dist -name "*bower*"`
	@rm -rf `find dist -name "demo"`
	@rm -rf `find dist -name "test"`
	@rm -rf `find dist -name "*.md"`
	@rm -rf `find dist -name "LICENSE*"`
	@rm -rf `find dist -name "COPYING*"`
	@rm -rf `find dist -name "package.json"`
	@rm -rf `find dist -name ".git*"`
	@rm -rf `find dist -name ".DS_Store"`

clean:
	@rm -rf $(DSTDIR)
