"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[556],{3905:(e,t,r)=>{r.d(t,{Zo:()=>u,kt:()=>f});var n=r(67294);function a(e,t,r){return t in e?Object.defineProperty(e,t,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[t]=r,e}function i(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,n)}return r}function l(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?i(Object(r),!0).forEach((function(t){a(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):i(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}function o(e,t){if(null==e)return{};var r,n,a=function(e,t){if(null==e)return{};var r,n,a={},i=Object.keys(e);for(n=0;n<i.length;n++)r=i[n],t.indexOf(r)>=0||(a[r]=e[r]);return a}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(n=0;n<i.length;n++)r=i[n],t.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(e,r)&&(a[r]=e[r])}return a}var d=n.createContext({}),p=function(e){var t=n.useContext(d),r=t;return e&&(r="function"==typeof e?e(t):l(l({},t),e)),r},u=function(e){var t=p(e.components);return n.createElement(d.Provider,{value:t},e.children)},c="mdxType",m={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},s=n.forwardRef((function(e,t){var r=e.components,a=e.mdxType,i=e.originalType,d=e.parentName,u=o(e,["components","mdxType","originalType","parentName"]),c=p(r),s=a,f=c["".concat(d,".").concat(s)]||c[s]||m[s]||i;return r?n.createElement(f,l(l({ref:t},u),{},{components:r})):n.createElement(f,l({ref:t},u))}));function f(e,t){var r=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var i=r.length,l=new Array(i);l[0]=s;var o={};for(var d in t)hasOwnProperty.call(t,d)&&(o[d]=t[d]);o.originalType=e,o[c]="string"==typeof e?e:a,l[1]=o;for(var p=2;p<i;p++)l[p]=r[p];return n.createElement.apply(null,l)}return n.createElement.apply(null,r)}s.displayName="MDXCreateElement"},26437:(e,t,r)=>{r.r(t),r.d(t,{contentTitle:()=>l,default:()=>c,frontMatter:()=>i,metadata:()=>o,toc:()=>d});var n=r(87462),a=(r(67294),r(3905));const i={},l=void 0,o={type:"mdx",permalink:"/Lagoon/CHANGELOG",source:"@site/pages/CHANGELOG.md",description:"1.1.0",frontMatter:{}},d=[{value:"1.1.0",id:"110",level:2},{value:"1.0.7",id:"107",level:2},{value:"1.0.6",id:"106",level:2},{value:"1.0.1 - 1.0.5",id:"101---105",level:2},{value:"1.0.0",id:"100",level:2}],p={toc:d},u="wrapper";function c(e){let{components:t,...r}=e;return(0,a.kt)(u,(0,n.Z)({},p,r,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h2",{id:"110"},"1.1.0"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Added server-side Networking middleware",(0,a.kt)("ul",{parentName:"li"},(0,a.kt)("li",{parentName:"ul"},"Added compatibility for requests that are serialized"))),(0,a.kt)("li",{parentName:"ul"},"Added static types for generics Array and Dictionary"),(0,a.kt)("li",{parentName:"ul"},"Separated type file and multiple different files for workspace cleanliness")),(0,a.kt)("h2",{id:"107"},"1.0.7"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Separated ",(0,a.kt)("inlineCode",{parentName:"li"},"Net:CreateRemote")," into ",(0,a.kt)("inlineCode",{parentName:"li"},"Net:CreateEvent")," and ",(0,a.kt)("inlineCode",{parentName:"li"},"Net:CreateFunction")),(0,a.kt)("li",{parentName:"ul"},"Added lazy loading for built-in traits to reduce bloating"),(0,a.kt)("li",{parentName:"ul"},"Added static typing for ",(0,a.kt)("inlineCode",{parentName:"li"},"Net")),(0,a.kt)("li",{parentName:"ul"},"Updated ",(0,a.kt)("inlineCode",{parentName:"li"},"net-trait")," example to use updated API")),(0,a.kt)("h2",{id:"106"},"1.0.6"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Fixed bug with ",(0,a.kt)("inlineCode",{parentName:"li"},"NetTrait:WaitFor")," that would yield for a remote and then not add the remote to the pool if it exists."),(0,a.kt)("li",{parentName:"ul"},"Fixed old debugging relating code for ",(0,a.kt)("inlineCode",{parentName:"li"},"NetTrait")," that was used in <1.0.0 versions.")),(0,a.kt)("h2",{id:"101---105"},"1.0.1 - 1.0.5"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Fixes to Remote related methods"),(0,a.kt)("li",{parentName:"ul"},"Updated ",(0,a.kt)("inlineCode",{parentName:"li"},"NetTrait")," description"),(0,a.kt)("li",{parentName:"ul"},"Updated documentation"),(0,a.kt)("li",{parentName:"ul"},"Added ",(0,a.kt)("inlineCode",{parentName:"li"},"net-trait")," example")),(0,a.kt)("h2",{id:"100"},"1.0.0"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Created docs page (",(0,a.kt)("a",{parentName:"li",href:"https://re-sync-dev.github.io/Lagoon/"},"https://re-sync-dev.github.io/Lagoon/"),")"),(0,a.kt)("li",{parentName:"ul"},"Added basic Lagoon usage examples"),(0,a.kt)("li",{parentName:"ul"},"Modified release action"),(0,a.kt)("li",{parentName:"ul"},"Added headers to the package files")))}c.isMDXComponent=!0}}]);