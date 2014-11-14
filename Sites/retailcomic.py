import datetime
import base64
import sys

html = '<html><head><title>Retail Comic</title></head><body>%(content)s</body></html>'
url = 'http://safr.kingfeatures.com/idn/etv/zone/xml/content.php?file=%s'
img_url_str = 'http://safr.kingfeatures.com/Retail/%(year)s/%(month)02d/Retail%(ts)s.%(year)s%(month)02d%(day)02d_900.gif'

def get_img_url(date):

    ts = ''
    if date.weekday() == 6:
        ts = '_ts'

    string = img_url_str % { 'year': date.year, 'month': date.month, 'ts': ts, 'day': date.day, }
    return url % base64.b64encode(string)


def get_range(date):
	content = ''
	for days in xrange(31):
		newday = date + datetime.timedelta(days=days)
		content = content + '<h1>' + newday.strftime('%B %d, %Y') + '</h1>' + "\n" + '<img src="' + get_img_url(newday) + '" width="900">' + "\n"
	return content


if __name__ == "__main__":
	content = ''

	if len(sys.argv) > 1:
		date_str = sys.argv[1]

	try:
		date = datetime.datetime.strptime(date_str, '%Y-%m-%d')
	except:
		date = datetime.date.today()
		content = '<h1> Date not found. Showing today only. </h1><p>Please make sure your format is 2000-12-25</p>'

	#todo: store date in text file

	content = content + get_range(date)
	print html % { 'content': content }
