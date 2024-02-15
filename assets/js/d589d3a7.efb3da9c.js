"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[162],{3905:(e,t,r)=>{r.d(t,{Zo:()=>u,kt:()=>m});var n=r(67294);function a(e,t,r){return t in e?Object.defineProperty(e,t,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[t]=r,e}function o(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,n)}return r}function i(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?o(Object(r),!0).forEach((function(t){a(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):o(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}function l(e,t){if(null==e)return{};var r,n,a=function(e,t){if(null==e)return{};var r,n,a={},o=Object.keys(e);for(n=0;n<o.length;n++)r=o[n],t.indexOf(r)>=0||(a[r]=e[r]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(n=0;n<o.length;n++)r=o[n],t.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(e,r)&&(a[r]=e[r])}return a}var c=n.createContext({}),s=function(e){var t=n.useContext(c),r=t;return e&&(r="function"==typeof e?e(t):i(i({},t),e)),r},u=function(e){var t=s(e.components);return n.createElement(c.Provider,{value:t},e.children)},p="mdxType",d={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},g=n.forwardRef((function(e,t){var r=e.components,a=e.mdxType,o=e.originalType,c=e.parentName,u=l(e,["components","mdxType","originalType","parentName"]),p=s(r),g=a,m=p["".concat(c,".").concat(g)]||p[g]||d[g]||o;return r?n.createElement(m,i(i({ref:t},u),{},{components:r})):n.createElement(m,i({ref:t},u))}));function m(e,t){var r=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=r.length,i=new Array(o);i[0]=g;var l={};for(var c in t)hasOwnProperty.call(t,c)&&(l[c]=t[c]);l.originalType=e,l[p]="string"==typeof e?e:a,i[1]=l;for(var s=2;s<o;s++)i[s]=r[s];return n.createElement.apply(null,i)}return n.createElement.apply(null,r)}g.displayName="MDXCreateElement"},99390:(e,t,r)=>{r.r(t),r.d(t,{assets:()=>c,contentTitle:()=>i,default:()=>d,frontMatter:()=>o,metadata:()=>l,toc:()=>s});var n=r(87462),a=(r(67294),r(3905));const o={sidebar_position:2},i="Getting Started",l={unversionedId:"getting-started",id:"getting-started",title:"Getting Started",description:"Installation Guides",source:"@site/docs/getting-started.md",sourceDirName:".",slug:"/getting-started",permalink:"/Lagoon/docs/getting-started",draft:!1,editUrl:"https://github.com/re-sync-dev/Lagoon/edit/main/docs/getting-started.md",tags:[],version:"current",sidebarPosition:2,frontMatter:{sidebar_position:2},sidebar:"defaultSidebar",previous:{title:"About",permalink:"/Lagoon/docs/intro"},next:{title:"Installation",permalink:"/Lagoon/docs/installation/"}},c={},s=[{value:"Installation Guides",id:"installation-guides",level:2},{value:"Steps to Success",id:"steps-to-success",level:2},{value:"Creating your first Service",id:"creating-your-first-service",level:3},{value:"Creating a controller",id:"creating-a-controller",level:3},{value:"Adding traits to a service",id:"adding-traits-to-a-service",level:3}],u={toc:s},p="wrapper";function d(e){let{components:t,...r}=e;return(0,a.kt)(p,(0,n.Z)({},u,r,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"getting-started"},"Getting Started"),(0,a.kt)("h2",{id:"installation-guides"},"Installation Guides"),(0,a.kt)("ul",null,(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("a",{parentName:"li",href:"/docs/installation/studio"},"Studio")),(0,a.kt)("li",{parentName:"ul"},(0,a.kt)("a",{parentName:"li",href:"/docs/installation/wally"},"Wally"))),(0,a.kt)("h2",{id:"steps-to-success"},"Steps to Success"),(0,a.kt)("h3",{id:"creating-your-first-service"},"Creating your first Service"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-lua"},'local ReplicatedStorage = game:GetService("ReplicatedStorage")\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\n\nlocal MyService = {}\n\nfunction MyService.Print()\n    print("Hello from the server!")\nend\n\nreturn Lagoon.MakeService(MyService)\n')),(0,a.kt)("h3",{id:"creating-a-controller"},"Creating a controller"),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-lua"},'local ReplicatedStorage = game:GetService("ReplicatedStorage")\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\n\nlocal MyController = {}\n\nfunction MyController.Print()\n    print("Hello from the client!")\nend\n\nreturn Lagoon.MakeService(MyController)\n')),(0,a.kt)("h3",{id:"adding-traits-to-a-service"},"Adding traits to a service"),(0,a.kt)("p",null,(0,a.kt)("strong",{parentName:"p"},"MyCustomTrait.lua")),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-lua"},"-- This is in a ModuleScript\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\n\nlocal MyCustomTrait = {}\n\nfunction MyCustomTrait.Sum(a: number, b: number)\n    return a + b\nend\n\nreturn Lagoon.MakeTrait(MyCustomTrait)\n")),(0,a.kt)("p",null,(0,a.kt)("strong",{parentName:"p"},"MyService.lua")),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre",className:"language-lua"},"-- This is in a ModuleScript\nlocal Lagoon = require(ReplicatedStorage.Packages.Lagoon)\nlocal MyCustomTrait = require(Path.To.MyCustomTrait)\n\nlocal MyService = {}\nMyService.A = 1\nMyService.B = 2\n\nfunction MyService:Print()\n    print(`Sum: {self.Sum(self.A, self.B)}`)\nend\n\nreturn Lagoon.MakeController(MyService):ApplyTrait(MyCustomTrait)\n")))}d.isMDXComponent=!0}}]);