import java.util.List;

public class insertUpdateVO {

	private String unqId;
	private String bisYear;
	private String entId;
	private int landingJobNum = 0;
	private int incentiveTot = 0;
	private String regDt;
	private String rgtrUnqId;
	private String mdfcnDt;
	private String mdfrUnqId;

	private String entNm;
	private String entNo;
	private String entOwner;
	private String entType;
	private String creatDt;
	private String codeNm;

	private List<ManageEmpIncentiveEachVO> eachList;
	private List<ManageEmpIncentiveEachVO> insertEachList;
	private List<String> deleteEachList;

	public List<String> getDeleteEachList() {
		return deleteEachList;
	}
	public void setDeleteEachList(List<String> deleteEachList) {
		this.deleteEachList = deleteEachList;
	}
	public String getEntType() {
		return entType;
	}
	public void setEntType(String entType) {
		this.entType = entType;
	}
	public String getCreatDt() {
		return creatDt;
	}
	public void setCreatDt(String creatDt) {
		this.creatDt = creatDt;
	}
	public String getEntOwner() {
		return entOwner;
	}
	public void setEntOwner(String entOwner) {
		this.entOwner = entOwner;
	}
	public List<ManageEmpIncentiveEachVO> getInsertEachList() {
		return insertEachList;
	}
	public void setInsertEachList(List<ManageEmpIncentiveEachVO> insertEachList) {
		this.insertEachList = insertEachList;
	}
	public List<ManageEmpIncentiveEachVO> getEachList() {
		return eachList;
	}
	public void setEachList(List<ManageEmpIncentiveEachVO> eachList) {
		this.eachList = eachList;
	}
	public String getEntNm() {
		return entNm;
	}
	public void setEntNm(String entNm) {
		this.entNm = entNm;
	}
	public String getEntNo() {
		return entNo;
	}
	public void setEntNo(String entNo) {
		this.entNo = entNo;
	}
	public String getUnqId() {
		return unqId;
	}
	public void setUnqId(String unqId) {
		this.unqId = unqId;
	}
	public String getBisYear() {
		return bisYear;
	}
	public void setBisYear(String bisYear) {
		this.bisYear = bisYear;
	}
	public String getEntId() {
		return entId;
	}
	public void setEntId(String entId) {
		this.entId = entId;
	}
	public int getLandingJobNum() {
		return landingJobNum;
	}
	public void setLandingJobNum(int landingJobNum) {
		this.landingJobNum = landingJobNum;
	}
	public int getIncentiveTot() {
		return incentiveTot;
	}
	public void setIncentiveTot(int incentiveTot) {
		this.incentiveTot = incentiveTot;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getRgtrUnqId() {
		return rgtrUnqId;
	}
	public void setRgtrUnqId(String rgtrUnqId) {
		this.rgtrUnqId = rgtrUnqId;
	}
	public String getMdfcnDt() {
		return mdfcnDt;
	}
	public void setMdfcnDt(String mdfcnDt) {
		this.mdfcnDt = mdfcnDt;
	}
	public String getMdfrUnqId() {
		return mdfrUnqId;
	}
	public void setMdfrUnqId(String mdfrUnqId) {
		this.mdfrUnqId = mdfrUnqId;
	}
	public String getCodeNm() {
		return codeNm;
	}
	public void setCodeNm(String codeNm) {
		this.codeNm = codeNm;
	}



}
