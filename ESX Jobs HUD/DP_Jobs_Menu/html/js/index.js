$(function() {
  $(document).keyup(function(e) {
      if (e.keyCode == 27) {
          $(".container-fluid").fadeOut();
          $.post('http://DP_Jobs_Menu/fechar', JSON.stringify({}));
      }
  });
  $(document).ready(function() {
      window.addEventListener('message', function(event) {
          var item = event.data;
          if (item.ativa == true) {
              $('.container-fluid').css('display', 'block');
          } else if (item.ativa == false) {
              $('.container-fluid').css('display', 'none');
          }
      });

      $("#1").click(function() {
          $.post('http://DP_Jobs_Menu/1', JSON.stringify({}));
          2

      });

      $("#2").click(function() {
          $.post('http://DP_Jobs_Menu/2', JSON.stringify({}));
          2

      });

      $("#3").click(function() {
          $.post('http://DP_Jobs_Menu/3', JSON.stringify({}));
          2

      });

      $("#4").click(function() {
          $.post('http://DP_Jobs_Menu/4', JSON.stringify({}));
          2

      });

      $("#5").click(function() {
          $.post('http://DP_Jobs_Menu/5', JSON.stringify({}));
          2

      });

      $("#6").click(function() {
          $.post('http://DP_Jobs_Menu/6', JSON.stringify({}));
          2

      });

      $("#7").click(function() {
          $.post('http://DP_Jobs_Menu/7', JSON.stringify({}));
          2

      });

      $("#8").click(function() {
          $.post('http://DP_Jobs_Menu/8', JSON.stringify({}));
          2

      });

      $("#9").click(function() {
          $.post('http://DP_Jobs_Menu/9', JSON.stringify({}));
          2

      });

      $("#10").click(function() {
          $.post('http://DP_Jobs_Menu/10', JSON.stringify({}));
          2

      });

      $("#11").click(function() {
          $.post('http://DP_Jobs_Menu/11', JSON.stringify({}));
          2

      });

      $("#12").click(function() {
          $.post('http://DP_Jobs_Menu/12', JSON.stringify({}));
          2

      });

      $("#13").click(function() {
          $.post('http://DP_Jobs_Menu/13', JSON.stringify({}));
          2

      });

      $("#14").click(function() {
          $.post('http://DP_Jobs_Menu/14', JSON.stringify({}));
          2

      });

      $("#15").click(function() {
          $.post('http://DP_Jobs_Menu/15', JSON.stringify({}));
          2

      });

      $("#rova").click(function() {
          $.post('http://DP_Jobs_Menu/rova', JSON.stringify({}));
          2

      });

      $("#brinks").click(function() {
          $.post('http://DP_Jobs_Menu/brinks', JSON.stringify({}));
          2

      });

      $("#builder").click(function() {
          $.post('http://DP_Jobs_Menu/builder', JSON.stringify({}));
          2

      });

      $("#slaughterer").click(function() {
          $.post('http://DP_Jobs_Menu/slaughterer', JSON.stringify({}));
          2

      });

      $("#lumberjack").click(function() {
          $.post('http://DP_Jobs_Menu/lumberjack', JSON.stringify({}));
          2

      });

      $("#tailor").click(function() {
          $.post('http://DP_Jobs_Menu/tailor', JSON.stringify({}));
          2

      });

      $("#gardener").click(function() {
          $.post('http://DP_Jobs_Menu/gardener', JSON.stringify({}));
          2

      });

      $("#pizza").click(function() {
          $.post('http://DP_Jobs_Menu/pizza', JSON.stringify({}));
          2

      });

  })
})



let scale = 0;
const cards = Array.from(document.getElementsByClassName("job"));
const inner = document.querySelector(".inner");

function slideAndScale() {
  cards.map((card, i) => {
      card.setAttribute("data-scale", i + scale);
      inner.style.transform = "translateX(" + scale * 8.5 + "em)";
  });
}

(function init() {
  slideAndScale();
  cards.map((card, i) => {
      card.addEventListener("click", () => {
          const id = card.getAttribute("data-scale");
          if (id !== 2) {
              scale -= id - 2;
              slideAndScale();
          }
      }, false);
  });
})();