"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[556],{3905:(e,t,r)=>{r.d(t,{Zo:()=>u,kt:()=>f});var n=r(67294);function a(e,t,r){return t in e?Object.defineProperty(e,t,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[t]=r,e}function o(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,n)}return r}function i(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?o(Object(r),!0).forEach((function(t){a(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):o(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}function l(e,t){if(null==e)return{};var r,n,a=function(e,t){if(null==e)return{};var r,n,a={},o=Object.keys(e);for(n=0;n<o.length;n++)r=o[n],t.indexOf(r)>=0||(a[r]=e[r]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(n=0;n<o.length;n++)r=o[n],t.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(e,r)&&(a[r]=e[r])}return a}var p=n.createContext({}),c=function(e){var t=n.useContext(p),r=t;return e&&(r="function"==typeof e?e(t):i(i({},t),e)),r},u=function(e){var t=c(e.components);return n.createElement(p.Provider,{value:t},e.children)},d="mdxType",s={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},m=n.forwardRef((function(e,t){var r=e.components,a=e.mdxType,o=e.originalType,p=e.parentName,u=l(e,["components","mdxType","originalType","parentName"]),d=c(r),m=a,f=d["".concat(p,".").concat(m)]||d[m]||s[m]||o;return r?n.createElement(f,i(i({ref:t},u),{},{components:r})):n.createElement(f,i({ref:t},u))}));function f(e,t){var r=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=r.length,i=new Array(o);i[0]=m;var l={};for(var p in t)hasOwnProperty.call(t,p)&&(l[p]=t[p]);l.originalType=e,l[d]="string"==typeof e?e:a,i[1]=l;for(var c=2;c<o;c++)i[c]=r[c];return n.createElement.apply(null,i)}return n.createElement.apply(null,r)}m.displayName="MDXCreateElement"},26437:(e,t,r)=>{r.r(t),r.d(t,{contentTitle:()=>i,default:()=>d,frontMatter:()=>o,metadata:()=>l,toc:()=>p});var n=r(87462),a=(r(67294),r(3905));const o={},i=void 0,l={type:"mdx",permalink:"/Lagoon/CHANGELOG",source:"@site/pages/CHANGELOG.md",description:"1.0.6",frontMatter:{}},p=[{value:"1.0.6",id:"106",level:2},{value:"1.0.1 - 1.0.5",id:"101---105",level:2},{value:"1.0.0",id:"100",level:2}],c={toc:p},u="wrapper";function d(e){let{components:t,...r}=e;return(0,a.kt)(u,(0,n.Z)({},c,r,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h2",{id:"106"},"1.0.6"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Fixed bug with ",(0,a.kt)("inlineCode",{parentName:"li"},"NetTrait:WaitFor")," that would yield for a remote and then not add the remote to the pool if it exists."),(0,a.kt)("li",{parentName:"ul"},"Fixed old debugging relating code for ",(0,a.kt)("inlineCode",{parentName:"li"},"NetTrait")," that was used in <1.0.0 versions.")),(0,a.kt)("h2",{id:"101---105"},"1.0.1 - 1.0.5"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Fixes to Remote related methods"),(0,a.kt)("li",{parentName:"ul"},"Updated ",(0,a.kt)("inlineCode",{parentName:"li"},"NetTrait")," description"),(0,a.kt)("li",{parentName:"ul"},"Updated documentation"),(0,a.kt)("li",{parentName:"ul"},"Added ",(0,a.kt)("inlineCode",{parentName:"li"},"net-trait")," example")),(0,a.kt)("h2",{id:"100"},"1.0.0"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},"Created docs page (",(0,a.kt)("a",{parentName:"li",href:"https://re-sync-dev.github.io/Lagoon/"},"https://re-sync-dev.github.io/Lagoon/"),")"),(0,a.kt)("li",{parentName:"ul"},"Added basic Lagoon usage examples"),(0,a.kt)("li",{parentName:"ul"},"Modified release action"),(0,a.kt)("li",{parentName:"ul"},"Added headers to the package files")))}d.isMDXComponent=!0}}]);