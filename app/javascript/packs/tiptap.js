import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'
import Image from '@tiptap/extension-image'
import Placeholder from '@tiptap/extension-placeholder'
import Highlight from '@tiptap/extension-highlight'
import TaskList from '@tiptap/extension-task-list'
import TaskItem from '@tiptap/extension-task-item'

let editor;

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

document.addEventListener('turbolinks:load', () => {

  document.querySelectorAll('.editor__body').forEach(() => {
    editor = new Editor({
      element: document.querySelector('.editor__body'),
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
      onCreate({ editor }) {
        fetchContent(editor);
      },
      onUpdate({editor}) {
        setHiddenInput(editor);
      },
      onUpdate({ editor }) {
        setActiveToolbarButtons(editor);
      },
    })

    const fetchContent = (editor) => {
      const hiddenInput = document.getElementsByName('post[postable_attributes[content]]')[0]
      const text = hiddenInput.value;
      editor.commands.setContent(text);
    }

    const setHiddenInput = (editor) => {
      const hiddenInput = document.getElementsByName('post[postable_attributes[content]]')[0]
      hiddenInput.value = editor.getHTML();
    }
  })

  document.querySelectorAll('.tiptap-command.bold').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleBold().run();
    });
  })

  document.querySelectorAll('.tiptap-command.italic').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleItalic().run();
    });
  })

  document.querySelectorAll('.tiptap-command.strike').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleStrike().run();
    });
  })

  document.querySelectorAll('.tiptap-command.code').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleCode().run();
    });
  })

  document.querySelectorAll('.tiptap-command.highlight').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleHighlight().run();
    });
  })

  document.querySelectorAll('.tiptap-command.h-1').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleHeading({ level: 1 }).run();
    });
  })

  document.querySelectorAll('.tiptap-command.h-2').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleHeading({ level: 2 }).run();
    });
  })

  document.querySelectorAll('.tiptap-command.h-3').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleHeading({ level: 3 }).run();
    });
  })

  document.querySelectorAll('.tiptap-command.h-4').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleHeading({ level: 4 }).run();
    });
  })

  document.querySelectorAll('.tiptap-command.h-5').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleHeading({ level: 5 }).run();
    });
  })

  document.querySelectorAll('.tiptap-command.h-6').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleHeading({ level: 6 }).run();
    });
  })

  document.querySelectorAll('.tiptap-command.paragraph').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().setParagraph().run();
    });
  })

  document.querySelectorAll('.tiptap-command.bullet-list').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleBulletList().run();
    });
  })

  document.querySelectorAll('.tiptap-command.ordered-list').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleOrderedList().run();
    });
  })

  document.querySelectorAll('.tiptap-command.task-list').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleTaskList().run();
    });
  })

  document.querySelectorAll('.tiptap-command.code-block').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleCodeBlock().run();
    });
  })

  document.querySelectorAll('.tiptap-command.block-quote').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().toggleBlockquote().run();
    });
  })

  document.querySelectorAll('.tiptap-command.horizontal-rule').forEach(function(button) {
    button.addEventListener('click', (event) => {
      toggleButtonActiveClass(event);
      editor.chain().focus().setHorizontalRule().run();
    });
  })
})

// Turbolinks will cache the editor, resulting in back/forward buttons mounting multiple editors.
document.addEventListener('turbolinks:before-cache', function () {
  editor.destroy()
})

const toggleButtonActiveClass = (event) => {
  if (event.target.classList.contains('sidebar-icon')) {
    event.target.parentElement.classList.toggle('active');
  } else {
    event.target.classList.toggle('active');
  }
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

    button = document.getElementsByClassName(`tiptap-command ${className}`)[0]

    if (isActive && button) {
      button.classList.add('active')
    } else if (button) {
      button.classList.remove('active')
    }
  })
}
