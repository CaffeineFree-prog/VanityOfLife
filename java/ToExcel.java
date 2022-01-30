 register bean in servlet.xml

so that I can just return class name in the controller

	@RequestMapping("/ExcelDown.do")

	public String ExcelDown(ModelMap model,

			HttpServletResponse res,

			HttpServletRequest req) throws Exception{

		return "ExcelDown";

		

	}



@SuppressWarnings("deprecation")

public class ExcelDown extends AbstractExcelView {



	@Autowired

	private MngService mngService;

	

	@Override

	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,

			HttpServletResponse response) throws Exception {

		

		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

	    //String userAgent = request.getHeader("User-Agent");

	    String header = "test_" + formatter.format(new Date());

	    String fileName = header + ".xls";

		

	    String mimetype = "application/x-msdownload";

	    

	    response.setContentType(mimetype);

	    

	    FileUtil.setDisposition(fileName, request, response);

	    

	    HSSFSheet excelSheet = createFirstSheet(workbook, header);

	    

	    setExcelHeader(excelSheet, header);

	    

	    String dataStatus = ServletRequestUtils.getStringParameter(request, "dataStatus", "");

	    String searchType = ServletRequestUtils.getStringParameter(request, "searchType", "");

	    String searchType1 = ServletRequestUtils.getStringParameter(request, "searchType1", "");

	    String searchType2 = ServletRequestUtils.getStringParameter(request, "searchType2", "");

	    String searchType3 = ServletRequestUtils.getStringParameter(request, "searchType3", "");

	    String searchType4 = ServletRequestUtils.getStringParameter(request, "searchType4", "");

	    String searchDvsn1 = ServletRequestUtils.getStringParameter(request, "searchDvsn1", "");

	    String searchTxt = ServletRequestUtils.getStringParameter(request, "searchTxt", "");

	    

	    MngVO VO = new MngVO();

	    VO.setSearchType(searchType);

	   VO.setSearchDvsn1(searchDvsn1);

	    VO.setSearchType1(searchType1);

	   VO.setSearchType2(searchType2);

	    VO.setSearchType3(searchType3);

	    VO.setSearchType4(searchType4);

	    VO.setSearchTxt(searchTxt);

	    

	    List<MngVO> List = new ArrayList<MngVO>();

	    List = mngService.selectExcelList(VO);

	    etExcelRows(excelSheet, List, request);

	    

	}

	

	private HSSFSheet createFirstSheet(HSSFWorkbook workbook, String header) {

		HSSFSheet excelSheet = workbook.createSheet(header);

		excelSheet.setColumnWidth(0, 1500);

		excelSheet.setColumnWidth(1, 6000);

	    excelSheet.setColumnWidth(2, 6000);

	    excelSheet.setColumnWidth(3, 6000);

	    excelSheet.setColumnWidth(4, 6000);

	    excelSheet.setColumnWidth(5, 18000);

		return excelSheet;

	}



	private void setExcelHeader(HSSFSheet excelSheet, String header) {

		

		excelSheet.createRow(0).createCell(0).setCellValue(header);

		HSSFRow excelHeader = excelSheet.createRow(1);

		excelHeader.createCell(0).setCellValue("번호");

		excelHeader.createCell(1).setCellValue("구분 1");

		excelHeader.createCell(2).setCellValue("구분 2");

		excelHeader.createCell(3).setCellValue("  ");

		excelHeader.createCell(4).setCellValue("  ");

		excelHeader.createCell(5).setCellValue("  ");

		

	}

	

	private void etExcelRows(HSSFSheet excelSheet, List<MngVO> List, HttpServletRequest request) {

		

		@SuppressWarnings("unused")

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		int record = 1;

	    int idx = 1;

	    for (MngVO ctn : List) {

	    	HSSFRow excelRow = excelSheet.createRow(++record);

	        excelRow.createCell(0).setCellValue(idx++);

	        excelRow.createCell(1).setCellValue(ctn.get());

	        excelRow.createCell(2).setCellValue(ctn.get());

	        excelRow.createCell(3).setCellValue(ctn.get());

	        excelRow.createCell(4).setCellValue(ctn.get());

	        excelRow.createCell(5).setCellValue(ctn.get());

	        

	        

	        String downloadUrl = request.getScheme() + "://" + request.getServerName();

	        if( (request.getServerPort() != 80) && (request.getServerPort() != 443)) {

	        	downloadUrl = downloadUrl + ":" + request.getServerPort();

	        }

	        

	        downloadUrl = downloadUrl + request.getContextPath();

	        List<FileVO> fileList = ctn.getAttachFiles();

	        

	        if(fileList != null){

	        	int chkNo = 0;

	        	for (FileVO fileVO : fileList) {

	        		HSSFHyperlink download_link = new HSSFHyperlink(1);

	        		download_link.setAddress(downloadUrl + "/FileDown.do?atchFileId=" + fileVO.getAtchFileId() + "&fileSn=" + fileVO.getFileSn());

	        		

	        		Cell cell = excelRow.createCell(8 + chkNo);

	        		cell.setHyperlink(download_link);

	        		cell.setCellValue(fileVO.getOrignlFileNm());

	        		chkNo++;

				}

	        }

		}

	    

	}







}

