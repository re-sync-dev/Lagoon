"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[556],{3905:(e,t,a)=>{a.d(t,{Zo:()=>u,kt:()=>k});var n=a(67294);function i(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function r(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,n)}return a}function l(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?r(Object(a),!0).forEach((function(t){i(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):r(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function o(e,t){if(null==e)return{};var a,n,i=function(e,t){if(null==e)return{};var a,n,i={},r=Object.keys(e);for(n=0;n<r.length;n++)a=r[n],t.indexOf(a)>=0||(i[a]=e[a]);return i}(e,t);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);for(n=0;n<r.length;n++)a=r[n],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(i[a]=e[a])}return i}var d=n.createContext({}),p=function(e){var t=n.useContext(d),a=t;return e&&(a="function"==typeof e?e(t):l(l({},t),e)),a},u=function(e){var t=p(e.components);return n.createElement(d.Provider,{value:t},e.children)},m="mdxType",s={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},c=n.forwardRef((function(e,t){var a=e.components,i=e.mdxType,r=e.originalType,d=e.parentName,u=o(e,["components","mdxType","originalType","parentName"]),m=p(a),c=i,k=m["".concat(d,".").concat(c)]||m[c]||s[c]||r;return a?n.createElement(k,l(l({ref:t},u),{},{components:a})):n.createElement(k,l({ref:t},u))}));function k(e,t){var a=arguments,i=t&&t.mdxType;if("string"==typeof e||i){var r=a.length,l=new Array(r);l[0]=c;var o={};for(var d in t)hasOwnProperty.call(t,d)&&(o[d]=t[d]);o.originalType=e,o[m]="string"==typeof e?e:i,l[1]=o;for(var p=2;p<r;p++)l[p]=a[p];return n.createElement.apply(null,l)}return n.createElement.apply(null,a)}c.displayName="MDXCreateElement"},26437:(e,t,a)=>{a.r(t),a.d(t,{contentTitle:()=>l,default:()=>m,frontMatter:()=>r,metadata:()=>o,toc:()=>d});var n=a(87462),i=(a(67294),a(3905));const r={},l=void 0,o={type:"mdx",permalink:"/Lagoon/CHANGELOG",source:"@site/pages/CHANGELOG.md",description:"1.4.3",frontMatter:{}},d=[{value:"1.4.3",id:"143",level:2},{value:"1.4.2",id:"142",level:2},{value:"1.4.0",id:"140",level:2},{value:"1.3.0",id:"130",level:2},{value:"1.2.0",id:"120",level:2},{value:"1.1.0",id:"110",level:2},{value:"1.0.7",id:"107",level:2},{value:"1.0.6",id:"106",level:2},{value:"1.0.1 - 1.0.5",id:"101---105",level:2},{value:"1.0.0",id:"100",level:2}],p={toc:d},u="wrapper";function m(e){let{components:t,...a}=e;return(0,i.kt)(u,(0,n.Z)({},p,a,{components:t,mdxType:"MDXLayout"}),(0,i.kt)("h2",{id:"143"},"1.4.3"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"RemoteEvents and RemoteFunction can now be added to the pool even after runtime (old behavior required you to use ",(0,i.kt)("inlineCode",{parentName:"li"},":WaitFor")," in order to add the Event/Function to the pool)"),(0,i.kt)("li",{parentName:"ul"},"Switched to ",(0,i.kt)("a",{parentName:"li",href:"https://github.com/rojo-rbx/rokit"},"rokit")),(0,i.kt)("li",{parentName:"ul"},"Removed 'Net' compatibility redirect"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"Lagoon.Load")," now accepts an array of modules rather than just the parent script (type is Array of Instance because Roblox can be funky about certain type conversions)")),(0,i.kt)("h2",{id:"142"},"1.4.2"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Fixed issue with ",(0,i.kt)("inlineCode",{parentName:"li"},":Once")," that would disconnect the main handler connection when a request was received.")),(0,i.kt)("h2",{id:"140"},"1.4.0"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Removed Trait:Apply due to type clutter & general complexity concerns"),(0,i.kt)("li",{parentName:"ul"},(0,i.kt)("inlineCode",{parentName:"li"},"Service:ApplyTrait")," & ",(0,i.kt)("inlineCode",{parentName:"li"},"Controller:ApplyTrait")," no longer use Trait:Apply and have gone back to the original way traits were applied"),(0,i.kt)("li",{parentName:"ul"},"Net & NetTrait renamed to Network"),(0,i.kt)("li",{parentName:"ul"},"Split up the Network Serialization logic into a separate module."),(0,i.kt)("li",{parentName:"ul"},"Fixed issues with table serialization"),(0,i.kt)("li",{parentName:"ul"},"Updated NetworkType to reflect the changes made to the trait."),(0,i.kt)("li",{parentName:"ul"},"Added the ",(0,i.kt)("inlineCode",{parentName:"li"},":Once")," method to the Network trait (Disconnects after one request has been received)"),(0,i.kt)("li",{parentName:"ul"},"Added the ",(0,i.kt)("inlineCode",{parentName:"li"},":AddMiddleware")," method to the Network"),(0,i.kt)("li",{parentName:"ul"},"Modified the Network's pool structure to use ",(0,i.kt)("a",{parentName:"li",href:"/Lagoon/api/Network#NetworkPoolItem%3CT%3E"},"Pool Items")),(0,i.kt)("li",{parentName:"ul"},"Added ",(0,i.kt)("inlineCode",{parentName:"li"},"dev")," folder to .gitignore"),(0,i.kt)("li",{parentName:"ul"},"Added internal trait redirects for backwards compatibility for older traits (I.E. Net -> Network)"),(0,i.kt)("li",{parentName:"ul"},"Services & Controllers now have their names automatically applied at construction"),(0,i.kt)("li",{parentName:"ul"},"Logger now supports the automatic service and controller names (Setting the logging name using LogOptions still works.)"),(0,i.kt)("li",{parentName:"ul"},"Added warning for Key overlapping upon trait application"),(0,i.kt)("li",{parentName:"ul"},"Updated examples using the Network & Logger traits"),(0,i.kt)("li",{parentName:"ul"},"Added ",(0,i.kt)("a",{parentName:"li",href:"/Lagoon/docs/limitations"},"this page")," dedicated to the limitations of Lagoon"),(0,i.kt)("li",{parentName:"ul"},"Added additional info about minimally using Lagoon on the ",(0,i.kt)("a",{parentName:"li",href:"/Lagoon/docs/intro#do-i-need-to-wrap-everything-in-the-lagoon-api"},"intro page")),(0,i.kt)("li",{parentName:"ul"},"Temporarily removed Lagoon icon"),(0,i.kt)("li",{parentName:"ul"},"Updated aftman package versions")),(0,i.kt)("h2",{id:"130"},"1.3.0"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Added ",(0,i.kt)("a",{parentName:"li",href:"/Lagoon/api/Trait#Apply"},"Trait:Apply")," so non services/controllers can inherit traits as well"),(0,i.kt)("li",{parentName:"ul"},"Changed ",(0,i.kt)("inlineCode",{parentName:"li"},"Service:ApplyTrait")," & ",(0,i.kt)("inlineCode",{parentName:"li"},"Controller:ApplyTrait")," to use the newly added ",(0,i.kt)("inlineCode",{parentName:"li"},"Trait:Apply")," method"),(0,i.kt)("li",{parentName:"ul"},"Added static type for the ",(0,i.kt)("inlineCode",{parentName:"li"},"TraitBase")),(0,i.kt)("li",{parentName:"ul"},"Cleaned up the codebase a little bit (mostly making doc comments consistent)"),(0,i.kt)("li",{parentName:"ul"},"Renamed all files ending in .lua -> .luau"),(0,i.kt)("li",{parentName:"ul"},"Updated file headers to use .luau instead of .lua")),(0,i.kt)("h2",{id:"120"},"1.2.0"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Added ",(0,i.kt)("inlineCode",{parentName:"li"},"Logger")," trait"),(0,i.kt)("li",{parentName:"ul"},"Added static types for Logger Trait"),(0,i.kt)("li",{parentName:"ul"},"Added functions ",(0,i.kt)("a",{parentName:"li",href:"/Lagoon/api/Lagoon#Get"},"Lagoon.Get")," & ",(0,i.kt)("a",{parentName:"li",href:"/Lagoon/api/Lagoon#Load"},"Lagoon.Load")),(0,i.kt)("li",{parentName:"ul"},"Added file headers to files without them."),(0,i.kt)("li",{parentName:"ul"},"Added ",(0,i.kt)("inlineCode",{parentName:"li"},"logger-trait")," example"),(0,i.kt)("li",{parentName:"ul"},"Added ",(0,i.kt)("inlineCode",{parentName:"li"},"middleware")," example"),(0,i.kt)("li",{parentName:"ul"},"Fixed middleware being called on separate threads"),(0,i.kt)("li",{parentName:"ul"},"Middleware is now set everytime ",(0,i.kt)("inlineCode",{parentName:"li"},":CreateX")," is called"),(0,i.kt)("li",{parentName:"ul"},"Fixed middleware being boundary locked"),(0,i.kt)("li",{parentName:"ul"},"Small code cleanup in the ",(0,i.kt)("inlineCode",{parentName:"li"},"Net")," trait"),(0,i.kt)("li",{parentName:"ul"},"Removed old ",(0,i.kt)("inlineCode",{parentName:"li"},"Net")," property")),(0,i.kt)("h2",{id:"110"},"1.1.0"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Added server-side Networking middleware",(0,i.kt)("ul",{parentName:"li"},(0,i.kt)("li",{parentName:"ul"},"Added compatibility for requests that are serialized"))),(0,i.kt)("li",{parentName:"ul"},"Added static types for generics Array and Dictionary"),(0,i.kt)("li",{parentName:"ul"},"Separated type file and multiple different files for workspace cleanliness")),(0,i.kt)("h2",{id:"107"},"1.0.7"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Separated ",(0,i.kt)("inlineCode",{parentName:"li"},"Net:CreateRemote")," into ",(0,i.kt)("inlineCode",{parentName:"li"},"Net:CreateEvent")," and ",(0,i.kt)("inlineCode",{parentName:"li"},"Net:CreateFunction")),(0,i.kt)("li",{parentName:"ul"},"Added lazy loading for built-in traits to reduce bloating"),(0,i.kt)("li",{parentName:"ul"},"Added static typing for ",(0,i.kt)("inlineCode",{parentName:"li"},"Net")),(0,i.kt)("li",{parentName:"ul"},"Updated ",(0,i.kt)("inlineCode",{parentName:"li"},"net-trait")," example to use updated API")),(0,i.kt)("h2",{id:"106"},"1.0.6"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Fixed bug with ",(0,i.kt)("inlineCode",{parentName:"li"},"NetTrait:WaitFor")," that would yield for a remote and then not add the remote to the pool if it exists."),(0,i.kt)("li",{parentName:"ul"},"Fixed old debugging relating code for ",(0,i.kt)("inlineCode",{parentName:"li"},"NetTrait")," that was used in <1.0.0 versions.")),(0,i.kt)("h2",{id:"101---105"},"1.0.1 - 1.0.5"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Fixes to Remote related methods"),(0,i.kt)("li",{parentName:"ul"},"Updated ",(0,i.kt)("inlineCode",{parentName:"li"},"NetTrait")," description"),(0,i.kt)("li",{parentName:"ul"},"Updated documentation"),(0,i.kt)("li",{parentName:"ul"},"Added ",(0,i.kt)("inlineCode",{parentName:"li"},"net-trait")," example")),(0,i.kt)("h2",{id:"100"},"1.0.0"),(0,i.kt)("ul",null,(0,i.kt)("li",{parentName:"ul"},"Created docs page (",(0,i.kt)("a",{parentName:"li",href:"https://re-sync-dev.github.io/Lagoon/"},"https://re-sync-dev.github.io/Lagoon/"),")"),(0,i.kt)("li",{parentName:"ul"},"Added basic Lagoon usage examples"),(0,i.kt)("li",{parentName:"ul"},"Modified release action"),(0,i.kt)("li",{parentName:"ul"},"Added headers to the package files")))}m.isMDXComponent=!0}}]);