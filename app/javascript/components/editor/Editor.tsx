import * as React from "react";
import { useEditor, EditorContent } from '@tiptap/react';

import StarterKit from '@tiptap/starter-kit';
import Link from "@tiptap/extension-link";
import Image from '@tiptap/extension-image';
import Placeholder from '@tiptap/extension-placeholder';
import Highlight from '@tiptap/extension-highlight';
import TaskList from '@tiptap/extension-task-list';
import TaskItem from '@tiptap/extension-task-item';

import useWindowDimensions from '../../windowDimensions';
import Menu from './Menu';

const styleToClassName = [
  ['bold', 'bold'],
  ['italic', 'italic'],
  ['strike', 'strike'],
  ['code', 'code'],
  ['highlight', 'highlight'],
  [['heading', { level: 1 }], 'h-1'],
  [['heading', { level: 2 }], 'h-2'],
  [['heading', { level: 3 }], 'h-3'],
  ['paragraph', 'paragraph'],
  ['bulletList', 'bullet-list'],
  ['orderedList', 'ordered-list'],
  ['taskList', 'task-list'],
  ['codeBlock', 'code-block'],
  ['blockquote', 'block-quote'],
  ['horizontalRule', 'horizontal-rule'],
]

const fetchContent = (editor) => {
  const hiddenInput = document.getElementsByName('post[postable_attributes[body]]')[0]
  const text = hiddenInput.value;
  editor.commands.setContent(text);
}

const setHiddenInput = (editor) => {
  const hiddenInput = document.getElementsByName('post[postable_attributes[body]]')[0]
  hiddenInput.value = editor.getHTML();
}

const setActiveToolbarButtons = (editor) => {
  styleToClassName.forEach((item) => {
    const style = item[0]
    let className = item[1]
    let button;
    let isActive = false;

    if (Array.isArray(style)) {
      isActive = editor.isActive(...style)
    } else {
      isActive = editor.isActive(style)
    }

    button = document.getElementsByClassName(`editor-command ${className}`)[0]

    if (isActive && button) {
      button.classList.add('active')
    } else if (button) {
      button.classList.remove('active')
    }
  })
}

let editor;

const Editor = () => {
  const toggleBold = () => {
    if (!editor) return
    editor.chain().focus().toggleBold().run();
  }
  const { height } = useWindowDimensions();

  editor = useEditor({
    extensions: [
      StarterKit,
      Link.configure({
        HTMLAttributes: {
          class: 'cursor-pointer',
        },
      }),
      Image,
      Placeholder.configure({
        placeholder: 'Write something...',
      }),
      Highlight,
      TaskList,
      TaskItem,
    ],
    onCreate({ editor }) {
      fetchContent(editor);
    },
    // Handles menu button and key presses (including keyboard shortcuts)
    onUpdate({editor}) {
      // Duplicate typed text in hidden input for form submission
      setHiddenInput(editor);
      // Needed to update active menu buttons when applying a keyboard shortcut
      // Doesn't handle selecting text
      setActiveToolbarButtons(editor);
    },
    // Handles text selection (but also triggers on key presses)
    onSelectionUpdate({ editor }) {
      // Needed to update active menu buttons when selecting text
      // Doesn't handle keyboard shortcuts
      setActiveToolbarButtons(editor);
    }
  })

  return (
    <div>
      <Menu editor={editor} />
      <div className='editor__body' style={{height: height * 0.865}}>
        <EditorContent editor={editor} className={'ProseMirror-container'}/>
      </div>
    </div>
  )
}

export default Editor
