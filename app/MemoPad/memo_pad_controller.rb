require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'date'

class MemoPadController < Rho::RhoController
  include BrowserHelper

  # GET /MemoPad
  def index
    @memopads = MemoPad.find(:all)
    render :back => '/app'
  end

  # GET /MemoPad/{1}
  def show
    @memopad = MemoPad.find(@params['id'])
    if @memopad
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /MemoPad/new
  def new
    @memopad = MemoPad.new
    
    # デフォルトで日付をアサインする
    # フォーム側も日付を入れ込むように編集する
    @today   = Date.today().to_s()
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /MemoPad/{1}/edit
  def edit
    @memopad = MemoPad.find(@params['id'])
    if @memopad
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /MemoPad/create
  def create
    # 本文がなければ、作らない
    # タイトルが空欄ならば、デフォルトで"(今日の日付)のメモ"というタイトルにする
    if @params['memopad']['body'] && @params['memopad']['body'] != ''
      if @params['memopad']['subject'] == ''
        @params['memopad']['subject'] = "#{Date.today().to_s()}のメモ"
      end
      
      @memopad = MemoPad.create(@params['memopad'])
    end
    
    redirect :action => :index
  end

  # POST /MemoPad/{1}/update
  def update
    @memopad = MemoPad.find(@params['id'])
    @memopad.update_attributes(@params['memopad']) if @memopad
    redirect :action => :index
  end

  # POST /MemoPad/{1}/delete
  def delete
    @memopad = MemoPad.find(@params['id'])
    @memopad.destroy if @memopad
    redirect :action => :index  
  end
end
