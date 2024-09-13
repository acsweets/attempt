// var canvas = document.getElementById('canvas')
// var ctx = canvas.getContext('2d')
// var t = 0 //贝塞尔函数涉及的占比比例，0<=t<=1
// var clickNodes = [] //点击的控制点对象数组
// var bezierNodes = [] //绘制内部控制点的数组
// var isPrinted = false //当前存在绘制的曲线
// var isPrinting = false //正在绘制中
// var num = 0 //控制点数
// var isDrag = false //是否进入拖拽行为
// var isDragNode = false //是否点击到了控制点
// var dragIndex = 0 //被拖拽的点的索引
// var clickon = 0 //鼠标按下时间戳
// var clickoff = 0 //鼠标抬起
// $(canvas).mousedown(function(e){
//     isDrag = true
//     clickon = new Date().getTime()
//     var diffLeft = $(this).offset().left,
//         diffTop = $(this).offset().top,
//         clientX = e.clientX,
//         clientY = e.clientY,
//         x = clientX - diffLeft,
//         y = clientY - diffTop
//     clickNodes.forEach(function(item, index) {
//         var absX = Math.abs(item.x - x),
//             absY = Math.abs(item.y - y)
//         if(absX < 5 && absY < 5) {
//             isDragNode = true
//             dragIndex = index
//         }
//     })
// }).mousemove(function(e) {
//     if(isDrag && isDragNode) {
//         var diffLeft = $(this).offset().left,
//         diffTop = $(this).offset().top,
//         clientX = e.clientX,
//         clientY = e.clientY,
//         x = clientX - diffLeft,
//         y = clientY - diffTop
//         clickNodes[dragIndex] = {
//             x: x,
//             y: y
//         }
//         ctx.clearRect(0, 0, canvas.width, canvas.height)
//         clickNodes.forEach(function(item, index) {
//             var x = item.x,
//                 y = item.y,
//                 i = parseInt(index, 10) + 1
//             ctx.fillText("p" + i, x, y + 20)
//             ctx.fillText("p" + i + ': ('+ x +', '+ y +')', 10, i * 20)
//             ctx.beginPath()
//             ctx.arc(x, y, 4, 0, Math.PI * 2, false)
//             ctx.fill()
//             ctx.beginPath()
//             ctx.moveTo(startX, startY)
//             ctx.lineTo(x, y)
//             ctx.strokeStyle = '#696969'
//             ctx.stroke()
//             if (index) {
//                 var startX = clickNodes[index - 1].x,
//                     startY = clickNodes[index - 1].y
//                 ctx.beginPath()
//                 ctx.moveTo(startX, startY)
//                 ctx.lineTo(x, y)
//                 ctx.stroke()
//             }
//         })
//         if(isPrinted) {
//             var bezierArr = []
//             for(i = 0; i < 1; i+=0.01) {
//                 bezierArr.push(bezier(clickNodes, i))
//             }
//             bezierArr.forEach(function(obj, index) {
//                 if (index) {
//                     var startX = bezierArr[index - 1].x,
//                         startY = bezierArr[index - 1].y,
//                         x = obj.x,
//                         y = obj.y
//                     ctx.beginPath()
//                     ctx.moveTo(startX, startY)
//                     ctx.lineTo(x, y)
//                     ctx.strokeStyle = 'red'
//                     ctx.stroke()
//                 }
//             })
//         }
//     }
// }).mouseup(function(e) {
//     isDrag = false
//     isDragNode = false
//     clickoff = new Date().getTime()
//     if(clickoff - clickon < 200) {
//         var diffLeft = $(this).offset().left,
//         diffTop = $(this).offset().top,
//         clientX = e.clientX,
//         clientY = e.clientY
//         x = clientX - diffLeft,
//         y = clientY - diffTop
//         if(!isPrinted && !isDragNode) {
//             num++
//             var ctx = canvas.getContext('2d')
//             ctx.font = "16px Microsoft YaHei";
//             ctx.fillStyle = '#696969'
//             ctx.fillText("p" + num, x, y + 20);
//             ctx.fillText("p" + num + ': ('+ x +', '+ y +')', 10, num * 20)
//             ctx.beginPath()
//             ctx.arc(x, y, 4, 0, Math.PI * 2, false)
//             ctx.fill()
//             if(clickNodes.length) {
//                 var startX = clickNodes[clickNodes.length - 1].x,
//                     startY = clickNodes[clickNodes.length - 1].y
//                 ctx.beginPath()
//                 ctx.moveTo(startX, startY)
//                 ctx.lineTo(x, y)
//                 ctx.strokeStyle = '#696969'
//                 ctx.stroke()
//             }
//             clickNodes.push({
//                 x: x,
//                 y: y
//             })
//         }
//     }
// })
// $('#print').click(function() {
//     if(!num) return
//     if(!isPrinting) {
//         isPrinted = true
//         drawBezier(ctx, clickNodes)
//     }
// })
// $('#clear').click(function() {
//     if(!isPrinting) {
//         isPrinted = false
//         ctx.clearRect(0, 0, canvas.width, canvas.height)
//         clickNodes = []
//         bezierNodes = []
//         t = 0
//         num = 0
//     }
// })
//
// function drawBezier(ctx, origin_nodes) {
//     if(t > 1) {
//         isPrinting = false
//         return
//     }
//     isPrinting = true
//     var nodes = origin_nodes
//     t += 0.01
//     ctx.clearRect(0, 0, canvas.width, canvas.height)
//     drawnode(nodes)
//     window.requestAnimationFrame(drawBezier.bind(this, ctx, nodes))
// }
// function drawnode(nodes) {
//     if(!nodes.length) return
//     var _nodes = nodes
//     var next_nodes = []
//     _nodes.forEach(function(item, index) {
//         var x = item.x,
//             y = item.y
//         if(_nodes.length === num) {
//             ctx.font = "16px Microsoft YaHei"
//             var i = parseInt(index, 10) + 1
//             ctx.fillText("p" + i, x, y + 20)
//             ctx.fillText("p" + i + ': ('+ x +', '+ y +')', 10, i * 20)
//         }
//         ctx.beginPath()
//         ctx.arc(x, y, 4, 0, Math.PI * 2, false)
//         ctx.fill()
//         if(_nodes.length === 1) {
//             bezierNodes.push(item)
//             if(bezierNodes.length > 1) {
//                 bezierNodes.forEach(function (obj, i) {
//                     if (i) {
//                         var startX = bezierNodes[i - 1].x,
//                             startY = bezierNodes[i - 1].y,
//                             x = obj.x,
//                             y = obj.y
//                         ctx.beginPath()
//                         ctx.moveTo(startX, startY)
//                         ctx.lineTo(x, y)
//                         ctx.strokeStyle = 'red'
//                         ctx.stroke()
//                     }
//                 })
//             }
//         }
//         if(index) {
//             var startX = _nodes[index - 1].x,
//                 startY = _nodes[index - 1].y
//             ctx.beginPath()
//             ctx.moveTo(startX, startY)
//             ctx.lineTo(x, y)
//             ctx.strokeStyle = '#696969'
//             ctx.stroke()
//         }
//     })
//     if(_nodes.length) {
//         for(var i = 0; i < _nodes.length - 1; i++) {
//             var arr = [{
//                 x: _nodes[i].x,
//                 y: _nodes[i].y
//             }, {
//                 x: _nodes[i + 1].x,
//                 y: _nodes[i + 1].y
//             }]
//             next_nodes.push(bezier(arr, t))
//         }
//         drawnode(next_nodes)
//     }
//
// }
// function factorial(num) { //递归阶乘
//     if (num <= 1) {
//         return 1;
//     } else {
//         return num * factorial(num - 1);
//     }
// }
//
// function bezier(arr, t) { //通过各控制点与占比t计算当前贝塞尔曲线上的点坐标
//     var x = 0,
//         y = 0,
//         n = arr.length - 1
//     arr.forEach(function(item, index) {
//         if(!index) {
//             x += item.x * Math.pow(( 1 - t ), n - index) * Math.pow(t, index)
//             y += item.y * Math.pow(( 1 - t ), n - index) * Math.pow(t, index)
//         } else {
//             x += factorial(n) / factorial(index) / factorial(n - index) * item.x * Math.pow(( 1 - t ), n - index) * Math.pow(t, index)
//             y += factorial(n) / factorial(index) / factorial(n - index) * item.y * Math.pow(( 1 - t ), n - index) * Math.pow(t, index)
//         }
//     })
//     return {
//         x: x,
//         y: y
//     }
// }
// var getRandomColor = function(){
//       return '#'+Math.floor(Math.random()*16777215).toString(16);
// }




