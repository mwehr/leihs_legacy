import React from 'react'
import cx from 'classnames'
import { Popover, Overlay } from 'react-bootstrap'

class ReservationsCell extends React.Component {
  constructor() {
    super()
    this.state = { show: false }
  }

  diffDatesInDays(start, end) {
    return (
      1 +
      moment(end)
        .endOf('day')
        .diff(moment(start).startOf('day'), 'days')
    )
  }

  renderGroupedReservations(reservations) {
    const tmp = _.groupBy(reservations, r => r.model_name)
    return _.map(tmp, (reservations, model_name) => {
      return (
        <div key={model_name} className="row padding-top-xs">
          <div className="col1of8 text-align-center">
            <div className="paragraph-s line-height-s">{reservations.length}</div>
          </div>
          <div className="col7of8">
            <div className="paragraph-s line-height-s text-ellipsis width-full padding-right-s">
              <strong>{model_name}</strong>
            </div>
          </div>
        </div>
      )
    })
  }

  renderDateRanges() {
    const tmp = _.groupBy(this.props.reservations, r => [r.start_date, r.end_date])
    return _.map(tmp, (reservations, dates) => {
      const startDate = reservations[0].start_date
      const endDate = reservations[0].end_date
      const diffDates = this.diffDatesInDays(startDate, endDate)

      return (
        <div key={`${startDate}-${endDate}`}>
          <div className="exclude-last-child padding-bottom-m margin-bottom-m no-last-child-margin">
            <div className="row margin-bottom-s">
              <div className="col1of2">
                <span>
                  {startDate} - {endDate}
                </span>
              </div>
              <div className="col1of2 text-align-right">
                <strong>
                  {diffDates} {_jed(diffDates, 'day', 'days')}
                </strong>
              </div>
            </div>
          </div>
          {this.renderGroupedReservations(reservations)}
        </div>
      )
    })
  }

  render() {
    return (
      <div
        className="col1of5 line-col text-align-center"
        key={`reservations-${this.props.visit_id}`}
        ref={`reservations-${this.props.visit_id}`}
        onMouseEnter={() => this.setState({ show: true })}
        onMouseLeave={() => this.setState({ show: false })}>
        <Popup popupRef={this.popup}>
          <div
            style={{ opacity: '1' }}
            className="tooltipster-sidetip tooltipster-default tooltipster-top tooltipster-initial"
            id="tooltipster-480797"
            style={{
              pointerEvents: 'auto',
              zIndex: '9999999',
              left: '376px',
              top: '142px',
              height: '108px',
              width: '322px',
              animationDuration: '350ms',
              transitionDuration: '350ms'
            }}>
            <div className="tooltipster-box">
              <div className="tooltipster-content">
                <div className="min-width-l">{this.renderDateRanges()}</div>
              </div>
            </div>
          </div>
        </Popup>
        <div ref={ref => (this.popup = ref)}>
          {this.props.quantity} {_jed(this.props.quantity, 'Item')}
        </div>
      </div>
    )
  }
}

export default ReservationsCell
