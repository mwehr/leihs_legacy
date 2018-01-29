(() => {
  // NOTE: only for linter and clarity:
  /* global _ */
  /* global _jed */
  const React = window.React

  window.Popup = window.createReactClass({
    propTypes: {
    },

    getInitialState () {
      return {
        visible: false,
        insideThis: false,
        insideChild: false
      }
    },

    popupMouseLeave(event) {
      event.preventDefault()
      this.setState({
        insideThis: false,
      }, this.handleUpdates)
    },

    popupMouseOver(event) {
      event.preventDefault()
      this.setState({
        insideThis: true,
        rectangle: this.popupRef.getBoundingClientRect()
      }, this.handleUpdates)
    },

    contentMouseLeave(event) {
      event.preventDefault()
      this.setState({
        insideChild: false,
      }, this.handleUpdates)
    },

    contentMouseOver(event) {
      event.preventDefault()
      this.setState({
        insideChild: true
      }, this.handleUpdates)
    },

    handleUpdates(event) {
      this.setState({visible: this.state.insideChild || this.state.insideThis})
    },

    popupRef: null,

    componentWillReceiveProps(nextProps) {

      if(nextProps.popupRef != this.popupRef) {

        if(this.popupRef) {
          this.popupRef.removeEventListener("mouseenter", this.popupMouseOver);
          this.popupRef.removeEventListener("mouseleave", this.popupMouseLeave);
        }

        this.popupRef = nextProps.popupRef

        if(this.popupRef) {
          this.popupRef.addEventListener("mouseenter", this.popupMouseOver);
          this.popupRef.addEventListener("mouseleave", this.popupMouseLeave);
        }
      }
    },

    componentWillUnmount() {

      if(this.popupRef) {
        this.popupRef.removeEventListener("mouseenter", this.popupMouseOver);
        this.popupRef.removeEventListener("mouseleave", this.popupMouseLeave);
      }
    },

    renderPopup() {
      if(!this.state.visible) {
        return null
      }


      var style = {
        position: 'relative',
        backgroundColor: 'none',
        left: '-50%'
      }

      return (
        <div style={style}>
          <div onMouseEnter={this.contentMouseOver} onMouseLeave={this.contentMouseLeave}>
            {this.props.children}
          </div>
        </div>
      )
    },

    render () {

      if(!this.state.visible) {
        return null
      }

      var outer = {
        position: 'relative',
        top: '0px',
        left: '0px',
        width: '0px',
        height: '0px'
      }

      var left = this.state.rectangle.width * 0.5

      var inner = {
        position: 'absolute',
        left: left + 'px',
        bottom: '0px',
        zIndex: '10000'
      }

      return (
        <div style={outer}>
          <div style={inner}>
            {this.renderPopup()}
          </div>
        </div>
      )

    }
  })
})()
