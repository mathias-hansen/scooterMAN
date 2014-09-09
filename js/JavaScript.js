window.onload = init;

var page = 0;

function init() {

    initPage();

};

function initPage() {
    document.getElementsByTagName('li')[page].setAttribute('id', 'selected');
    circleAnimate();

    document.querySelector('#wrapper').setAttribute('style', 'top:' + window.innerHeight + 'px');
    
    window.setTimeout(function () {
        document.querySelector('#wrapper').setAttribute('style', 'top:0px');
    },1);
}

function circleAnimate() {

    for (var i = 0; i < document.getElementsByTagName('li').length; i++) {
        document.getElementsByTagName('li')[i].getElementsByTagName('div')[0].removeAttribute('style');
        document.getElementsByTagName('li')[i].getElementsByTagName('a')[0].removeAttribute('style');
    };

    var circle = document.getElementById('selected').getElementsByTagName('div')[0];
    var text = document.getElementById('selected').getElementsByTagName('a')[0];

    circle.setAttribute('style', 'transform: scale(1)');
    text.setAttribute('style', 'background-color: rgba(255,255,255,0.1)');

    window.setTimeout(function () {
        circle.setAttribute('style', 'transform: scale(0); transition: 0');
    }, 500);

};


