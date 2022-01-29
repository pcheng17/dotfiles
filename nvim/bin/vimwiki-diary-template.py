#!/usr/bin/python3
import datetime
import os
import sys

template = """# {date}

## Todo

## Notes"""

if len(sys.argv) < 2:
    date = datetime.date.today()
else:
    date = os.path.basename(os.path.normpath(sys.argv[1].rsplit('.', 1)[0]))
print(template.format(date=date))
