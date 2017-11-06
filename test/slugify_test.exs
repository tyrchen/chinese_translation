defmodule ChineseTranslationTest.Slugify do
  use ExUnit.Case

  test "can slugify the chinese chanraters" do
    assert ChineseTranslation.slugify("长大以后的长工") == "zhang-da-yi-hou-de-chang-gong"
  end

  test "can slugify the chinese chanraters with tone" do
    assert ChineseTranslation.slugify("长大以后的长工", [:tone]) == "zhang3-da4-yi3-hou4-de-chang2-gong1"
  end

  test "can slugify the tranditional chinese chanraters" do
    assert ChineseTranslation.slugify("長大以後的長工", [:trad]) == "zhang-da-yi-hou-de-chang-gong"
  end

  test "can slugify the tranditional chinese chanraters with tone" do
    assert ChineseTranslation.slugify("長大以後的長工", [:trad, :tone]) ==
             "zhang3-da4-yi3-hou4-de-chang2-gong1"
  end
end
