#encoding: utf-8
require './calorie.rb'
require 'rspec'

describe 'マクドナルドのカロリー計算' do
  describe 'メニュー名を渡したとき' do
    it "グラコロは434カロリー" do
      FastFood.calorie("グラコロ").should eq(434)
    end

    it "デミチーズグラコロは508カロリー" do
      FastFood.calorie("デミチーズグラコロ").should eq(508)
    end
  end

  describe 'あいまいな名前のとき' do
    it 'ナゲットのときは5ピースのカロリーを返す' do
      FastFood.calorie('ナゲット').should eq(280)
    end
    it 'シェイクのときはバニラ味のSサイズのカロリーを返す' do
      FastFood.calorie('シェイク').should eq(206)
    end
  end

  describe 'メニュー名にスペースが入ってるとき' do
    it '5ピース チキンマックナゲット'
  end

  describe '複数渡したとき' do
    describe 'スペース区切り' do
      it 'グラコロ デミチーズグラコロ' do
        FastFood.calorie('グラコロ デミチーズグラコロ').should eq(434 + 508)
      end
    end

    describe '、区切りで' do
      it 'グラコロ、デミチーズグラコロ' do
        FastFood.calorie('グラコロ、デミチーズグラコロ').should eq(434 + 508)
      end
    end
  end

  it 'サンデーチョコ'
  it 'サンデー チョコ'

  describe 'セットのカロリー' do
  end

# - セット(自分でやらないので後回し)
# - サイズ
# - 個数
# - 味

  describe 'フレーバーが違う別メニュー' do
    it 'シェイクのチョコ味'
  end

  describe '飲み物のサイズ' do
    it 'アイスコーヒーはデフォルトでS'
    it 'アイスコーヒーMサイズ'
    it 'Qoo M'
  end

  describe '個数を渡したとき' do
    it 'ナゲット2つ' do
      FastFood.calorie('ナゲット2つ').should eq(560)
    end
    it 'ナゲット2個' do
      FastFood.calorie('ナゲット2個').should eq(560)
    end
    it 'アイスコーヒー2杯' do
      FastFood.calorie('アイスコーヒー2杯').should eq(12)
    end
    it 'アイスコーヒーx2' do
      FastFood.calorie('アイスコーヒーx2').should eq(12)
    end
    it 'アイスコーヒー x2' do
      FastFood.calorie('アイスコーヒー x2').should eq(12)
    end
    it 'アイスコーヒー*2' do
      FastFood.calorie('アイスコーヒー*2').should eq(12)
    end
  end
end
