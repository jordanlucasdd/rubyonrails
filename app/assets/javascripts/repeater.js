class Repeater {
  
  constructor(element, params) {

    this.element = $(element);
    this.loadParams(params);
    this.lastId = null;
    this.list = this.element.find('[data-repeater-list]');
    this.template_element = this.element.find('template');

    this.loadTemplate();
    this.loadAdd();
    this.loadRmButton(this.element.find('[data-repeater-delete]'),this)
  }

  itens(){
    return this.element.find('[data-repeater-item]')
  }

  last(){
    let index = this.itens().length - 1
    return this.itens()[index]
  }

  loadTemplate(){
    let content = this.template_element.html();
    content = content.replace(/data-repeater-item="([^"]+)"/, 'data-repeater-item="id-template"');
    this.template = content;
    this.template_element.remove();
  }


  loadAdd(){
    var element = this.element;
    var template = this.template;
    var loadRmButton = this.loadRmButton;
    var repeater = this;
    this.element.find('[data-repeater-create]').click(function(){
      let list = element.find('[data-repeater-list]');
      let id = repeater.generateID();
      list.append(template.replace(/id-template/g,id));
      let btnRm = list.find('[data-repeater-item]').last().find('[data-repeater-delete]')
      if (btnRm != undefined){
        btnRm.data('repeater-delete',id);
        loadRmButton(btnRm,repeater);
      }
      repeater.afterCreate(repeater);
    });

    
  }

  loadRmButton(sender,repeater){
    sender.click(function(){
        let id = $(this).data('repeater-delete');
        $("[data-repeater-item='"+id+"']").remove();
        repeater.afterRemove(repeater);
    });
  }

  loadParams(params){
    if (params == undefined) {
      this.params = {}
    } else {
      this.params = params
    }
    
    if (this.params['after_remove'] == undefined) {
      this.afterRemove = function(self){};
    } else {
      this.afterRemove = this.params['after_remove'];
    }

    if (this.params['after_create'] == undefined) {
      this.afterCreate = function(self){};
    } else {
      this.afterCreate = this.params['after_create'];
    }
  }

  generateID(){
   function s4() {
      return Math.floor((1 + Math.random()) * 0x10000)
        .toString(16)
        .substring(1);
    }
    let id = s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
    this.lastId = id
    return id
  }

}

