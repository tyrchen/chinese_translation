defmodule ChineseTranslationTest.Pinyin do
  use ExUnit.Case

  test "can translate chinese into pinyin" do
    assert ChineseTranslation.pinyin("铸模") == "zhù mó"
  end

  test "can translate traditional chinese into pinyin" do
    assert ChineseTranslation.pinyin("幹線", :trad) == "gàn xiàn"
  end

  test "can translate character with multiple pronouciation to pinyin" do
    assert ChineseTranslation.pinyin("长大以后的长工") == "zhǎng dà yǐ hòu de cháng gōng"
  end
end
