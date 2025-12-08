#!/usr/bin/env bash
set -Eeuo pipefail

echo "Running smoke test..."
ruby test/smoke_test.rb

echo "Tests completed."
