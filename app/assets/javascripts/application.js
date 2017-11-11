// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .

$(function () {
	feed_id = 0;
	page = 0;
	
	var drowArticle = function (article) {
		return '<article>' +
			'<h1>' + article.title + '</h1>' +
			'<div>' + article.content + '</div>' +
			'<a href="' + article.url + '">' + article.url + '</a>' +
		'</article>';
	}
	
	var getArticles = function (feed_id) {
		$.post('feed/get', {id: feed_id, page: page}, function (articles) {
			articles.forEach(function (article) {
				$('#feed').append(drowArticle(article));
			});
		});
		
		page++;
	}
	
	$('#url-form').submit(function () {
		url = this['url']
		
		$.post('/feed/add', {url: url.value}, function (feed) {
			feed_id = feed.id;
			page = 0;
			$('#feed').html('');
			getArticles(feed_id);
		}).fail(function() {
			alert( "error" );
		});
		
		return false;
	});
	
	$('#more').click(function () {
		getArticles(feed_id);
		
		return false;
	});
});
