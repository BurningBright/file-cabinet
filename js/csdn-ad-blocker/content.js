let adSelectors = [
  'iframe',
  'aside .csdn-tracking-statistics.mb8.box-shadow',
  'aside .right_box.footer_box.csdn-tracking-statistics',
  '.recommend-right'
]

document.querySelectorAll(adSelectors.join(',')).forEach(item => {
  item.style.display = 'none'
})

