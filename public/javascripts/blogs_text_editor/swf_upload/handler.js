var bte_content_text_area = null;
function bte_swfUploadLoaded() {
	var btnSubmit = document.getElementById("btnSubmit");
	var txtLastName = document.getElementById("lastname");
	var txtFirstName = document.getElementById("firstname");
	var txtEducation = document.getElementById("education");
	var txtReferences = document.getElementById("references");
	
	//btnSubmit.onclick = bte_doSubmit;
	//btnSubmit.disabled = true;
	/*
	txtLastName.onchange = validateForm;
	txtFirstName.onchange = validateForm;
	txtEducation.onchange = validateForm;
	txtReferences.onchange = validateForm;
	*/
	//validateForm();
}


function bte_fileBrowse() {
	var txtFileName = document.getElementById("bte_txtFileName");
	txtFileName.value = "";

	this.cancelUpload();
	this.selectFile();
}
function bte_settextarea(id) {
	bte_content_text_area = id;
}

// Called by the submit button to start the upload
function bte_doSubmit(e) {
	
	e = e || window.event;
	//if (e.stopPropagation) {
	//	e.stopPropagation();
	//}
	//e.cancelBubble = true;
	
	try {
		bte_swfu.startUpload();
	} catch (ex) {

	}
	return false;
}

 // Called by the queue complete handler to submit the form
function bte_uploadDone() {
	/*
	try {
		document.forms[0].submit();
	} catch (ex) {
		alert("Error submitting form");
	}*/
}


function bte_fileQueueError(file, errorCode, message)  {
	try {
		// Handle this error separately because we don't want to create a FileProgress element for it.
		switch (errorCode) {
		case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
			alert("You have attempted to queue too many files.\n" + (message === 0 ? "You have reached the upload limit." : "You may select " + (message > 1 ? "up to " + message + " files." : "one file.")));
			return;
		case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
			alert("The file you selected is too big.");
			this.debug("Error Code: File too big, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
			alert("The file you selected is empty.  Please select another file.");
			this.debug("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
			alert("The file you choose is not an allowed file type.");
			this.debug("Error Code: Invalid File Type, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		default:
			alert("An error occurred in the upload. Try again later.");
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		}
	} catch (e) {
	}
}

function bte_fileQueued(file) {
	try {
		var txtFileName = document.getElementById("bte_txtFileName");
		txtFileName.value = file.name;
	} catch (e) {
	}

}
function bte_fileDialogComplete(numFilesSelected, numFilesQueued) {
	//validateForm();
}

function bte_uploadProgress(file, bytesLoaded, bytesTotal) {
    $('bte_preloader').show();
	try {
		var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);

		file.id = "singlefile";	// This makes it so FileProgress only makes a single UI element, instead of one for each file
		var progress = new FileProgress(file, this.customSettings.progress_target);
		progress.setProgress(percent);
		progress.setStatus("Загрузка...");
	} catch (e) {
	}
}

function bte_uploadSuccess(file, serverData) {
	try {
		file.id = "singlefile";	// This makes it so FileProgress only makes a single UI element, instead of one for each file
		var progress = new FileProgress(file, this.customSettings.progress_target);
		progress.setComplete();
		progress.setStatus("Подождите.");
		progress.toggleCancel(false);
		$(bte_content_text_area).value = $(bte_content_text_area).value+"<img src='"+serverData+"'>";
		$('bte_preloader').hide();
		$('tinyMceImageInsert').hide();
		//location.href = "/manage/track_uploads/"+serverData+"/edit"
		if (serverData === " ") {
			this.customSettings.upload_successful = false;
		} else {
			this.customSettings.upload_successful = true;
			document.getElementById("hidFileID").value = serverData;
		}
		
	} catch (e) {
	}
}

function bte_uploadComplete(file) {
	try {
		if (this.customSettings.upload_successful) {
			//document.getElementById("btnBrowse").disabled = "true";
			bte_uploadDone();
		} else {
			file.id = "singlefile";	// This makes it so FileProgress only makes a single UI element, instead of one for each file
			var progress = new FileProgress(file, this.customSettings.progress_target);
			progress.setError();
			progress.setStatus("File rejected");
			progress.toggleCancel(false);
			
			var txtFileName = document.getElementById("bte_txtFileName");
			txtFileName.value = "";
			//validateForm();

			alert("There was a problem with the upload.\nThe server did not accept it.");
		}
	} catch (e) {
	}
}

function bte_uploadError(file, errorCode, message) {
	try {
		var txtFileName = document.getElementById("bte_txtFileName");
		txtFileName.value = "";
		//validateForm();
		
		// Handle this error separately because we don't want to create a FileProgress element for it.
		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
			alert("There was a configuration error.  You will not be able to upload a resume at this time.");
			this.debug("Error Code: No backend file, File name: " + file.name + ", Message: " + message);
			return;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
			alert("You may only upload 1 file.");
			this.debug("Error Code: Upload Limit Exceeded, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			break;
		default:
			alert("An error occurred in the upload. Try again later.");
			this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			return;
		}

		file.id = "singlefile";	// This makes it so FileProgress only makes a single UI element, instead of one for each file
		var progress = new FileProgress(file, this.customSettings.progress_target);
		progress.setError();
		progress.toggleCancel(false);

		switch (errorCode) {
		case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
			progress.setStatus("Upload Error");
			this.debug("Error Code: HTTP Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
			progress.setStatus("Upload Failed.");
			this.debug("Error Code: Upload Failed, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.IO_ERROR:
			progress.setStatus("Server (IO) Error");
			this.debug("Error Code: IO Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
			progress.setStatus("Security Error");
			this.debug("Error Code: Security Error, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			progress.setStatus("Upload Cancelled");
			this.debug("Error Code: Upload Cancelled, File name: " + file.name + ", Message: " + message);
			break;
		case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
			progress.setStatus("Upload Stopped");
			this.debug("Error Code: Upload Stopped, File name: " + file.name + ", Message: " + message);
			break;
		}
	} catch (ex) {
	}
}