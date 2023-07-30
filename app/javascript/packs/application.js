// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('turbolinks:load', function() {
  // モーダル表示用の関数
  function openModal() {
    document.getElementById('modal').style.display = 'block';
  }

  // 閉じるボタンのクリックイベント
  document.getElementsByClassName('close')[0].onclick = function() {
    document.getElementById('modal').style.display = 'none';
  };

  // モーダルの外側をクリックしたら閉じる
  window.onclick = function(event) {
    var modal = document.getElementById('modal');
    if (event.target == modal) {
      modal.style.display = 'none';
    }
  };

  // ユーザー紹介ボタンのクリックイベント
  var introButton = document.getElementById('intro-button');
  introButton.onclick = function() {
    openModal();
  };
});

//フォロー中にカーソルを合わせると文字が変わるイベント
document.addEventListener("DOMContentLoaded", function() {
  const followBtns = document.querySelectorAll(".follow-btn");
  followBtns.forEach(btn => {
    btn.addEventListener("mouseover", function() {
      if (this.classList.contains("followed")) {
        this.textContent = "フォロー解除";
      }
    });
    btn.addEventListener("mouseout", function() {
      if (this.classList.contains("followed")) {
        this.textContent = "フォロー中";
      }
    });
  });
});

