package bookInfo;


public class BookInfoBean {
	private String bookName, bookDetails, bookImg, bookPub, author;
	private int bookNum, bookPrice, bookStock;
	
	public static int pageSize = 10;
	public static int pageCount = 1;
	public static int pageNum = 1;

	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getBookDetails() {
		return bookDetails;
	}
	public void setBookDetails(String bookDetails) {
		this.bookDetails = bookDetails;
	}
	public String getBookImg() {
		return bookImg;
	}
	public void setBookImg(String bookImg) {
		this.bookImg = bookImg;
	}
	public String getBookPub() {
		return bookPub;
	}
	public void setBookPub(String bookPub) {
		this.bookPub = bookPub;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getBookNum() {
		return bookNum;
	}
	public void setBookNum(int bookNum) {
		this.bookNum = bookNum;
	}
	public int getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}
	public int getBookStock() {
		return bookStock;
	}
	public void setBookStock(int bookStock) {
		this.bookStock = bookStock;
	}
	
	public static String pageNumber(int limit, String category) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;
		
		// [prev page] 버튼 출력
		if ((startPage - limit) > 0) {
			str = "<a href='searchResult.jsp?pageNum=" + (startPage - 1) + "&category="+category+"'>이전</a>";
		}
		
		// 페이지 번호 나열
		for (int i = startPage; i < (startPage + limit); i++) {
			if (i == pageNum) {
				str += "<a class='page' href='#'>" + i + "</a>";
			} else {
				str += "<a class='page' href='searchResult.jsp?pageNum=" + i + "&category="+category+"'>" + i + "</a>";
			}
			if(i >= pageCount) break;
		}
		
		// [next page] 버튼 출력
		if ((startPage + limit) <= pageCount) {
			str += "<a class='page' href='searchResult.jsp?pageNum=" + (startPage + limit) + "&category="+category+"'>다음</a>";
		}
		
		return str;
	}
	
	public static String pageNumberBest(int limit, String category) {
		String str = "";
		int temp = (pageNum - 1) % limit;
		int startPage = pageNum - temp;
		
		// [prev page] 버튼 출력
		if ((startPage - limit) > 0) {
			str = "<a class='page' href='cateBest.jsp?pageNum=" + (startPage - 1) + "&category="+category+"'>이전</a>";
		}
		
		// 페이지 번호 나열
		for (int i = startPage; i < (startPage + limit); i++) {
			if (i == pageNum) {
				str += "<a class='page' href='#'>" + i + "</a>";
			} else {
				str += "<a class='page' href='cateBest.jsp?pageNum=" + i + "&category="+category+"'>" + i + "</a>";
			}
			if(i >= pageCount) break;
		}
		
		// [next page] 버튼 출력
		if ((startPage + limit) <= pageCount) {
			str += "<a class='page' href='cateBest.jsp?pageNum=" + (startPage + limit) + "&category="+category+"'>다음</a>";
		}
		
		return str;
	}
}
