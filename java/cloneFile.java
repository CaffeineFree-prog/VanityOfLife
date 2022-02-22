// 기존 파일 복제하여 파일 재등록 후 해당 파일 아이디를 insertVO에 세팅
String baseAtchFileId = resultVO.getAtchFileId();
if(StringUtil.isNotBlank(baseAtchFileId)) {
	FileVO baseAtchFileVO = new FileVO();
	baseAtchFileVO.setAtchFileId(baseAtchFileId);
	List<FileVO> baseAtchFileList = fileMngService.selectFileInfs(baseAtchFileVO);
	
	if(baseAtchFileList.size() > 0) {
		Map<String, MultipartFile> baseFiles = new HashMap<String, MultipartFile>();
		for(int i=0;i<baseAtchFileList.size();i++) {
			FileVO tmpFileVO = baseAtchFileList.get(i);
			String baseFileName = tmpFileVO.getOrignlFileNm(); // 원본 파일명
			String streFileNm = tmpFileVO.getStreFileNm(); // 서버에 저장된 실제 파일명
			String fileStreCours = tmpFileVO.getFileStreCours(); // 서버에 저장된 경로
			File tmpFile = new File(fileStreCours + File.separator + streFileNm);
			if(tmpFile.exists()) {
				FileItem fileItem = new DiskFileItem("atchFile", Files.probeContentType(tmpFile.toPath()), false, baseFileName, (int) tmpFile.length(), tmpFile.getParentFile());

				try {
					InputStream input = new FileInputStream(tmpFile);
					OutputStream os = fileItem.getOutputStream();
					IOUtils.copy(input, os);
					// Or faster..
					// IOUtils.copy(new FileInputStream(file), fileItem.getOutputStream());
				} catch (IOException ex) {
					// do something.
				}

				MultipartFile multipartFile = new CommonsMultipartFile(fileItem);
				baseFiles.put("atchFile" + i, multipartFile);
			}
		}
		List<FileVO> result = fileUtil.parseFileInf(baseFiles, "FILE_", 0, "", "Globals.STORYCMS.UNIT.JOB.RECRUIT.MYRESUME.APPLYFILE.fileStorePath");
		
		String atchFileId = "";
		if (result != null) {
			atchFileId = fileMngService.insertFileInfs(result);
		}
		resultVO.setAtchFileId(atchFileId);
		
		resultVO.setAttachFiles(result);
	}
	
}
