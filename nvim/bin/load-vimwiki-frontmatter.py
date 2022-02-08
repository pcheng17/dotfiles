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

date = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
dow = calendar.day_name[datetime.date.today().weekday()]
if len(sys.argv) < 2:
    title = "New note"
    h1_title = title;
else:
    title = os.path.basename(os.path.normpath(sys.argv[1].rsplit('.', 1)[0])).replace('_', ' ')
    h1_title = f'{dow}, {date}' if title == date else title
print('\n'.join(template).format(title=title, date=date, h1_title=h1_title))
