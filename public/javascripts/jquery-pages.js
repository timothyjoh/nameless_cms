$(document).ready(function() {
	//    $("div.OT").click(function() {
	//      alert("Hello world!");
	//    });
	// // $("#OT").addClass("yellowhighlight");
	// // $("div#NT").hide();
	// // $("div#OT").hide();
	// $("p#titlepage").hide();
	// $("p#titlepage").after("<p class='div4' id='navigation'>Open: </p>");
	// // $("p#navigation").addClass("yellowhighlight")
	// // $("p#navigation").css("color", "#000")
	// $("p#navigation").append("<a href='#OT'>Old Testament</a> ")
	// $("p#navigation").append("<a href='#Torah'>Torah</a> ")
	// $("p#navigation").append("<a href='#History'>History</a> ")
	// $("p#navigation").append("<a href='#Writings'>Writings</a> ")	
	// $("p#navigation").append("<a href='#Prophets'>Prophets</a> ")
	// $("p#navigation").append("<a href='#NT'>New Testament</a> ")
	// $("p#navigation").append("<a href='#Gospels'>Gospels</a> ")
	// $("p#navigation").append("<a href='#EpistlesOfPaul'>EpistlesOfPaul</a> ")
	// $("p#navigation").append("<a href='#EpistlesOfApostles'>EpistlesOfApostles</a> ")
	// $("p#navigation a").css("color", "#fff")
	// $("p#navigation a").click(function() {
	// 	var targ = this.href.split("#")[1];
	// 	$("div#"+targ).toggle();
	// 	return false;
	// });
	// $("p").css("text-indent", "0px")	
	
	$("a.gridtoggle").click(function() {
		$("div.container").toggleClass("showgrid");
		$("a.gridtoggle").toggleClass("active");
		return false;
	});
	$("a.meta_toggle").click(function() {
		$("div#metafields").toggle();
		return false;
	});
	$("a.extra_toggle").click(function() {
		$("div#extrafields").toggle();
		return false;
	});
	
	$("a#toggleSearchWords").click(function() {
		$("p.elementSearchKeywords").toggle();
		return false;
	});
	$("a#toggleElementPositions").click(function() {
		$("p.elementPosition").toggle();
		return false;
	});
	
	$("div#metafields").toggle();
	$("div#extrafields").toggle();

	
});
