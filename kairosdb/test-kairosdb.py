#!/usr/bin/python

import time
import pyKairosDB
from pyKairosDB import connection

c = connection.KairosDBConnection()

#print c.read_absolute([u'kairosdb.protocol.http_request_count'], 0)
c.write_one_metric('test_kairos', time.time(), 1, {'src':'test'})
c.write_one_metric('test_kairos', time.time(), 2, {'src':'test'})
c.write_one_metric('test_kairos', time.time(), 3, {'src':'test'})
print c.read_absolute([u'test_kairos'], 0)
