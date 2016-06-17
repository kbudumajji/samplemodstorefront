 <%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/desktop/template"%>
<%@ taglib prefix="checkout" tagdir="/WEB-INF/tags/desktop/checkout"%>
<%@ taglib prefix="cart" tagdir="/WEB-INF/tags/desktop/cart"%>
<%@ taglib prefix="multi-checkout"
	tagdir="/WEB-INF/tags/desktop/checkout/multi"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/desktop/common"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags"%>

<c:url value="${nextStepUrl}" var="continueSelectDeliveryMethodUrl" />
<c:url value="${previousStepUrl}" var="addDeliveryAddressUrl" />
<template:page pageTitle="${pageTitle}" hideHeaderLinks="true">

	<div id="globalMessages">
		<common:globalMessages />
	</div>
	<style>
	tr.spaceUnder > td
{
  padding-bottom: 2em;
}
	</style>
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script>
	function predictwthr()
	{
		//alert("predictwthr called");
		$
		.ajax(
				{
				//alert("from ajax");
					type : 'GET',
					url : 'https://localhost:9002/samplemodstorefront/electronics/en/checkout/multi/payment-method/wthr'
						// https://localhost:9002/samplemodstorefront/electronics/en/checkout/multi/delivery-method/choose
					//data : "methodSelected=" + methodSelected
				}).success(function(data) {

			//alert("sample output data from pb -->" + data);
			//document.write(data);
			getData(data);
		}).error(function(x, t, m) {
			if (t == "timeout") {
				alert("time-->" + t);
			} else {
				alert("elese part timer");
			}
		});
}

	function getData(data)
	{
	//	alert("getData");
		var speed=$('input[name=delivery_method]:checked', '#selectDeliveryMethodForm').val();
	   alert(speed);
	    var result='<html><table>';
	    
	    
	    
	 var str=data;
	// alert("str-->"+str);
		 //' {"city":{"id":2643743,"name":"London","coord":{"lon":-0.12574,"lat":51.50853},"country":"GB","population":0},"cod":"200","message":0.0358,"cnt":7,"list":[{"dt":1465819200,"temp":{"day":15.87,"min":13.73,"max":15.87,"night":13.73,"eve":15.87,"morn":15.87},"pressure":1007.62,"humidity":94,"weather":[{"id":501,"main":"Rain","description":"moderaterain","icon":"10d"}],"speed":3.41,"deg":283,"clouds":76,"rain":3.93},{"dt":1465905600,"temp":{"day":15.83,"min":12.74,"max":16.02,"night":12.74,"eve":14.71,"morn":14.24},"pressure":1002.72,"humidity":100,"weather":[{"id":500,"main":"Rain","description":"lightrain","icon":"10d"}],"speed":4.91,"deg":256,"clouds":76,"rain":1.19},{"dt":1465992000,"temp":{"day":16.8,"min":12.02,"max":16.8,"night":12.26,"eve":15.81,"morn":12.02},"pressure":1003.41,"humidity":99,"weather":[{"id":500,"main":"Rain","description":"lightrain","icon":"10d"}],"speed":3.45,"deg":214,"clouds":80,"rain":0.84},{"dt":1466078400,"temp":{"day":17.3,"min":12.14,"max":17.3,"night":13.43,"eve":16.53,"morn":12.14},"pressure":1008.19,"humidity":97,"weather":[{"id":500,"main":"Rain","description":"lightrain","icon":"10d"}],"speed":2.06,"deg":243,"clouds":56,"rain":1.95},{"dt":1466164800,"temp":{"day":15.78,"min":11.43,"max":15.78,"night":11.43,"eve":14.45,"morn":12.51},"pressure":1015.49,"humidity":0,"weather":[{"id":502,"main":"Rain","description":"heavy intensity rain","icon":"10d"}],"speed":2.9,"deg":349,"clouds":42,"rain":14.19},{"dt":1466251200,"temp":{"day":13.39,"min":9.44,"max":13.39,"night":9.44,"eve":12.87,"morn":10.66},"pressure":1029.1,"humidity":0,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"speed":6.19,"deg":10,"clouds":47,"rain":1.18},{"dt":1466337600,"temp":{"day":16.39,"min":8.49,"max":17.09,"night":8.49,"eve":17.09,"morn":8.94},"pressure":1034.63,"humidity":0,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"speed":3.46,"deg":12,"clouds":13,"rain":0.43}]}';   
	    
	    var obj=JSON.parse(str);
	    
	    var pressure;
	    var humidity;
	    var description;
	    var temp;
	    
	    for(var key in obj)
	        {
	           
	           if(key=='list')
	               {
	                   
	                   for(var i=0;i<obj[key].length;i++)
	                       {
	                           if(speed=='standard-gross')
	                               {
	                                   
	                             if(i>=2 && i<=4)                                              
	                           {
	                           var listobj=obj[key][i];
	                           
	                           for(var listkey  in listobj)
	                               {
	                                   //temperature day
	                                   if(listkey=='temp')
	                                       {
	                                           for(var tempkey in listobj[listkey])
	                                               {
	                                                   if(tempkey == 'day')
	                                                       {
	                                                           temp=listobj[listkey][tempkey];
	                                                       }
	                                               }
	                                       }
	                                       
	                                       // pressure
	                                       
	                                       if(listkey == 'pressure')
	                                           {
	                                               pressure=listobj[listkey];
	                                           }
	                                       //humidity
	                                       
	                                       if(listkey=='humidity')
	                                           {
	                                               humidity=listobj[listkey];
	                                           }
	                                       
	                                       //weather
	                                       
	                                   if(listkey=='weather')
	                                       {
	                                           
	                                           var weatherobj=listobj[listkey][0];
	                                           
	                                           for(var weatherkey in weatherobj)
	                                               {
	                                                   if(weatherkey == 'description')
	                                                       {
	                                                           description=weatherobj[weatherkey];
	                                                           
	                                                       }
	                                                   
	                                               }
	                                           
	                                       }
	                                       
	                    
	                                   
	                               }
	                               
	                                result=result+'<tr><td><H4>DAY</H4></td><td><H4>'+(i+1)+'</H4></td>';
	                           result=result+'<tr><td>DESCRIPTION  : </td><td>'+description+'</td></tr>';
	                           result=result+'<tr><td>pressure</td><td>'+pressure+'</td></tr>';
	                           result=result+'<tr><td>humidity</td><td>'+humidity+'</td></tr>';
	                           result=result+'<tr class="spaceUnder"><td>temp</td><td>'+temp+'</td></tr>';
	                         
	                               
	                               }
	                               
	                               }
	                               
	                               
	                               else
	                                   {
	                                       if(i>=0 && i<=1)
	                                           {
	                                               var listobj=obj[key][i];
	                           
	                           for(var listkey  in listobj)
	                               {
	                                   //temperature day
	                                   if(listkey=='temp')
	                                       {
	                                           for(var tempkey in listobj[listkey])
	                                               {
	                                                   if(tempkey == 'day')
	                                                       {
	                                                           temp=listobj[listkey][tempkey];
	                                                       }
	                                               }
	                                       }
	                                       
	                                       // pressure
	                                       
	                                       if(listkey == 'pressure')
	                                           {
	                                               pressure=listobj[listkey];
	                                           }
	                                       //humidity
	                                       
	                                       if(listkey=='humidity')
	                                           {
	                                               humidity=listobj[listkey];
	                                           }
	                                       
	                                       //weather
	                                       
	                                   if(listkey=='weather')
	                                       {
	                                           
	                                           var weatherobj=listobj[listkey][0];
	                                           
	                                           for(var weatherkey in weatherobj)
	                                               {
	                                                   if(weatherkey == 'description')
	                                                       {
	                                                           description=weatherobj[weatherkey];
	                                                           
	                                                       }
	                                                   
	                                               }
	                                           
	                                       }
	                                       
	                    
	                                   
	                               }
	                           result=result+'<tr><td><H4>DAY</H4></td><td><H4>'+(i+1)+'</H4></td>';
	                          // result=result+'<tr><td>day</td><td>'+(i+1)+'</td>';
	                           result=result+'<tr><td>DESCRIPTION  : </td><td>'+description+'</td></tr>';
	                           result=result+'<tr><td>pressure</td><td>'+pressure+'</td></tr>';
	                           result=result+'<tr><td>humidity</td><td>'+humidity+'</td></tr>';
	                           result=result+'<tr class="spaceUnder"><td>temp</td><td>'+temp+'</td></tr>';
	                                               
	                                           }
	                                       
	                                       
	                                   }
	                               
	                              // alert("element-->"+i+"-temp---"+temp+"----pressure---"+pressure+"---humidity----"+humidity+"-----description---"+description);
	                        
	                          // result=result+'<tr><td>day></td><td>'+i+'</td>';
	                       }
	                   
	               }
	           
	           
	        }
	        alert("result-->"+result);
	        result=result+'</table>';
	        
	    //document.getElementById("result").innerHTML=result;
	    document.getElementById('result').innerHTML = result;
	    
	}
	
	</script>

	
	<multi-checkout:checkoutProgressBar steps="${checkoutSteps}"
		progressBarId="${progressBarId}" />
	<div class="span-14 append-1">
		<div id="checkoutContentPanel" class="clearfix">
			<div class="headline">
				<spring:theme code="checkout.multi.deliveryMethod.stepHeader" />
			</div>
			<div class="description">
				<p>
					<spring:theme
						code="checkout.multi.deliveryMethod.selectDeliveryMethodMessage" />
				</p>
			</div>
			<form:form id="selectDeliveryMethodForm"
				action="${request.contextPath}/checkout/multi/delivery-method/select"
				method="get">
				<multi-checkout:deliveryMethodSelector
					deliveryMethods="${deliveryMethods}"
					selectedDeliveryMethodId="${cartData.deliveryMode.code}" />

				<c:if test="${not empty cartData.deliveryMode.code}">
					<div class="form-actions">
						<a class="button" href="${addDeliveryAddressUrl}"><spring:theme
								code="checkout.multi.cancel" text="Cancel" /></a>




						<button id="chooseDeliveryMethod_continue_button"
							class="positive right show_processing_message">
							<spring:theme code="checkout.multi.deliveryMethod.continue"
								text="Continue" />
						</button>
					</div>
				</c:if>


			</form:form>

			<button class="positive left" onclick="predictwthr()">predictweather
			</button>
				
							<div id="result" style="margin-top:70px;"></div>
			
		</div>

	</div>
	<multi-checkout:checkoutOrderDetails cartData="${cartData}"
		showShipDeliveryEntries="true" showPickupDeliveryEntries="false"
		showTax="false" />
	<cms:pageSlot position="SideContent" var="feature" element="div"
		class="span-24 side-content-slot cms_disp-img_slot">
		<cms:component component="${feature}" />
	</cms:pageSlot>

</template:page>

