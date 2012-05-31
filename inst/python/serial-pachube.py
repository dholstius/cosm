#!/bin/python
#
# serial-pachube.py
#
# Pipes CSV data from a TTY to Pachube.com
#

import sys, time, os
import serial
import eeml

import logging
from logging import StreamHandler
from logging.handlers import TimedRotatingFileHandler

import argparse
parser = argparse.ArgumentParser(
	formatter_class = argparse.RawDescriptionHelpFormatter,
	epilog = """  ****************************************************************************

    example usage for Dylos DC1100 plugged into /dev/device.usbserial:

    $ python serial-pachube.py /dev/device.usbserial \\
        FEED_ID API_KEY PM_Small PM_Large

    where FEED_ID is something like 5888 and API_KEY is your Pachube API key

  ****************************************************************************""",)

parser.add_argument("device", help="tty device")
parser.add_argument("feed", help="Pachube feed ID")
parser.add_argument("key", help="API key with write access to given feed")
parser.add_argument("datastreams", metavar="datastream", nargs="+", help="datastream(s) to update")
parser.add_argument("--baud", dest="baud", type=int, help="baud rate", default=9600)
parser.add_argument("--timeout", dest="timeout", type=int, help="read timeout (in seconds)", default=None)
parser.add_argument("--no-log", dest="log", help="don't log readings to file", action="store_true", default=False)
parser.add_argument("--quiet", dest = "verbose", help = "suppress DEBUG messages from being printed to console", action = "store_false", default = True)

args = parser.parse_args()

logger_name = os.path.basename(args.device)
logger = logging.getLogger(logger_name)
logger.setLevel(logging.DEBUG)
formatter = logging.Formatter("%(asctime)s\t%(name)s\t%(levelname)s\t%(message)s")

# add a console handler at level DEBUG or INFO (depends on -v option)
console_handler = StreamHandler()
console_handler.setFormatter(formatter)
if args.verbose:
    console_handler.setLevel(logging.DEBUG)
else:
    console_handler.setLevel(logging.INFO)
logger.addHandler(console_handler)

# (optional) add a file handler at level INFO
if args.log is not None:
    log_file = logger_name + ".log"
    file_handler = TimedRotatingFileHandler(log_file, "midnight", utc=False)
    file_handler.setLevel(logging.INFO)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    print "Logging to %s" % log_file

# parameters
feed_url = "/v2/feeds/%s.xml" % (args.feed,)
feed_key = args.key
datastream_names = args.datastreams

print "Opening TTY connection ... ",
sys.stdout.flush()
ser = serial.Serial(args.device, args.baud, timeout=args.timeout)
ser.flushInput()
print "OK"

while True:
    try:
        record = ser.readline().strip()
        logger.info(record)
        readings = record.split(',')
        pairs = zip(args.datastreams, readings)
        data = [eeml.Data(k, v) for (k, v) in pairs]
        pachube = eeml.Pachube(feed_url, feed_key)
        pachube.update(data)
        pachube.put()
    except KeyboardInterrupt:
        print "Interrupted, exiting"
        ser.close()
        break
    except Exception, e:
        print e
        print "Retrying ..."
        continue
