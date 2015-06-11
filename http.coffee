https = require('https')

options =
  hostname: 'aimsuite.intel.com'
  port: 443
  path: '/analytics/rpc_get_aimview_log.php?username={username}&password={password}&did=10873&start_year=2015&start_month=6&start_day=4&end_year=2015&end_month=6&end_day=9&v=2&show_fields=1'
  method: 'GET'

req = https.request options, (res) ->
  console.log 'statusCode: ', res.statusCode
  console.log 'headers: ', res.headers
  res.setEncoding 'utf8'
  res.on 'data', (data) ->
    console.log 'data', data

req.end()
req.on 'error', (e) ->
  console.error e
