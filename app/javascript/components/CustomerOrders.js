import React from 'react'
import PropTypes from 'prop-types'
// import cx from 'classnames'

import DebugProps from './DebugProps'

const CustomerOrders = props => (
  <div className="row content-wrapper straight-top-left">
    <div className="row padding-horizontal-m padding-top-l padding-bottom-s">
      <DebugProps {...props} />
    </div>
  </div>
)

CustomerOrders.PropTypes = PropTypes.any

export default CustomerOrders
