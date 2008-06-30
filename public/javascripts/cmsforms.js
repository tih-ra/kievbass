function setEditor(areaid, mode, width, height) {
	var oFCKeditor = new FCKeditor(areaid) ;
        oFCKeditor.BasePath = "/javascripts/fckeditor/" ;
        oFCKeditor.Config['CustomConfigurationsPath'] = '/javascripts/fckeditor/sleepycms_cfg.js' ;
        oFCKeditor.ToolbarSet = mode;
        oFCKeditor.Height = height;
        oFCKeditor.ReplaceTextarea();
        //oFCKeditor.Create();
}