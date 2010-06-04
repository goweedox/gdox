function GetScreenStepsLiveLessonsForTag(tag_name){
  jQuery.ajax({
    type: "GET",
    url: MakeSpaceTagsUrl(),
    dataType: 'json',
    data: {
      tag:tag_name,
      username: ScreenStepsLiveTagOptions.username,
      password: ScreenStepsLiveTagOptions.password
    }
  })
}

function SearchScreenStepsLiveSpace(string){
  jQuery.ajax({
    type: "GET",
    url: MakeSpaceSearchUrl(),
    dataType: 'json',
    data: {
      text:string,
      username: ScreenStepsLiveSearchOptions.username,
      password: ScreenStepsLiveSearchOptions.password
    }
  })
}

function MakeSpaceSearchUrl(){
  ScreenStepsLiveSearchOptions.use_ssl == true ? protocol = 'https://' : protocol = 'http://';
  url = protocol + ScreenStepsLiveSearchOptions.domain + "/spaces/" + ScreenStepsLiveSearchOptions.space + "/searches.json?callback=?";
  return url;
}

function MakeSpaceTagsUrl(){
  ScreenStepsLiveTagOptions.use_ssl == true ? protocol = 'https://' : protocol = 'http://';
  url = protocol + ScreenStepsLiveTagOptions.domain + "/spaces/" + ScreenStepsLiveTagOptions.space + "/tags.json?callback=?";
  return url;
}


function DisplayScreenStepsLiveSearchResults(data){
  if (data.errors == undefined) {
    jQuery('#' + ScreenStepsLiveSearchOptions.update_element).html(render_lesson_results(data.lessons));
  } else {
    jQuery.each(data.errors, function(error) { alert(error); })
  }
}

function DisplayScreenStepsLiveLessonsForTag(data){
  if (data.errors == undefined) {
    result ='<ul>';
	  jQuery.each(data.lessons, function(index, l) { result += '<li><a href="' + l.url + '" class="search-result" target="_blank">' + l.title + '</a></li>' });	
	  jQuery('#' + ScreenStepsLiveTagOptions.update_element).html(result);
	} else {
	  jQuery.each(data.errors, function(error) { alert(error); })
	}
}

render_lesson_results = function(lessons) {
	result = "";
	 if(lessons == null) {
	 	 result = "<h4>No results found!</h4>";
	 } else {
		 result = '<h4>' + lessons.length + " matching lessons found. Click on a lesson to view it</h4>";
			result +='<ul>';
			jQuery.each(lessons, function(index, l) { result += '<li><a href="' + l.url + '" class="search-result" target="_blank">' + l.title + '</a></li>' });		
	}
	return result;
}

