/* global moment, i18n, _jed */
// import React from 'react'
// import cx from 'classnames'
// import f from 'lodash'
const React = require('react')
const cx = require('classnames')
const f = require('lodash')

// import DebugProps from './DebugProps'

const CustomerOrders = ({ orders_by_year, models_by_id, inventory_pools_by_id }) => {
  const years = f
    .keys(orders_by_year)
    .sort()
    .reverse()

  return (
    <div className="margin-vertical-xl">
      {f.map(years, year => (
        <div key={year}>
          <h3 className="headline-l margin-top-m padding-horizontal-l ">{year}</h3>
          {f.map(orders_by_year[year], o => (
            <Order
              key={o.id}
              order={o}
              models_by_id={models_by_id}
              pool={inventory_pools_by_id[o.inventory_pool_id]}
            />
          ))}
        </div>
      ))}
    </div>
  )
}

const Order = ({ order, pool, models_by_id }) => {
  const approved = order.state !== 'rejected'
  const start = moment(order.total_date_range.start, 'YYYY-MM-DD').format(i18n.date.L)
  const end = moment(order.total_date_range.end, 'YYYY-MM-DD').format(i18n.date.L)

  const cls = cx('paragraph-s separated-bottom padding-vertical-s padding-horizontal-l', {
    'grey-text': !approved
  })

  return (
    <div className={cls}>
      <div className="row">
        <span className="col1of10">
          {moment(order.created_at).format(i18n.date.L)}
          <br />
          bestellt.
        </span>
        <span className="col7of10 padding-bottom-xs padding-right-m">
          <p>
            Zweck: <em>{order.purpose}</em>
          </p>
          {f.every([start, end]) && (
            <p>
              Vom {start} bis {end}
            </p>
          )}
        </span>
        <span className="col2of10">
          <b>{pool.shortname}</b> {pool.name}
        </span>
      </div>
      <div className="row">
        <span className="col1of10">
          {!approved && <span className="badge red">{_jed(order.state)}</span>}
        </span>
        <ul className="col9of10 text-ellipsis">
          {f.map(order.reservations, r => (
            <li>{<ReserationLine {...r} model={models_by_id[r.model_id]} />}</li>
          ))}
        </ul>
      </div>
    </div>
  )
}

const ReserationLine = ({ quantity, model, ...r }) => {
  const name = f.isEmpty(model)
    ? '--unbekannt--'
    : f.isEmpty(model.manufacturer) ? model.product : `${model.product} (${model.manufacturer})`

  const active = f.get(model, 'active')
  const start = moment(r.start_date, 'YYYY-MM-DD').format(i18n.date.L)
  const end = moment(r.end_date, 'YYYY-MM-DD').format(i18n.date.L)

  return (
    <React.Fragment>
      {quantity}
      {' × '}
      {active ? (
        <a className="black" href={model.url}>
          <b>{name}</b>
        </a>
      ) : (
        <span className="grey" title="Nicht mehr ausleihbar!">
          {name}
        </span>
      )}
      {', vom '}
      {start}—{end}
    </React.Fragment>
  )
}

// export default CustomerOrders
module.exports = CustomerOrders
