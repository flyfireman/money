function fix_image_size(images,maxW) {
    if(images.length>0){
        Event.observe(window,'load',function() {
            images.each(function(img){
                var w=img.width;
                var h=img.height;
                if(w>maxW){
                    var f=1-((w-maxW)/w);
                    img.title="点击查看原始大小图片";
                    img.addClassName("magplus");
                    img.onclick=function(){
                        window.open(this.src);
                    };
                    img.width=w*f;
                    img.height=h*f;
                }
            });
        });
    }
}