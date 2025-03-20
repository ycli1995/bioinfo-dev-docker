#!/bin/bash
set -e

echo -e "\n>>>>> Check the Python to use with reticulate...\n"
R -q -e 'reticulate::py_discover_config(required_module = NULL, use_environment = NULL)'
echo -e "\n>>>>> Check reticulate, done!\n"

