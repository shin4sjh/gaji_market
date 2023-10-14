package kh.spring.gaji.goods.model.Service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.spring.gaji.goods.model.dao.GoodsDao;
import kh.spring.gaji.goods.model.dto.GoodsDto;
import kh.spring.gaji.goods.model.dto.GoodsInfoDto;
import kh.spring.gaji.goods.model.dto.GoodsListDto;
import kh.spring.gaji.goods.model.dto.GoodsListInfoDto;


@Service
public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsDao goodsDao;
	
	@Override
	public int insertGoods(GoodsDto goodsDto) {
		return goodsDao.insertGoods(goodsDto);
	}

	@Override
	public GoodsInfoDto getGoodsInfo(int goodsId) {
		return goodsDao.getGoodsInfo(goodsId);
	}

	@Override
	public int updateStatus(Map<String, Object> map) {
		return goodsDao.updateStatus(map);
	}

	@Override
	public int updateGoods(GoodsDto goodsDto) {
		return goodsDao.updateGoods(goodsDto);
	}

	@Override
	public int deleteGoods(int goodsId) {
		return goodsDao.deleteGoods(goodsId);
	}

	@Override
	public Map<String,Object> getGoodsList(int currentPage, int PAGESIZE, int sort, int priceCeiling,
	int category, int dongId, String searchWord) {
		Map<String,Object> result=new HashMap<String,Object>();
		GoodsListInfoDto goodsListInfo=goodsDao.getGoodsListInfo(priceCeiling, category, dongId, searchWord);
		int totalCnt=goodsListInfo.getTotalCnt();
		int averagePrice=goodsListInfo.getAveragePrice();
		int topPrice=goodsListInfo.getTopPrice();
		int bottomPrice=goodsListInfo.getBottomPrice();
		result.put("totalCnt",totalCnt);
		result.put("averagePrice",averagePrice);
		result.put("topPrice",topPrice);
		result.put("bottomPrice",bottomPrice);
		result.put("totalCnt",totalCnt);
		result.put("goodsListDto", goodsDao.getGoodsList(currentPage,PAGESIZE,sort,priceCeiling,
				category,dongId,searchWord,totalCnt));
		return result;
	}
}
