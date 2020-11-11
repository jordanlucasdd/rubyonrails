function loadImagesProfile(){
  elements = document.getElementsByClassName("user-avatar");
  for (var i = 0; i < elements.length; i++) {
    img = elements[i]
    loadImageProfile(img.dataset.user,img)
  }
}

function loadImageProfile(userID,target){
  url = '/user/'+userID+'/profile';
  clientApi.get(url,{},function(data){
    if (data.avatar_url != null) {
      target.src = data.avatar_url
    }
  })
}

