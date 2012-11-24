#encoding: utf-8
require './calorie.rb'
require 'rspec'

describe 'マクドナルドのカロリー計算' do
  describe 'メニュー名を渡したとき' do
    it "グラコロは434カロリー" do
      FastFood.calorie("グラコロ").should eq({'グラコロ' => 434})
    end

    it "デミチーズグラコロは508カロリー" do
      FastFood.calorie("デミチーズグラコロ").should eq({'デミチーズグラコロ' => 508})
    end
  end

  describe 'あいまいな名前のとき' do
    it 'ナゲットのときは5ピースのカロリーを返す' do
      FastFood.calorie('ナゲット').should eq({'5ピース チキンマックナゲット' => 280})
    end
    it 'シェイクのときはバニラ味のSサイズのカロリーを返す' do
      FastFood.calorie('シェイク').should eq({'マックシェイク バニラ(S)' => 206})
    end
  end

  describe 'メニュー名にスペースが入ってるとき' do
    it '5ピース チキンマックナゲット'
  end

  describe '複数渡したとき' do
    describe 'スペース区切り' do
      it 'グラコロ デミチーズグラコロ' do
        FastFood.calorie('グラコロ デミチーズグラコロ').should eq({'グラコロ' => 434, 'デミチーズグラコロ' => 508})
      end

      it 'スペースの入った、「マックシェイク バニラ(S) ナゲット」(ナゲットは曖昧なやつ)' do
        FastFood.calorie('マックシェイク バニラ(S) ナゲット').should eq({'マックシェイク バニラ(S)' => 206, '5ピース チキンマックナゲット' => 280})
      end
    end

    describe '、区切りで' do
      it 'グラコロ、デミチーズグラコロ' do
        FastFood.calorie('グラコロ、デミチーズグラコロ').should eq({'グラコロ' => 434, 'デミチーズグラコロ' => 508})
      end
    end
  end

  it 'サンデーチョコ'
  it 'サンデー チョコ'

  describe 'セットのカロリー' do
  end

# - セット
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
    it 'ナゲット2つ'
    it 'ハンバーガー2個'
    it 'アイスコーヒー2杯'
    it 'アイスコーヒーx2'
    it 'アイスコーヒー x2'
    it 'アイスコーヒー x 2'
    it 'アイスコーヒー*2'
  end
end
