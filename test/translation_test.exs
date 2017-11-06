defmodule ChineseTranslationTest.Translation do
  use ExUnit.Case
  doctest ChineseTranslation

  test "can translate character t->s" do
    assert ChineseTranslation.translate("萬") == "万"
  end

  test "can translate character s->t" do
    assert ChineseTranslation.translate("万", :s2t) == "萬"
  end

  test "can translate words t->s" do
    assert ChineseTranslation.translate("幹線") == "干线"
  end

  test "can translate words s->t" do
    assert ChineseTranslation.translate("干线", :s2t) == "幹線"
  end

  test "can do maximum translation t->s" do
    assert ChineseTranslation.translate("秋陰入井幹線上線下") == "秋阴入井干线上线下"
  end

  test "can do maximum translation s->t" do
    assert ChineseTranslation.translate("秋阴入井干线上线下", :s2t) == "秋陰入井幹線上線下"
  end

  @trad_s """
  《京華春夢》（英語：Yesterday's Glitter）是香港電視廣播有限公司拍攝製作的清末民初劇集，於1980年5月26日期間首播，原定20集，後因播出時觀眾反映強烈增至25集，由劉松仁、汪明荃、鄧碧雲及鮑方領銜主演，監製王天林，外景拍攝場地景賢里。主題曲及多首插曲由顧嘉輝作曲，鄧偉雄、黃霑填詞，汪明荃主唱。
  """

  @simp_s """
  《京华春梦》（英语：Yesterday's Glitter）是香港电视广播有限公司拍摄制作的清末民初剧集，于1980年5月26日期间首播，原定20集，后因播出时观众反映强烈增至25集，由刘松仁、汪明荃、邓碧云及鲍方领衔主演，监制王天林，外景拍摄场地景贤里。主题曲及多首插曲由顾嘉辉作曲，邓伟雄、黄霑填词，汪明荃主唱。
  """

  test "translate a 158-character sentence s->t" do
    assert ChineseTranslation.translate(@simp_s, :s2t) == @trad_s
  end

  test "translate a 158-character sentence t->s" do
    assert ChineseTranslation.translate(@trad_s) == @simp_s
  end

  @trad """
  2006年威斯特徹斯特縣龍捲風是威斯特徹斯特縣有紀錄以來最強烈，規模最大的龍捲風，於2006年7月12日在紐約州着陸，然後行進了21公里進入康涅狄格州西南部，一共行經兩個州，持續時間為33分鐘。這場龍捲風於北美東部時區下午15點30分在哈德遜河岸着陸，接下來變成海龍捲風前進了5公里穿過該河。上岸後，龍捲風進入威斯特徹斯特縣並以F1級強度襲擊了斷頭谷。穿過該鎮後，系統增強為F2級龍捲風，直徑增大到近400米。龍捲風繼續穿越該縣直至於EDT下午16點01分進入康涅狄格州，並很快於EDT下午16點03分在該州的格林尼治消散。此次龍捲風導致兩座穀倉和一個倉庫被毀，還有一扇大型彩繪玻璃窗戶被震碎，多家商鋪受損，成千上萬的樹木被連根拔起，總計造成的經濟損失約為1210萬美元。幸運的是沒有人因這場龍捲風而喪生，一共只有六人受傷
  """
  @simp """
  2006年威斯特彻斯特县龙卷风是威斯特彻斯特县有纪录以来最强烈，规模最大的龙卷风，于2006年7月12日在纽约州着陆，然后行进了21公里进入康涅狄格州西南部，一共行经两个州，持续时间为33分钟。这场龙卷风于北美东部时区下午15点30分在哈德逊河岸着陆，接下来变成海龙卷风前进了5公里穿过该河。上岸后，龙卷风进入威斯特彻斯特县并以F1级强度袭击了断头谷。穿过该镇后，系统增强为F2级龙卷风，直径增大到近400米。龙卷风继续穿越该县直至于EDT下午16点01分进入康涅狄格州，并很快于EDT下午16点03分在该州的格林尼治消散。此次龙卷风导致两座谷仓和一个仓库被毁，还有一扇大型彩绘玻璃窗户被震碎，多家商铺受损，成千上万的树木被连根拔起，总计造成的经济损失约为1210万美元。幸运的是没有人因这场龙卷风而丧生，一共只有六人受伤
  """

  test "can translate sentenses t->s" do
    assert ChineseTranslation.translate(@trad) == @simp
  end

  test "can translate sentenses s->t" do
    assert ChineseTranslation.translate(@simp, :s2t) == @trad
  end
end
