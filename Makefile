# Makefile for Jeremy's Machine Learning library
# Copyright (c) 2006 Jeremy Barnes.  All rights reserved.

-include local.mk

CXX ?= g++
CC ?= gcc
FC ?= gfortran

NODEJS_ENABLED?=1
PYTHON_ENABLED?=0

LOCAL_DIR?=$(HOME)/local
NODE_PREFIX:=$(LOCAL_DIR)
VOWS?=./node_modules/vows/bin/vows
COFFEE?=./node_modules/coffee-script/bin/coffee
LOCAL_LIB_DIR?=$(LOCAL_DIR)/lib /usr/local/lib
LOCAL_INCLUDE_DIR:=$(LOCAL_DIR)/include $(LOCAL_DIR)/include/node

MACHINE_NAME:=$(shell uname -n)
VALGRINDFLAGS ?=--suppressions=soa/valgrind.supp --error-exitcode=1 --leak-check=full

default: all
.PHONY: default

BUILD 	?= ./build
ARCH 	?= $(shell uname -m)
OBJ 	:= $(BUILD)/$(ARCH)/obj
BIN 	:= $(BUILD)/$(ARCH)/bin
TESTS 	:= $(BUILD)/$(ARCH)/tests
SRC 	:= .
PWD     := $(shell pwd)
TEST_TMP:= $(TESTS)

JML_TOP := .
JML_BUILD := ./jml-build
JML_BASE_TOP := ./jml-base
INCLUDE := -I.

export BUILD
export BIN
export JML_TOP
export JML_BASE_TOP
export JML_BUILD
export TEST_TMP

include $(JML_BUILD)/arch/$(ARCH).mk

CXXLINKFLAGS += -Wl,--copy-dt-needed-entries -Wl,--no-as-needed -L/usr/local/lib
CFLAGS +=  -Wno-unused-but-set-variable
CXXFLAGS +=  -Wno-unused-but-set-variable


include $(JML_BUILD)/functions.mk
include $(JML_BUILD)/rules.mk
include $(JML_BUILD)/python.mk
include $(JML_BUILD)/node.mk

include $(JML_TOP)/jml.mk