///简单版
//(function(){
// 	var clickPoint=null,sourcePoint,isQuadratic = false,
// 	canvas=document.getElementById("canvas"),
// 	code=document.getElementById("code"),
// 	ctx=canvas.getContext("2d"),
// 	point={p1:{x:150,y:250},p2:{x:450,y:250},cp1:{x:300,y:100}},
// 	cp2={x:400,y:100},
// 	round={
// 		curve:{width:2,color:"#1572b5"},
// 		cpline:{width:0.5,color:"#cf4520"},
// 		point:{
// 			radius:10,
// 			width:1,
// 			color:"#009696",
// 			fill:"rgba(0,170,187,0.6)"
// 		}
// 	};
//
// 	init();
//
// 	function init(){
// 		point={p1:{x:point.p1.x,y:point.p1.y},p2:{x:point.p2.x,y:point.p2.y},cp1:{x:point.cp1.x,y:point.cp1.y}};
// 		if(isQuadratic){
// 			point.cp2=cp2;
// 		}
// 		ctx.lineCap="round";
// 		ctx.lineJoin="round";
// 		canvas.onmousedown=mouseDownFun;
// 		canvas.onmousemove=mouseMoveFun;
// 		canvas.onmouseup=canvas.onmouseout=mouseUpFun;
// 		drawCanvas()
// 	}
// 	//绘制
// 	function drawCanvas(){
// 		ctx.clearRect(0,0,canvas.width,canvas.height);
// 		drawUploadImg()
// 		ctx.beginPath();
// 		ctx.lineWidth=round.cpline.width;
// 		ctx.strokeStyle=round.cpline.color;
// 		ctx.beginPath();
// 		ctx.moveTo(point.p1.x,point.p1.y);
// 		ctx.lineTo(point.cp1.x,point.cp1.y);
// 		if(isQuadratic){
// 			ctx.moveTo(point.p2.x,point.p2.y);
// 			ctx.lineTo(point.cp2.x,point.cp2.y)
// 		}else{
// 			ctx.lineTo(point.p2.x,point.p2.y)
// 		}
// 		ctx.stroke();
// 		ctx.lineWidth=round.curve.width;
// 		ctx.strokeStyle=round.curve.color;
// 		ctx.beginPath();
// 		ctx.moveTo(point.p1.x,point.p1.y);
// 		if(isQuadratic){
// 			ctx.bezierCurveTo(point.cp1.x,point.cp1.y,point.cp2.x,point.cp2.y,point.p2.x,point.p2.y)
// 		}else{
// 			ctx.quadraticCurveTo(point.cp1.x,point.cp1.y,point.p2.x,point.p2.y)
// 		}
// 		ctx.stroke();
// 		for(var v in point){
// 			ctx.lineWidth=round.point.width;
// 			ctx.strokeStyle=round.point.color;
// 			ctx.fillStyle=round.point.fill;
// 			ctx.beginPath();
// 			ctx.arc(point[v].x,point[v].y,round.point.radius,0,2*Math.PI,true);
// 			ctx.fill();
// 			ctx.stroke()
// 		}
// 		appendText()
// 	}
// 	//插入对应文字到提示框
// 	function appendText(){
// 		var codeHTML="";
// 		if(point.cp2){
// 			codeHTML="ctx.bezierCurveTo("+point.cp1.x+", "+point.cp1.y+", "+point.cp2.x+", "+point.cp2.y+", "+point.p2.x+", "+point.p2.y+");\n"
// 		}else{
// 			codeHTML="ctx.quadraticCurveTo("+point.cp1.x+", "+point.cp1.y+", "+point.p2.x+", "+point.p2.y+");\n"
// 		}
// 		code.innerHTML='canvas = document.getElementById("canvas");\n';
// 		code.innerHTML+='ctx = canvas.getContext("2d")\n';
// 		code.innerHTML+='ctx.strokeStyle = "'+round.curve.color+'";\n';
// 		code.innerHTML+='ctx.lineWidth = '+round.curve.width+';\n';
// 		code.innerHTML+='ctx.beginPath();\n';
// 		code.innerHTML+='ctx.moveTo('+point.p1.x+", "+point.p1.y+");\n";
// 		code.innerHTML+=codeHTML;
// 		code.innerHTML+="ctx.stroke();\n";
// 		code.innerHTML+="ctx.closePath();\n";
// 	}
// 	function mouseDownFun(e){
// 		e=getPoint(e);
// 		var dx,dy;
// 		for(var v in point){
// 			dx=point[v].x-e.x;
// 			dy=point[v].y-e.y;
// 			//判断点击区域是否在可见圆内
// 			if(Math.pow(dx,2)+Math.pow(dy,2)<Math.pow(round.point.radius,2)){
// 				clickPoint=v;
// 				sourcePoint=e;
// 				canvas.style.cursor="move";
// 				return
// 			}
// 		}
// 	}
// 	function mouseMoveFun(e){
// 		if(clickPoint){
// 			e=getPoint(e);
// 			point[clickPoint].x+=e.x-sourcePoint.x;
// 			point[clickPoint].y+=e.y-sourcePoint.y;
// 			sourcePoint=e;
// 			drawCanvas()
// 		}
// 	}
// 	function mouseUpFun(e){
// 		clickPoint=null;
// 		canvas.style.cursor="default";
// 		drawCanvas()
// 	}
// 	function getPoint(e){
// 		e=(e?e:window.event);
// 		return{x:e.pageX-canvas.offsetLeft,y:e.pageY-canvas.offsetTop}
// 	}
// 	function drawUploadImg(){
// 		var img=document.getElementById("imghead");
// 		if(img.src!=''){
// 			ctx.drawImage(img, 0, 0)
// 		}
// 	}
//
// 	document.getElementById("bezierCurveTo").onclick=function(){
// 		if(isQuadratic){
// 			isQuadratic = false
// 			this.innerHTML="bezierCurveTo";
// 			oldCP2=point.cp2;
// 			init()
// 		}else{
// 			isQuadratic = true
// 			this.innerHTML="quadraticCurveTo";
// 			init()
// 		}
// 	}
// 	document.getElementById('file').onchange=function(){
// 		previewImage(this)
// 		drawCanvas()
// 	}
// 	document.getElementById('exchange').onclick=function(){
// 		eval("point.p1.x="+point.p2.x+",point.p1.y="+point.p2.y+",point.p2.x="+point.p1.x+",point.p2.y="+point.p1.y)
// 		drawCanvas()
// 	}
// 	document.getElementById('strokeStyle').onchange=function(){
// 		round.curve.color=this.value
// 		drawCanvas()
// 	}
// 	document.getElementById('lineWidth').onchange=function(){
// 		round.curve.width=this.value
// 		drawCanvas()
// 	}
// })();