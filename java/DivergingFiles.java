
	@RequestMapping("/writeProc.*")
	public String writeProc(@ModelAttribute("storyCmsActionVO") StoryCmsActionVO storyCmsActionVO,
			@ModelAttribute("searchVO") PersonalMypageVO searchVO, 
			@RequestParam(value="mId", required=false) String mId,
			HttpServletRequest req,
			HttpServletResponse res,
			MultipartHttpServletRequest multiRequest,
			ModelMap model) throws Exception {

		// 현재 로그인 사용자 세션정보
		UserLoginVO userLoginVO = (UserLoginVO) SessionUtil.getUserSessionObj(req);
		if (userLoginVO == null) {
			String returnUrl = req.getContextPath() + "/" + SITECONTEXTPATH +"/contents.do?mId=001009001000000000";
			WriterUtil.flushJSAlert(res,
					WriterUtil.createJsAlertContent("로그인을 해주시기 바랍니다.", "location.href='" + returnUrl + "';"));
			return null;
		}

		searchVO.setEsntlId(userLoginVO.getEsntlId());

		//파일경로 생성
		personalMypageService.mngFileDir();

		PersonalMypageVO vo = new PersonalMypageVO();
		vo = personalMypageService.select(searchVO);
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

		//프로필 사진 업로드
		MultipartFile profilePhoto = multiRequest.getFile("profilePhoto1");
		if(!profilePhoto.isEmpty() && profilePhoto.getSize() > 0){
			String _atchFileId = "";
			Map<String, MultipartFile> filesP = new HashMap<String, MultipartFile>();
			List<FileVO> _result = null;
			filesP.put("profilePhoto", profilePhoto);
			// 첨부파일 업로드 정책확인 (허용용량, 허용/비허용 확장자)
			boolean fileUploadAccept = FileUtil.fileAcceptCheck(searchVO.getProfileAcceptExtList(), filesP);
			if (fileUploadAccept) {
				// 파일업로드 정보 처리
				_result = fileUtil.parseFileInf(filesP, "FILE_", 0, "", "Globals.STORYCMS.UNIT.JOB.RECRUIT.MYRESUME.PROFILE.fileStorePath");
				if (_result != null) {
					_atchFileId = fileMngService.insertFileInfs(_result);
				}
				searchVO.setProfilePhoto(_atchFileId);
			}
		}
		
		//나머지 파일들
		personalMypageService.insertFile(searchVO, vo.getAtchFileId(), files, multiRequest);
		personalMypageService.update(searchVO);

		String returnUrl = MenuUtil.redirectMenuIdRpc("list.do", mId);
		WriterUtil.flushJSAlert(res,
				WriterUtil.createJsAlertContent(egovMessageSource.getMessage("success.common.insert"),
						"location.href='" + returnUrl + "'"));
		return null;

	}
	
	@Override
	public void insertFile(PersonalMypageVO searchVO, String atchFileId, Map<String, MultipartFile> files, MultipartHttpServletRequest multiRequest ) throws Exception {
		
		//나머지 file_1에 대한 분기처리
		if(!files.get("file_1").isEmpty()){
			
				MultipartFile attachedfile = multiRequest.getFile("file_1");
				Map<String, MultipartFile> file_1 = new HashMap<String, MultipartFile>();
				file_1.put("attachedfile", attachedfile);
				
				boolean fileUploadAccept = FileUtil.fileAcceptCheck(searchVO.getFileAcceptExtList(), file_1);
				
				if(fileUploadAccept){
					if (EgovStringUtil.isEmpty(atchFileId)) { // 추가
						
						List<FileVO> result = fileUtil.parseFileInf(file_1, "FILE_", 0, atchFileId, "Globals.STORYCMS.UNIT.JOB.RECRUIT.MYRESUME.ATTACHFILE.fileStorePath");
						
						if (result != null) {
							atchFileId = fileMngService.insertFileInfs(result);
						}
						searchVO.setAtchFileId(atchFileId);
						
						if (result != null) {
							searchVO.setFileCnt(result.size());
						} else {
							searchVO.setFileCnt(0);
						}
						searchVO.setAtchFileId(atchFileId);
						searchVO.setAttachFiles(result);
						
					} else {
						FileVO fileVO = new FileVO();
						fileVO.setAtchFileId(atchFileId);
						int cnt = fileMngService.getMaxFileSN(fileVO);
						
						List<FileVO> result = fileUtil.parseFileInf(file_1, "FILE_", cnt, atchFileId, "Globals.STORYCMS.UNIT.JOB.RECRUIT.MYRESUME.ATTACHFILE.fileStorePath");
						fileMngService.updateFileInfs(result);
		
						if (result != null) {
							searchVO.setFileCnt(fileMngService.selectFileInfs(fileVO).size());
						} 
						else {
							searchVO.setFileCnt(0);
						}
		
						searchVO.setAtchFileId(atchFileId);
						searchVO.setAttachFiles(result);
					}
				} //if (fileUploadAccept)
		}
	}
