#!/usr/bin/python3
import datetime
import os
import sys

template = [
    "---",
    "title: {title}",
    "date: {date}",
    "tags: ",
    "references: ",
    "---",
    "",
    "# {title}",
    "",
    ""
]

date = datetime.date.today()
if len(sys.argv) < 2:
    title = "New note"
else:
    title = os.path.basename(os.path.normpath(sys.argv[1].rsplit('.', 1)[0])).replace('_', ' ')
print('\n'.join(template).format(title=title, date=date))
