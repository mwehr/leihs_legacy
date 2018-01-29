import React from 'react'
import cx from 'classnames'
import { Popover, Overlay } from 'react-bootstrap'

class UserCell extends React.Component {
  constructor() {
    super()
    this.state = { show: false }
  }

  renderUserDetails() {
    return (
      <div className="row width-xl min-height-s padding-right-s padding-left-s">
        <div className="col3of4">
          <div className="row">
            <h3 className="headline-l">
              {this.props.firstname} {this.props.lastname}
            </h3>
            {this.props.email && (
              <h3 className="headline-s light">{this.props.email}</h3>
            )}
          </div>
          {this.props.delegator_user_id && (
            <div className="row margin-top-m">
              <p className="paragraph-s line-height-s">
                {_jed('Responsible')}: {this.props.delegator_user_id}
              </p>
            </div>
          )}
          {this.props.address && (
            <div className="row margin-top-m">
              <p className="paragraph-xs line-height-s">{_jed('Address')}</p>
              <p className="paragraph-s line-height-s">{this.props.address}, {this.props.zip} {this.props.city}</p>
            </div>
          )}
          {this.props.phone && (
            <div className="row margin-top-m">
              <p className="paragraph-xs line-height-s">{_jed('Phone')}</p>
              <p className="paragraph-s line-height-s">{this.props.phone}</p>
            </div>
          )}
          {this.props.badge_id && (
          <div className="row margin-top-m">
            <p className="paragraph-xs line-height-s">{_jed('Badge')}</p>
            <p className="paragraph-s line-height-s">{this.props.badge_id}</p>
          </div>
          )}
        </div>
        {this.props.image_url && (
          <div className="col1of4">
            <img
              className="max-size-xxs margin-horziontal-auto"
              src={this.props.image_url}
            />
          </div>
        )}
      </div>
    )
  }

  render() {
    return [
      <div
        className="line-col col1of5"
        key={`user-${this.props.id}-${this.props.visit_id}`}
        ref={`user-${this.props.id}-${this.props.visit_id}`}
        onMouseEnter={() => this.setState({ show: true })}
        onMouseLeave={() => this.setState({ show: false })}
      >
        <Popup popupRef={this.popup}>
          <div style={{opacity: '1'}} className="tooltipster-sidetip tooltipster-default tooltipster-top tooltipster-initial" id="tooltipster-480797" style={{pointerEvents: 'auto', zIndex: '9999999', left: '376px', top: '142px', height: '108px', width: '322px', animationDuration: '350ms', transitionDuration: '350ms'}}>
            <div className="tooltipster-box">
              <div className="tooltipster-content">
                <div className="min-width-l">
                  <div className="exclude-last-child padding-bottom-m margin-bottom-m no-last-child-margin">
                    <div className="row margin-bottom-s">
                      <div className="col1of2">
                        <span>
                        22.03.2017
                        -
                        14.07.2017
                        </span>
                      </div>
                      <div className="col1of2 text-align-right">
                        <strong>115 Tage</strong>
                      </div>
                    </div>
                    <div className="row padding-top-xs">
                      <div className="col1of8 text-align-center">
                        <div className="paragraph-s line-height-s">
                          1
                        </div>
                      </div>
                      <div className="col7of8">
                        <div className="paragraph-s line-height-s text-ellipsis width-full padding-right-s">
                          <strong>Mikrofonstativ 160cm mit Galgen 75-80cm</strong>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>




        </Popup>
        <strong ref={(ref) => this.popup = ref}>
          {this.props.firstname} {this.props.lastname}
          <span className="darkred-text">
            {this.props.is_suspended && ` ${_jed('Suspended')}!`}
          </span>
        </strong>
      </div>,
    ]
  }
}

export default UserCell
