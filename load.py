# Python Imports 
import os
import sys
import json
import math
import random
import warnings
from typing import Optional
from datetime import datetime
from itertools import product
from collections import Counter

# Library Imports

# Custom Imports

# Gloabal Variable/Settings

with open("config.json", "r") as cf:
    config = json.load(cf)