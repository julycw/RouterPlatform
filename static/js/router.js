var Hiwifi = (function(){
    return {
        init : function(){
            var iframe = document.createElement('iframe');
            iframe.id = 'iframeA';
            iframe.name = 'iframeA';
            iframe.style.display = 'none';
            document.body.appendChild(iframe);

            obj_ifr = document.getElementById("iframeA");

            document.body.removeChild(obj_ifr);
            document.body.appendChild(obj_ifr);

            hashH = document.documentElement.scrollHeight;

            urlC = "http://portal.kunteng.org/js/iframe.html";

            document.getElementById("iframeA").src = urlC + "#" + hashH;
        },
        show : function(){
            document.body.removeChild(obj_ifr);
            document.body.appendChild(obj_ifr);

            document.getElementById("iframeA").src = urlC + "#" + hashH + "#1";
        },
        hide : function(){
            document.body.removeChild(obj_ifr);
            document.body.appendChild(obj_ifr);

            document.getElementById("iframeA").src = urlC + "#" + hashH + "#0";
        }
    }
})()

// window.onload = Hiwifi.init;

