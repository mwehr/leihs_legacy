/* global moment, i18n, _jed */
import React from 'react'
import cx from 'classnames'
import f from 'lodash'

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
          {f.map(orders_by_year[year].sort(), o => (
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
  const approved = order.state === 'approved'

  return (
    <div
      className={cx(
        'row paragraph-s separated-bottom Xmargin-top-s padding-vertical-s padding-horizontal-l',
        {
          'grey-text': !approved
        }
      )}>
      <div className="row">
        <span className="col1of10">{moment(order.created_at).format(i18n.date.L)}</span>
        <span className="col7of10">
          <em>{order.purpose}</em>
        </span>
        <span className="col2of10">{pool.name}</span>
      </div>
      <div className="row">
        <span className="col1of10">
          {!approved && <span className="badge red">{_jed(order.state)}</span>}
        </span>
        <ul className="col9of10 text-ellipsis">
          {f.map(order.reservations, r => (
            <li>{<ModelLine quantity={r.quantity} model={models_by_id[r.model_id]} />}</li>
          ))}
        </ul>
      </div>
    </div>
  )
}

const ModelLine = ({ quantity, model }) => {
  const name = f.isEmpty(model.manufacturer)
    ? model.product
    : `${model.product} (${model.manufacturer})`
  return (
    <React.Fragment>
      {quantity}
      {' × '}
      {model.active ? (
        <a className="black" href={model.url}>
          <b>{name}</b>
        </a>
      ) : (
        <span className="grey" title="Nicht mehr ausleihbar!">
          {name}
        </span>
      )}
    </React.Fragment>
  )
}

export default CustomerOrders
