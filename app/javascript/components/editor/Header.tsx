import * as React from "react";

const Header = () => {
  return (
    <div className='editor__header'>
      <button type="button" className="menu-item editor-command bold" title="Bold">
        Button{/* <%= image_tag 'bold.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command italic" title="Italic">
        Button{/* <%= image_tag 'italic.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command strike" title="Strikethrough">
        Button{/* <%= image_tag 'strikethrough.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command code" title="Code">
        Button{/* <%= image_tag 'code.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command highlight" title="Highlight">
        Button{/* <%= image_tag 'mark-pen-line.svg', className: 'sidebar-icon' %> */}
      </button>
      <div className="divider"></div>
      <button type="button" className="menu-item editor-command h-1" title="H1">
        Button{/* <%= image_tag 'h-1.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command h-2" title="H2">
        Button{/* <%= image_tag 'h-2.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command h-3" title="H2">
        Button{/* <%= image_tag 'h-3.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command paragraph" title="Paragraph">
        Button{/* <%= image_tag 'paragraph.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command bullet-list" title="Bulleted List">
        Button{/* <%= image_tag 'list-unordered.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command ordered-list" title="Ordered List">
        Button{/* <%= image_tag 'list-ordered.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command task-list" title="Task List">
        Button{/* <%= image_tag 'list-check.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command code-block" title="Code Block">
        Button{/* <%= image_tag 'code-box-line.svg', className: 'sidebar-icon' %> */}
      </button>
      <div className="divider"></div>
      <button type="button" className="menu-item editor-command block-quote" title="Blockquote">
        Button{/* <%= image_tag 'double-quotes-l.svg', className: 'sidebar-icon' %> */}
      </button>
      <button type="button" className="menu-item editor-command horizontal-rule" title="Horizontal Rule">
        Button{/* <%= image_tag 'separator.svg', className: 'sidebar-icon' %> */}
      </button>
    </div>
  )
}

export default Header;
