const fs = require('fs')
const f = require('lodash')
// const React = require('react')
const ReactDOM = require('react-dom/server')

const View = require('./app/javascript/components/CustomerOrders.js')

fs
  .readdirSync('./tmp/dumpall')
  .filter(p => f.endsWith(p, '.json'))
  .map(i => {
    const props = require('./tmp/dumpall/' + i)
    ReactDOM.renderToString(View, props)
  })
