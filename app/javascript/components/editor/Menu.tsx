import React from 'react';

import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

import { Editor } from '@tiptap/react'

const toggleButtonActiveClass = (event) => {
  if (event.target.classList.contains('menu-icon')) {
    event.target.parentElement.classList.toggle('active');
  } else {
    event.target.classList.toggle('active');
  }
}

type MenuProps = {
  editor: Editor;
  handleUploadModalShow: () => void;
}

const Menu = ({ editor, handleUploadModalShow }: MenuProps) => {
  if (!editor) {
    return (
      <></>
    )
  }


  return (
    <>
      <div className='editor__header'>
        <button
          type="button"
          className="menu-item editor-command bold"
          title="Bold"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleBold().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path
              fill="none"
              d="M0 0h24v24H0z"
            />
            <path
              d="M8 11h4.5a2.5 2.5 0 1 0 0-5H8v5zm10 4.5a4.5 4.5 0 0 1-4.5 4.5H6V4h6.5a4.5 4.5 0 0 1 3.256 7.606A4.498 4.498 0 0 1 18 15.5zM8 13v5h5.5a2.5 2.5 0 1 0 0-5H8z"
              fill="#343434"
            />
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command italic"
          title="Italic"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleItalic().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M15 20H7v-2h2.927l2.116-12H9V4h8v2h-2.927l-2.116 12H15z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command strike"
          title="Strikethrough"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleStrike().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M17.154 14c.23.516.346 1.09.346 1.72 0 1.342-.524 2.392-1.571 3.147C14.88 19.622 13.433 20 11.586 20c-1.64 0-3.263-.381-4.87-1.144V16.6c1.52.877 3.075 1.316 4.666 1.316 2.551 0 3.83-.732 3.839-2.197a2.21 2.21 0 0 0-.648-1.603l-.12-.117H3v-2h18v2h-3.846zm-4.078-3H7.629a4.086 4.086 0 0 1-.481-.522C6.716 9.92 6.5 9.246 6.5 8.452c0-1.236.466-2.287 1.397-3.153C8.83 4.433 10.271 4 12.222 4c1.471 0 2.879.328 4.222.984v2.152c-1.2-.687-2.515-1.03-3.946-1.03-2.48 0-3.719.782-3.719 2.346 0 .42.218.786.654 1.099.436.313.974.562 1.613.75.62.18 1.297.414 2.03.699z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command code"
          title="Code"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleCode().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M23 12l-7.071 7.071-1.414-1.414L20.172 12l-5.657-5.657 1.414-1.414L23 12zM3.828 12l5.657 5.657-1.414 1.414L1 12l7.071-7.071 1.414 1.414L3.828 12z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command highlight"
          title="Highlight"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleHighlight().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M15.243 4.515l-6.738 6.737-.707 2.121-1.04 1.041 2.828 2.829 1.04-1.041 2.122-.707 6.737-6.738-4.242-4.242zm6.364 3.535a1 1 0 0 1 0 1.414l-7.779 7.779-2.12.707-1.415 1.414a1 1 0 0 1-1.414 0l-4.243-4.243a1 1 0 0 1 0-1.414l1.414-1.414.707-2.121 7.779-7.779a1 1 0 0 1 1.414 0l5.657 5.657zm-6.364-.707l1.414 1.414-4.95 4.95-1.414-1.414 4.95-4.95zM4.283 16.89l2.828 2.829-1.414 1.414-4.243-1.414 2.828-2.829z"/>
          </svg>
        </button>
        <div className="divider"></div>
        <button
          type="button"
          className="menu-item editor-command h-1"
          title="H1"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleHeading({ level: 1 }).run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0H24V24H0z"/>
            <path fill="#343434" d="M13 20h-2v-7H4v7H2V4h2v7h7V4h2v16zm8-12v12h-2v-9.796l-2 .536V8.67L19.5 8H21z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command h-2"
          title="H2"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleHeading({ level: 2 }).run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0H24V24H0z"/>
            <path fill="#343434" d="M4 4v7h7V4h2v16h-2v-7H4v7H2V4h2zm14.5 4c2.071 0 3.75 1.679 3.75 3.75 0 .857-.288 1.648-.772 2.28l-.148.18L18.034 18H22v2h-7v-1.556l4.82-5.546c.268-.307.43-.709.43-1.148 0-.966-.784-1.75-1.75-1.75-.918 0-1.671.707-1.744 1.606l-.006.144h-2C14.75 9.679 16.429 8 18.5 8z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command h-3"
          title="H3"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleHeading({ level: 3 }).run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0H24V24H0z"/>
            <path fill="#343434" d="M22 8l-.002 2-2.505 2.883c1.59.435 2.757 1.89 2.757 3.617 0 2.071-1.679 3.75-3.75 3.75-1.826 0-3.347-1.305-3.682-3.033l1.964-.382c.156.806.866 1.415 1.718 1.415.966 0 1.75-.784 1.75-1.75s-.784-1.75-1.75-1.75c-.286 0-.556.069-.794.19l-1.307-1.547L19.35 10H15V8h7zM4 4v7h7V4h2v16h-2v-7H4v7H2V4h2z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command paragraph"
          title="Paragraph"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().setParagraph().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M12 6v15h-2v-5a6 6 0 1 1 0-12h10v2h-3v15h-2V6h-3zm-2 0a4 4 0 1 0 0 8V6z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command bullet-list"
          title="Bulleted List"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleBulletList().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M8 4h13v2H8V4zM4.5 6.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm0 7a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zm0 6.9a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3zM8 11h13v2H8v-2zm0 7h13v2H8v-2z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command ordered-list"
          title="Ordered List"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleOrderedList().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M8 4h13v2H8V4zM5 3v3h1v1H3V6h1V4H3V3h2zM3 14v-2.5h2V11H3v-1h3v2.5H4v.5h2v1H3zm2 5.5H3v-1h2V18H3v-1h3v4H3v-1h2v-.5zM8 11h13v2H8v-2zm0 7h13v2H8v-2z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command task-list"
          title="Task List"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleTaskList().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M11 4h10v2H11V4zm0 4h6v2h-6V8zm0 6h10v2H11v-2zm0 4h6v2h-6v-2zM3 4h6v6H3V4zm2 2v2h2V6H5zm-2 8h6v6H3v-6zm2 2v2h2v-2H5z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command code-block"
          title="Code Block"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleCodeBlock().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M3 3h18a1 1 0 0 1 1 1v16a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1zm1 2v14h16V5H4zm16 7l-3.536 3.536-1.414-1.415L17.172 12 15.05 9.879l1.414-1.415L20 12zM6.828 12l2.122 2.121-1.414 1.415L4 12l3.536-3.536L8.95 9.88 6.828 12zm4.416 5H9.116l3.64-10h2.128l-3.64 10z"/>
          </svg>
        </button>
        <div className="divider"></div>
        <button
          type="button"
          className="menu-item editor-command block-quote"
          title="Blockquote"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().toggleBlockquote().run();
          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M4.583 17.321C3.553 16.227 3 15 3 13.011c0-3.5 2.457-6.637 6.03-8.188l.893 1.378c-3.335 1.804-3.987 4.145-4.247 5.621.537-.278 1.24-.375 1.929-.311 1.804.167 3.226 1.648 3.226 3.489a3.5 3.5 0 0 1-3.5 3.5c-1.073 0-2.099-.49-2.748-1.179zm10 0C13.553 16.227 13 15 13 13.011c0-3.5 2.457-6.637 6.03-8.188l.893 1.378c-3.335 1.804-3.987 4.145-4.247 5.621.537-.278 1.24-.375 1.929-.311 1.804.167 3.226 1.648 3.226 3.489a3.5 3.5 0 0 1-3.5 3.5c-1.073 0-2.099-.49-2.748-1.179z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command horizontal-rule"
          title="Horizontal Rule"
          onClick={(event) => {
            toggleButtonActiveClass(event);
            editor.chain().focus().setHorizontalRule().run();

          }}
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="20"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M2 11h2v2H2v-2zm4 0h12v2H6v-2zm14 0h2v2h-2v-2z"/>
          </svg>
        </button>
        <button
          type="button"
          className="menu-item editor-command add-image"
          title="Add Image"
          onClick={() => {
            handleUploadModalShow();
            // const url = window.prompt('Image URL:')

            // if (url) {
            //   editor.chain().focus().setImage({ src: response.body.location }).run()
            // }


          }
        }
        >
          <svg
            className={'menu-icon'}
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="24"
            height="24"
          >
            <path fill="none" d="M0 0h24v24H0z"/>
            <path fill="#343434" d="M21 15v3h3v2h-3v3h-2v-3h-3v-2h3v-3h2zm.008-12c.548 0 .992.445.992.993V13h-2V5H4v13.999L14 9l3 3v2.829l-3-3L6.827 19H14v2H2.992A.993.993 0 0 1 2 20.007V3.993A1 1 0 0 1 2.992 3h18.016zM8 7a2 2 0 1 1 0 4 2 2 0 0 1 0-4z"/></svg>
        </button>
      </div>
    </>
  )
}

export default Menu;
