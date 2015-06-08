import calendar
import datetime
import base64
import sys

db_file = 'next-retail-comic-date.txt'
html = '<html><head><title>Retail Comic</title></head><body>%(content)s</body></html>'
url = 'http://safr.kingfeatures.com/idn/etv/zone/xml/content.php?file=%s'
img_url_str = 'http://safr.kingfeatures.com/Retail/%(year)s/%(month)02d/Retail%(ts)s.%(year)s%(month)02d%(day)02d_900.gif'

def get_img_url(date):

    ts = ''
    if date.weekday() == 6:
        ts = '_ts'

    string = img_url_str % { 'year': date.year, 'month': date.month, 'ts': ts, 'day': date.day, }
    return url % base64.b64encode(string)


def get_comic_range_html(start_date, end_date):
    """ Prepares the HTML for the comic strips in the given range. """
    content = ''
    current_strip_day = start_date
    delta = end_date - start_date
    for days in xrange(delta.days + 1):
        content = content + '<h1>' + current_strip_day.strftime('%B %d, %Y') + '</h1>' + "\n" + '<img src="' + get_img_url(current_strip_day) + '" width="900">' + "\n"
        current_strip_day = current_strip_day + datetime.timedelta(days=1)
    return content


def get_start_date():
    """ Return a sane (past or now) start date from DB File or CLI parameter. """
    if len(sys.argv) > 1:
        start_date = sys.argv[1]
    else:
        start_date = get_start_date_string_from_file()

    try:
        start_date = datetime.datetime.strptime(start_date, '%Y-%m-%d').date()
        if start_date > datetime.date.today():
            raise Exception
    except:
        start_date = datetime.date.today()

    print 'Start Date: %s' % start_date
    return start_date


def get_start_date_string_from_file():
    """ Get the date from the last line in a file. """
    f = open(db_file, 'r')
    file_size = f.tell()
    f.seek(max(file_size - 2*1024, 0))
    line = f.read().splitlines()[-1:]
    start_date = line[0]
    f.close()
    return start_date


def get_end_date(start_date):
    day_range = calendar.monthrange(start_date.year, start_date.month)
    end_date = datetime.date(start_date.year, start_date.month, day_range[1])
    today = datetime.date.today()

    if end_date > today:
        end_date = today

    print 'End Date: %s' % end_date
    return end_date


def store_next_start_date(date):
    """ Stores the next logical start date for future use. """
    print 'End Date: %s' % date
    next_start_date = date + datetime.timedelta(days=1)

    with open(db_file, 'a') as f:
        f.write(str(next_start_date) + "\n")

    print 'Next Start Date: %s' % next_start_date


def create_html_file(start_date, end_date):
    content = html % { 'content': get_comic_range_html(start_date, end_date) }

    f = open('retailcomic.html', 'w')
    f.write(content)


if __name__ == "__main__":

    start_date = get_start_date()
    end_date = get_end_date(start_date)
    store_next_start_date(end_date)
    create_html_file(start_date, end_date)
