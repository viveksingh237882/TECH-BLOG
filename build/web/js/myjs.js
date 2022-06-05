function doLike(pid,uid)
{
    
    console.log(pis+""+uid)
    const d={
        uid:uid,
        pid:pid,
        operation:'like'
        
    }
    $.ajax({
        
        url:"LikeServlet",
        data:d,
        success:function(data,textStatus,jqXHR){
            
            console.log(data);
            if(dat.trim()=='true'){
                
                let c=$(".like-counter").html();
                c++;
                $('.like-counter').html(c);
            }
        },
        error:function(jqXHR,textStatus,thrownError){
            
            console.log(data)
        }
    })
}
