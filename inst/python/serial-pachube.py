#!/bin/python
#
# serial-pachube.py
#
# Pipes CSV data from a TTY to Pachube.com
#

import sys, time, argparse
import serial
import eeml

parser = argparse.ArgumentParser(
	formatter_class = argparse.RawDescriptionHelpFormatter,
	epilog = '''  ****************************************************************************

    example usage for Dylos DC1100 plugged into /dev/tty.usbserial:

    $ python serial-pachube.py /dev/tty.usbserial \\
        FEED_ID API_KEY --datastreams PM_Small PM_Large

    where FEED_ID is something like 5888 and API_KEY is your Pachube API key

  ****************************************************************************''',)

parser.add_argument('tty', help='tty device')
parser.add_argument('feed', help='Pachube feed ID')
parser.add_argument('key', help='API key with write access to given feed')
parser.add_argument('datastreams', metavar='datastream', nargs='+', help='datastream(s) to update')
parser.add_argument('--baud', dest='baud', type=int, help='baud rate', default=9600)
parser.add_argument('--timeout', dest='timeout', type=int, help='read timeout (in seconds)', default=None)
args = parser.parse_args()

# parameters
feed_url = '/v2/feeds/%s.xml' % (args.feed,)
feed_key = args.key
datastream_names = args.datastreams

print "Opening TTY connection ... ",
sys.stdout.flush()
ser = serial.Serial(args.tty, args.baud, timeout=args.timeout)
ser.flushInput()
print "OK"

while True:
	try:
		readings = ser.readline().strip().split(',')
		assert len(readings) == len(args.datastreams)
		pachube = eeml.Pachube(feed_url, feed_key)
		pairs = zip(args.datastreams, readings)
		print(pairs)
		data = [eeml.Data(k, v) for (k, v) in pairs]
		pachube.update(data)
		pachube.put()
	except KeyboardInterrupt:
		print "Interrupted, exiting"
		ser.close()
		sys.exit(1)
	except AssertionError:
		print "Reading from TTY failed, retrying"
		continue
	except:
		print "Something else failed, retrying"
		continue