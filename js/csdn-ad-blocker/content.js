let adSelectors = [
  'iframe',
  'aside .csdn-tracking-statistics.mb8.box-shadow',
  'aside .right_box.footer_box.csdn-tracking-statistics',
  '.indexSuperise',
  '#adContent',
  '#reportContent',
  '.recommend-box',
  '.recommend-right',
  '.pulllog-box',
  '#article_content a img'
]

document.querySelectorAll(adSelectors.join(',')).forEach(item => {
  item.style.display = 'none'
})

var readmore = document.getElementById("btn-readmore");
readmore.removeAttribute('data-track-click');
readmore.click();
