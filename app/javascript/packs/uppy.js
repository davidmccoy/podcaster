import Uppy from '@uppy/core'
import AwsS3Multipart from '@uppy/aws-s3-multipart'
import Informer from '@uppy/informer'
import ProgressBar from '@uppy/progress-bar'
import FileInput from '@uppy/file-input'
import ThumbnailGenerator from '@uppy/thumbnail-generator'

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('.upload-file').forEach(function (fileInput) {
    audioFileUpload(fileInput)
  })

  document.querySelectorAll('.upload-logo-file').forEach(function (fileInput) {
    logoFileUpload(fileInput)
  })
})

const audioFileUpload = (fileInput) => {
  // Don't allow a Post to save without an uploaded file
  const saveButton = document.getElementById('post-save')

  fileInput.style.display = 'none' // uppy will add its own file input

  let uppy = new Uppy({
    id: fileInput.id,
    autoProceed: true,
    restrictions: {
      maxFileSize: (1000*1024*1024),
      maxNumberOfFiles: 1,
      minNumberOfFiles: 1,
      allowedFileTypes: ['audio/wav', 'audio/mpeg', 'audio/mp3', 'audio/mp4', 'audio/aac', 'audio/aacp']
    },
  })

  uppy.use(FileInput, {
    target: fileInput.parentNode,
    pretty: true,
    locale: {
      strings: {
        chooseFiles: 'Select File'
      }
    }
  })
  uppy.use(Informer, {
    target: fileInput.parentNode,
  })
  uppy.use(ProgressBar, {
    target: fileInput.parentNode,
  })

  uppy.use(AwsS3Multipart, {
    companionUrl: '/', // will call Shrine's presign endpoint on `/s3/params`
  })

  uppy.on('file-added', (file) => {
    $('trix-editor.full-height').height(window.innerHeight * 0.87)
    $('.hidden').show();

    var fileUploadPercentage = document.querySelector('.uppy-ProgressBar-percentage');
    fileUploadPercentage.style.display = 'block';

    var fileUploadButton = document.querySelector('.uppy-FileInput-btn');
    fileUploadButton.style.display = 'none';
  })



  uppy.on('upload-success', function (file, response) {
    saveButton.disabled = false;

    var fileUploadButton = document.querySelector('.uppy-FileInput-btn');
    fileUploadButton.innerHTML = 'File Uploaded';

    // fileUploadButton.disabled = true

    var fileUploadContainer = document.querySelector('.uppy-FileInput-container');

    var fileInputContainer = document.querySelector('.file-input-container');

    var fileUploadPercentage = document.querySelector('.uppy-ProgressBar-percentage');
    fileUploadPercentage.style.display = 'none';

    var fileNameParagraph = document.createElement('div');
    fileNameParagraph.innerHTML = '<p><strong>Audio file:</strong> <em>' + file.name + '</em></div>'

    fileUploadContainer.style.display = 'none'
    fileInputContainer.append(fileNameParagraph)

    var audio = document.getElementById('audio').innerHTML = '<audio id="audio-player" controls="controls" preload="auto" src="' + response.uploadURL + '" type="audio/mpeg">';

    // construct uploaded file data in the format that Shrine expects
    var uploadedFileData = JSON.stringify({
      id: response.uploadURL.match(/\/cache\/([^\?]+)/)[1], // extract key without prefix
      storage: 'cache',
      metadata: {
        size:      file.size,
        filename:  file.name,
        mime_type: file.type
      }
    })

    // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
    var hiddenInput = fileInput.parentNode.querySelector('.upload-hidden')
    hiddenInput.value = uploadedFileData
  })

  return uppy
}

const logoFileUpload = (fileInput) => {
  var imagePreview = document.querySelector('.upload-preview');
  var saveButton = document.getElementById('post-save');

  fileInput.style.display = 'none' // uppy will add its own file input

  let uppy = new Uppy({
    id: fileInput.id,
    autoProceed: true,
    restrictions: {
      maxFileSize: (10*1024*1024),
      maxNumberOfFiles: 1,
      minNumberOfFiles: 1,
      allowedFileTypes: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif']
    },
  })


  uppy.use(FileInput, {
      target: fileInput.parentNode,
      pretty: true,
      locale: {
        strings: {
          chooseFiles: 'Select File'
        }
      }
    })
    .use(Informer, {
      target: fileInput.parentNode,
    })
    .use(ProgressBar, {
      target: imagePreview.parentNode,
    })
    .use(ThumbnailGenerator, {
      thumbnailWidth: 400,
    })

  uppy.use(AwsS3Multipart, {
    companionUrl: '/', // will call Shrine's presign endpoint on `/s3/params`
  })

  uppy.on('file-added', (file) => {
    $('.hidden').show();

    var fileUploadPercentage = document.querySelector('.uppy-ProgressBar-percentage');
    fileUploadPercentage.style.display = 'block';

    var fileUploadButton = document.querySelector('.uppy-FileInput-btn');
    fileUploadButton.style.display = 'none';
  })

  uppy.on('upload-success', function (file, response) {
    saveButton.disabled = false;

    var fileUploadPercentage = document.querySelector('.uppy-ProgressBar-percentage');
    fileUploadPercentage.style.display = 'none';

    // construct uploaded file data in the format that Shrine expects
    var uploadedFileData = JSON.stringify({
      id: response.uploadURL.match(/\/cache\/([^\?]+)/)[1], // object key without prefix
      storage: 'cache',
      metadata: {
        size:      file.size,
        filename:  file.name,
        mime_type: file.type,
      }
    })

    // set hidden field value to the uploaded file data so that it's submitted with the form as the attachment
    var hiddenInput = fileInput.parentNode.querySelector('.upload-hidden')
    hiddenInput.value = uploadedFileData
  })

  uppy.on('thumbnail:generated', function (file, preview) {
    imagePreview.src = preview
  })

  return uppy
}
