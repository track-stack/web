import React, { Component } from 'react'

export default class AttributedStringViewModel extends React.Component {
  constructor(props) {
    super(props)
  }

  expandTag() {
    const str = this.props.string
    const attrs = this.props.attributes

    if (!attrs) { return str }
    if (!attrs.tags) { return str }

    const input = str
    const tags = attrs.tags 

    var result = ''
    tags.forEach((tag, idx) => {
      if (idx !== 0 && tag.range[0] - tags[idx - 1].range[1] > 0) {
        const prevTag = tags[idx - 1]
        const text = input.substr(prevTag.range[1], tag.range[0] - prevTag.range[1])
        result += text
      }
      
      const endIndex = tag.range[1] === -1 ? str.length : tag.range[1]
      const text = input.substr(tag.range[0], endIndex)
      const htmlTag = tag.tag
      const style = tag.style || ''
      
      result += `<${htmlTag} class="${style}">${text}</${htmlTag}>`
    })

    return result
  }

  render() {
    return (
      <p key={`${this.props.string}`} dangerouslySetInnerHTML={{__html: `${this.expandTag()}`}} />
    )
  }
}