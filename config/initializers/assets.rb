# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('app','assets', 'fonts')
Rails.application.config.assets.precompile.select{ |path| path.is_a?(Proc) }

Rails.application.config.assets.precompile += %w( login.css )
Rails.application.config.assets.precompile += %w( layout/dashboard.js layout/mandatory_vendors.js layout/scripts.bundle.js layout/app.bundle.js )
Rails.application.config.assets.precompile += %w( vendors/jquery.repeater/src/lib.js vendors/jquery.repeater/src/jquery.input.js vendors/jquery.repeater/src/repeater.js vendors/jquery-form/dist/jquery.form.min.js vendors/block-ui/jquery.blockUI.js vendors/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js vendors/js/framework/components/plugins/forms/bootstrap-datepicker.init.js vendors/bootstrap-datetime-picker/js/bootstrap-datetimepicker.min.js vendors/bootstrap-timepicker/js/bootstrap-timepicker.min.js vendors/js/framework/components/plugins/forms/bootstrap-timepicker.init.js vendors/bootstrap-daterangepicker/daterangepicker.js vendors/js/framework/components/plugins/forms/bootstrap-daterangepicker.init.js vendors/bootstrap-touchspin/dist/jquery.bootstrap-touchspin.js vendors/bootstrap-maxlength/src/bootstrap-maxlength.js vendors/bootstrap-switch/dist/js/bootstrap-switch.js vendors/js/framework/components/plugins/forms/bootstrap-switch.init.js vendors/vendors/bootstrap-multiselectsplitter/bootstrap-multiselectsplitter.min.js vendors/bootstrap-select/dist/js/bootstrap-select.js vendors/select2/dist/js/select2.full.js vendors/typeahead.js/dist/typeahead.bundle.js vendors/handlebars/dist/handlebars.js vendors/inputmask/dist/jquery.inputmask.bundle.js vendors/inputmask/dist/inputmask/inputmask.date.extensions.js vendors/inputmask/dist/inputmask/inputmask.numeric.extensions.js vendors/inputmask/dist/inputmask/inputmask.phone.extensions.js vendors/nouislider/distribute/nouislider.js vendors/owl.carousel/dist/owl.carousel.js vendors/autosize/dist/autosize.js vendors/clipboard/dist/clipboard.min.js vendors/ion-rangeslider/js/ion.rangeSlider.js vendors/dropzone/dist/dropzone.js )
Rails.application.config.assets.precompile += %w( vendors/summernote/dist/summernote.js vendors/markdown/lib/markdown.js vendors/bootstrap-markdown/js/bootstrap-markdown.js vendors/js/framework/components/plugins/forms/bootstrap-markdown.init.js vendors/jquery-validation/dist/jquery.validate.js vendors/jquery-validation/dist/additional-methods.js vendors/js/framework/components/plugins/forms/jquery-validation.init.js vendors/bootstrap-notify/bootstrap-notify.min.js vendors/js/framework/components/plugins/base/bootstrap-notify.init.js  )
Rails.application.config.assets.precompile += %w( vendors/toastr/build/toastr.min.js vendors/jstree/dist/jstree.js vendors/raphael/raphael.js vendors/morris.js/morris.js vendors/chartist/dist/chartist.js vendors/chart.js/dist/Chart.bundle.js vendors/validator.js )
Rails.application.config.assets.precompile += %w( vendors/vendors/bootstrap-session-timeout/dist/bootstrap-session-timeout.min.js  )
Rails.application.config.assets.precompile += %w( vendors/datatables/datatables.bundle.js app/find_cep.js )
Rails.application.config.assets.precompile += %w( vendors/vendors/jquery-idletimer/idle-timer.min.js vendors/waypoints/lib/jquery.waypoints.js vendors/counterup/jquery.counterup.js vendors/es6-promise-polyfill/promise.min.js vendors/sweetalert2/dist/sweetalert2.min.js )
Rails.application.config.assets.precompile += %w( vendors/js/framework/components/plugins/base/sweetalert2.init.js vendors/fullcalendar/fullcalendar.bundle.js vendors/bootstrap-tagsinput/bootstrap-tagsinput.js vendors/handsontable/handsontable.js vendors/summernote/dist/summernote.js )
Rails.application.config.assets.precompile += %w( app/home/projects.js app/adjust_ts/new.js app/adjust_ts/index.js )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
