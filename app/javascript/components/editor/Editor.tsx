import * as React from "react";
import { useEditor, EditorContent } from '@tiptap/react'
import StarterKit from '@tiptap/starter-kit'
import Link from "@tiptap/extension-link"
import Image from '@tiptap/extension-image'
import Placeholder from '@tiptap/extension-placeholder'
import Highlight from '@tiptap/extension-highlight'
import TaskList from '@tiptap/extension-task-list'
import TaskItem from '@tiptap/extension-task-item'

const Editor = () => {
  const editor = useEditor({
    extensions: [
      StarterKit,
      Link.configure({
        HTMLAttributes: {
          class: 'cursor-pointer',
        },
      }),
      Image,
      Placeholder.configure({
        // Use a placeholder:
        placeholder: 'Write something...',
      }),
      Highlight,
      TaskList,
      TaskItem,
    ],
    content: '<p>Hello World!</p>',
  })

  return (
    <div className='editor__body'>
      <EditorContent editor={editor} />
    </div>
  )
}

export default Editor
