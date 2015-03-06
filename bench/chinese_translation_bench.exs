defmodule ChineseTranslationBench do
  use Benchfella

  bench "translate a character s->t" do
    ChineseTranslation.translate("国", :s2t)
  end

  bench "translate a character t->s" do
    ChineseTranslation.translate("國")
  end

  @trad "《京華春夢》（英語：Yesterday's Glitter）是香港電視廣播有限公司拍攝製作的清末民初劇集，於1980年5月26日期間首播，原定20集，後因播出時觀眾反映強烈增至25集，由劉松仁、汪明荃、鄧碧雲及鮑方領銜主演，監製王天林，外景拍攝場地景賢里。主題曲及多首插曲由顧嘉煇作曲，鄧偉雄、黃霑填詞，汪明荃主唱。"

  @simp "《京华春梦》（英语：Yesterday's Glitter）是香港电视广播有限公司拍摄制作的清末民初剧集，于1980年5月26日期间首播，原定20集，后因播出时观众反映强烈增至25集，由刘松仁、汪明荃、邓碧云及鲍方领衔主演，监制王天林，外景拍摄场地景贤里。主题曲及多首插曲由顾嘉辉作曲，邓伟雄、黄霑填词，汪明荃主唱。"

  bench "translate a 158-character sentence s->t" do
    ChineseTranslation.translate(@simp, :s2t)
  end

  bench "translate a 158-character sentence t->s" do
    ChineseTranslation.translate(@trad)
  end

  bench "translate 158-character chinese to pinyin" do
    ChineseTranslation.pinyin(@simp)
  end

  @pinyin ChineseTranslation.pinyin("长大以后变成长工")
  bench "slugify pinyin" do
    ChineseTranslation.slugify(@pinyin, [:pinyin])
  end

  bench "slugify pinyin with tone" do
    ChineseTranslation.slugify(@pinyin, [:pinyin, :tone])
  end


  bench "slugify a short sentence" do
    ChineseTranslation.slugify("长大以后变成长工")
  end
end
