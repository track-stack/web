import React, { Component } from 'react'

export default class AttributedString extends React.Component {
  constructor(props) {
    super(props)
  }

  expandTag() {
    const input = this.props.string
    const attrs = this.props.attributes

    if (!attrs) { return input }
    if (!attrs.tags) { return input }

    const tags = attrs.tags 

    var result = ''
    tags.forEach((tag, idx) => {
      if (idx !== 0) {
        const indexOfThisTag = tag.range[0]
        const previousTag = tags[idx - 1]
        const endIndexOfLastTag = previousTag.range[0] + previousTag.range[1]
        if (indexOfThisTag - endIndexOfLastTag > 0) {
          const text = input.substr(endIndexOfLastTag, indexOfThisTag - endIndexOfLastTag)
          result += text
        }
      }
  
      const endIndex = tag.range[1] === -1 ? input.length : tag.range[1]
      const text = input.substr(tag.range[0], endIndex)
      const htmlTag = tag.tag
      const style = tag.style || ''
  
      result += `<${htmlTag} class="${style}">${text}</${htmlTag}>`
    })
  
    const lastTag = tags[tags.length - 1]
    let lastIndex
    if (lastTag && lastTag.range[1] !== -1 && (lastIndex = lastTag.range[0] + lastTag.range[1]) < input.length) {
      result += input.substr(lastIndex, input.length)
    }
    return result  
  }

  render() {
    return (
      <p key={`${this.props.string}`} dangerouslySetInnerHTML={{__html: `${this.expandTag()}`}} />
    )
  }
}