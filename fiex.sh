#!/bin/bash

set -e

fly ssh console --pty --select -C "/app/bin/techschool remote"
