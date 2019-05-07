let adSelectors = [
  'iframe',
  'aside .csdn-tracking-statistics.mb8.box-shadow',
  'aside .right_box.footer_box.csdn-tracking-statistics',
  '.indexSuperise',
  '#adContent',
  '#reportContent',
  '.recommend-box',
  '.recommend-right',
  '.hide-article-box.hide-article-pos.text-center'
]

document.querySelectorAll(adSelectors.join(',')).forEach(item => {
  item.style.display = 'none'
})

var readmore = document.getElementById("btn-readmore");
readmore.removeAttribute('data-track-click');
readmore.click();
