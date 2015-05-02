//shortens text to to a specified character count but without splitting words in the middle. text is string and wordcount is an int.
function shortenText(text, characterCount){
    if (text.length <= characterCount){
    	return text;
    }
    else{
	    var text_array = text.split(" ");
	    var shortened_text='';
	    for (var i=0; i<text_array.length; i++){
	        if (shortened_text.length < characterCount && (shortened_text+text_array[i]).length <= characterCount){
	            shortened_text=shortened_text+text_array[i]+" ";
	        }
	    }
	    return shortened_text+"...";
	}
}

module.exports = shortenText;