# Makefile for wzsh installation

WZSH_DIR := $(CURDIR)

install:
	@echo "Starting wzsh installation..."
	@WZSH_DIR=$(WZSH_DIR) sh scripts/_install

.PHONY: install
