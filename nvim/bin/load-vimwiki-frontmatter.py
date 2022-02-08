#!/usr/bin/python3
import calendar
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
    "# {h1_title}",
    "",
    ""
]

now = datetime.datetime.now()
date = now.strftime('%Y-%m-%d')
timestamp = now.strftime('%Y-%m-%d %H:%M:%S')
dateFullStr = now.strftime('%B %d, %Y')
dow = calendar.day_name[datetime.date.today().weekday()]

if len(sys.argv) < 2:
    title = "New note"
    h1_title = title;
else:
    title = os.path.basename(os.path.normpath(sys.argv[1].rsplit('.', 1)[0])).replace('_', ' ')
    h1_title = f'{dow} - {dateFullStr}' if title == date else title
print('\n'.join(template).format(title=title, date=timestamp, h1_title=h1_title))
