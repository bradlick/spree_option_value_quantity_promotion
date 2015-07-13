# this is a hack because I don't know how to add to promotion_rules/create.js.erb

set_option_value_quantity_selects = ->
  $('.option-value-select').optionValueAutocomplete
    multiple: false
  $('.quantity-comparison-select').select2()
  return

original_set_taxon_select = window.set_taxon_select;
window.set_taxon_select = (selector) ->
  set_option_value_quantity_selects()
  original_set_taxon_select selector

$(document).ready () ->
  set_option_value_quantity_selects()