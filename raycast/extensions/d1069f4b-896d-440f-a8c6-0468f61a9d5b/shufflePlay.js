var mn=Object.create;var B=Object.defineProperty;var hn=Object.getOwnPropertyDescriptor;var Sn=Object.getOwnPropertyNames;var gn=Object.getPrototypeOf,yn=Object.prototype.hasOwnProperty;var be=e=>B(e,"__esModule",{value:!0});var c=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports),xn=(e,t)=>{for(var r in t)B(e,r,{get:t[r],enumerable:!0})},we=(e,t,r,n)=>{if(t&&typeof t=="object"||typeof t=="function")for(let s of Sn(t))!yn.call(e,s)&&(r||s!=="default")&&B(e,s,{get:()=>t[s],enumerable:!(n=hn(t,s))||n.enumerable});return e},ve=(e,t)=>we(be(B(e!=null?mn(gn(e)):{},"default",!t&&e&&e.__esModule?{get:()=>e.default,enumerable:!0}:{value:e,enumerable:!0})),e),bn=(e=>(t,r)=>e&&e.get(t)||(r=we(be({}),t,1),e&&e.set(t,r),r))(typeof WeakMap!="undefined"?new WeakMap:0);var Ce=c((gs,Pe)=>{Pe.exports=Te;Te.sync=vn;var Ee=require("fs");function wn(e,t){var r=t.pathExt!==void 0?t.pathExt:process.env.PATHEXT;if(!r||(r=r.split(";"),r.indexOf("")!==-1))return!0;for(var n=0;n<r.length;n++){var s=r[n].toLowerCase();if(s&&e.substr(-s.length).toLowerCase()===s)return!0}return!1}function Ie(e,t,r){return!e.isSymbolicLink()&&!e.isFile()?!1:wn(t,r)}function Te(e,t,r){Ee.stat(e,function(n,s){r(n,n?!1:Ie(s,e,t))})}function vn(e,t){return Ie(Ee.statSync(e),e,t)}});var qe=c((ys,Oe)=>{Oe.exports=Ae;Ae.sync=En;var Ge=require("fs");function Ae(e,t,r){Ge.stat(e,function(n,s){r(n,n?!1:Re(s,t))})}function En(e,t){return Re(Ge.statSync(e),t)}function Re(e,t){return e.isFile()&&In(e,t)}function In(e,t){var r=e.mode,n=e.uid,s=e.gid,o=t.uid!==void 0?t.uid:process.getuid&&process.getuid(),i=t.gid!==void 0?t.gid:process.getgid&&process.getgid(),a=parseInt("100",8),l=parseInt("010",8),d=parseInt("001",8),f=a|l,h=r&d||r&l&&s===i||r&a&&n===o||r&f&&o===0;return h}});var Ne=c((bs,_e)=>{var xs=require("fs"),L;process.platform==="win32"||global.TESTING_WINDOWS?L=Ce():L=qe();_e.exports=Y;Y.sync=Tn;function Y(e,t,r){if(typeof t=="function"&&(r=t,t={}),!r){if(typeof Promise!="function")throw new TypeError("callback not provided");return new Promise(function(n,s){Y(e,t||{},function(o,i){o?s(o):n(i)})})}L(e,t||{},function(n,s){n&&(n.code==="EACCES"||t&&t.ignoreErrors)&&(n=null,s=!1),r(n,s)})}function Tn(e,t){try{return L.sync(e,t||{})}catch(r){if(t&&t.ignoreErrors||r.code==="EACCES")return!1;throw r}}});var Fe=c((ws,je)=>{var v=process.platform==="win32"||process.env.OSTYPE==="cygwin"||process.env.OSTYPE==="msys",$e=require("path"),Pn=v?";":":",ke=Ne(),Be=e=>Object.assign(new Error(`not found: ${e}`),{code:"ENOENT"}),Le=(e,t)=>{let r=t.colon||Pn,n=e.match(/\//)||v&&e.match(/\\/)?[""]:[...v?[process.cwd()]:[],...(t.path||process.env.PATH||"").split(r)],s=v?t.pathExt||process.env.PATHEXT||".EXE;.CMD;.BAT;.COM":"",o=v?s.split(r):[""];return v&&e.indexOf(".")!==-1&&o[0]!==""&&o.unshift(""),{pathEnv:n,pathExt:o,pathExtExe:s}},Me=(e,t,r)=>{typeof t=="function"&&(r=t,t={}),t||(t={});let{pathEnv:n,pathExt:s,pathExtExe:o}=Le(e,t),i=[],a=d=>new Promise((f,h)=>{if(d===n.length)return t.all&&i.length?f(i):h(Be(e));let m=n[d],S=/^".*"$/.test(m)?m.slice(1,-1):m,g=$e.join(S,e),y=!S&&/^\.[\\\/]/.test(e)?e.slice(0,2)+g:g;f(l(y,d,0))}),l=(d,f,h)=>new Promise((m,S)=>{if(h===s.length)return m(a(f+1));let g=s[h];ke(d+g,{pathExt:o},(y,w)=>{if(!y&&w)if(t.all)i.push(d+g);else return m(d+g);return m(l(d,f,h+1))})});return r?a(0).then(d=>r(null,d),r):a(0)},Cn=(e,t)=>{t=t||{};let{pathEnv:r,pathExt:n,pathExtExe:s}=Le(e,t),o=[];for(let i=0;i<r.length;i++){let a=r[i],l=/^".*"$/.test(a)?a.slice(1,-1):a,d=$e.join(l,e),f=!l&&/^\.[\\\/]/.test(e)?e.slice(0,2)+d:d;for(let h=0;h<n.length;h++){let m=f+n[h];try{if(ke.sync(m,{pathExt:s}))if(t.all)o.push(m);else return m}catch{}}}if(t.all&&o.length)return o;if(t.nothrow)return null;throw Be(e)};je.exports=Me;Me.sync=Cn});var Z=c((vs,Q)=>{"use strict";var Ue=(e={})=>{let t=e.env||process.env;return(e.platform||process.platform)!=="win32"?"PATH":Object.keys(t).reverse().find(n=>n.toUpperCase()==="PATH")||"Path"};Q.exports=Ue;Q.exports.default=Ue});var Ke=c((Es,He)=>{"use strict";var De=require("path"),Gn=Fe(),An=Z();function Xe(e,t){let r=e.options.env||process.env,n=process.cwd(),s=e.options.cwd!=null,o=s&&process.chdir!==void 0&&!process.chdir.disabled;if(o)try{process.chdir(e.options.cwd)}catch{}let i;try{i=Gn.sync(e.command,{path:r[An({env:r})],pathExt:t?De.delimiter:void 0})}catch{}finally{o&&process.chdir(n)}return i&&(i=De.resolve(s?e.options.cwd:"",i)),i}function Rn(e){return Xe(e)||Xe(e,!0)}He.exports=Rn});var We=c((Is,ee)=>{"use strict";var J=/([()\][%!^"`<>&|;, *?])/g;function On(e){return e=e.replace(J,"^$1"),e}function qn(e,t){return e=`${e}`,e=e.replace(/(\\*)"/g,'$1$1\\"'),e=e.replace(/(\\*)$/,"$1$1"),e=`"${e}"`,e=e.replace(J,"^$1"),t&&(e=e.replace(J,"^$1")),e}ee.exports.command=On;ee.exports.argument=qn});var ze=c((Ts,Ve)=>{"use strict";Ve.exports=/^#!(.*)/});var Qe=c((Ps,Ye)=>{"use strict";var _n=ze();Ye.exports=(e="")=>{let t=e.match(_n);if(!t)return null;let[r,n]=t[0].replace(/#! ?/,"").split(" "),s=r.split("/").pop();return s==="env"?n:n?`${s} ${n}`:s}});var Je=c((Cs,Ze)=>{"use strict";var te=require("fs"),Nn=Qe();function $n(e){let t=150,r=Buffer.alloc(t),n;try{n=te.openSync(e,"r"),te.readSync(n,r,0,t,0),te.closeSync(n)}catch{}return Nn(r.toString())}Ze.exports=$n});var rt=c((Gs,nt)=>{"use strict";var kn=require("path"),et=Ke(),tt=We(),Bn=Je(),Ln=process.platform==="win32",Mn=/\.(?:com|exe)$/i,jn=/node_modules[\\/].bin[\\/][^\\/]+\.cmd$/i;function Fn(e){e.file=et(e);let t=e.file&&Bn(e.file);return t?(e.args.unshift(e.file),e.command=t,et(e)):e.file}function Un(e){if(!Ln)return e;let t=Fn(e),r=!Mn.test(t);if(e.options.forceShell||r){let n=jn.test(t);e.command=kn.normalize(e.command),e.command=tt.command(e.command),e.args=e.args.map(o=>tt.argument(o,n));let s=[e.command].concat(e.args).join(" ");e.args=["/d","/s","/c",`"${s}"`],e.command=process.env.comspec||"cmd.exe",e.options.windowsVerbatimArguments=!0}return e}function Dn(e,t,r){t&&!Array.isArray(t)&&(r=t,t=null),t=t?t.slice(0):[],r=Object.assign({},r);let n={command:e,args:t,options:r,file:void 0,original:{command:e,args:t}};return r.shell?n:Un(n)}nt.exports=Dn});var it=c((As,ot)=>{"use strict";var ne=process.platform==="win32";function re(e,t){return Object.assign(new Error(`${t} ${e.command} ENOENT`),{code:"ENOENT",errno:"ENOENT",syscall:`${t} ${e.command}`,path:e.command,spawnargs:e.args})}function Xn(e,t){if(!ne)return;let r=e.emit;e.emit=function(n,s){if(n==="exit"){let o=st(s,t,"spawn");if(o)return r.call(e,"error",o)}return r.apply(e,arguments)}}function st(e,t){return ne&&e===1&&!t.file?re(t.original,"spawn"):null}function Hn(e,t){return ne&&e===1&&!t.file?re(t.original,"spawnSync"):null}ot.exports={hookChildProcess:Xn,verifyENOENT:st,verifyENOENTSync:Hn,notFoundError:re}});var ut=c((Rs,E)=>{"use strict";var at=require("child_process"),se=rt(),oe=it();function ct(e,t,r){let n=se(e,t,r),s=at.spawn(n.command,n.args,n.options);return oe.hookChildProcess(s,n),s}function Kn(e,t,r){let n=se(e,t,r),s=at.spawnSync(n.command,n.args,n.options);return s.error=s.error||oe.verifyENOENTSync(s.status,n),s}E.exports=ct;E.exports.spawn=ct;E.exports.sync=Kn;E.exports._parse=se;E.exports._enoent=oe});var dt=c((Os,lt)=>{"use strict";lt.exports=e=>{let t=typeof e=="string"?`
`:`
`.charCodeAt(),r=typeof e=="string"?"\r":"\r".charCodeAt();return e[e.length-1]===t&&(e=e.slice(0,e.length-1)),e[e.length-1]===r&&(e=e.slice(0,e.length-1)),e}});var mt=c((qs,O)=>{"use strict";var R=require("path"),ft=Z(),pt=e=>{e={cwd:process.cwd(),path:process.env[ft()],execPath:process.execPath,...e};let t,r=R.resolve(e.cwd),n=[];for(;t!==r;)n.push(R.join(r,"node_modules/.bin")),t=r,r=R.resolve(r,"..");let s=R.resolve(e.cwd,e.execPath,"..");return n.push(s),n.concat(e.path).join(R.delimiter)};O.exports=pt;O.exports.default=pt;O.exports.env=e=>{e={env:process.env,...e};let t={...e.env},r=ft({env:t});return e.path=t[r],t[r]=O.exports(e),t}});var St=c((_s,ie)=>{"use strict";var ht=(e,t)=>{for(let r of Reflect.ownKeys(t))Object.defineProperty(e,r,Object.getOwnPropertyDescriptor(t,r));return e};ie.exports=ht;ie.exports.default=ht});var yt=c((Ns,j)=>{"use strict";var Wn=St(),M=new WeakMap,gt=(e,t={})=>{if(typeof e!="function")throw new TypeError("Expected a function");let r,n=0,s=e.displayName||e.name||"<anonymous>",o=function(...i){if(M.set(o,++n),n===1)r=e.apply(this,i),e=null;else if(t.throw===!0)throw new Error(`Function \`${s}\` can only be called once`);return r};return Wn(o,e),M.set(o,n),o};j.exports=gt;j.exports.default=gt;j.exports.callCount=e=>{if(!M.has(e))throw new Error(`The given function \`${e.name}\` is not wrapped by the \`onetime\` package`);return M.get(e)}});var xt=c(F=>{"use strict";Object.defineProperty(F,"__esModule",{value:!0});F.SIGNALS=void 0;var Vn=[{name:"SIGHUP",number:1,action:"terminate",description:"Terminal closed",standard:"posix"},{name:"SIGINT",number:2,action:"terminate",description:"User interruption with CTRL-C",standard:"ansi"},{name:"SIGQUIT",number:3,action:"core",description:"User interruption with CTRL-\\",standard:"posix"},{name:"SIGILL",number:4,action:"core",description:"Invalid machine instruction",standard:"ansi"},{name:"SIGTRAP",number:5,action:"core",description:"Debugger breakpoint",standard:"posix"},{name:"SIGABRT",number:6,action:"core",description:"Aborted",standard:"ansi"},{name:"SIGIOT",number:6,action:"core",description:"Aborted",standard:"bsd"},{name:"SIGBUS",number:7,action:"core",description:"Bus error due to misaligned, non-existing address or paging error",standard:"bsd"},{name:"SIGEMT",number:7,action:"terminate",description:"Command should be emulated but is not implemented",standard:"other"},{name:"SIGFPE",number:8,action:"core",description:"Floating point arithmetic error",standard:"ansi"},{name:"SIGKILL",number:9,action:"terminate",description:"Forced termination",standard:"posix",forced:!0},{name:"SIGUSR1",number:10,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGSEGV",number:11,action:"core",description:"Segmentation fault",standard:"ansi"},{name:"SIGUSR2",number:12,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGPIPE",number:13,action:"terminate",description:"Broken pipe or socket",standard:"posix"},{name:"SIGALRM",number:14,action:"terminate",description:"Timeout or timer",standard:"posix"},{name:"SIGTERM",number:15,action:"terminate",description:"Termination",standard:"ansi"},{name:"SIGSTKFLT",number:16,action:"terminate",description:"Stack is empty or overflowed",standard:"other"},{name:"SIGCHLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"posix"},{name:"SIGCLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"other"},{name:"SIGCONT",number:18,action:"unpause",description:"Unpaused",standard:"posix",forced:!0},{name:"SIGSTOP",number:19,action:"pause",description:"Paused",standard:"posix",forced:!0},{name:"SIGTSTP",number:20,action:"pause",description:'Paused using CTRL-Z or "suspend"',standard:"posix"},{name:"SIGTTIN",number:21,action:"pause",description:"Background process cannot read terminal input",standard:"posix"},{name:"SIGBREAK",number:21,action:"terminate",description:"User interruption with CTRL-BREAK",standard:"other"},{name:"SIGTTOU",number:22,action:"pause",description:"Background process cannot write to terminal output",standard:"posix"},{name:"SIGURG",number:23,action:"ignore",description:"Socket received out-of-band data",standard:"bsd"},{name:"SIGXCPU",number:24,action:"core",description:"Process timed out",standard:"bsd"},{name:"SIGXFSZ",number:25,action:"core",description:"File too big",standard:"bsd"},{name:"SIGVTALRM",number:26,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGPROF",number:27,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGWINCH",number:28,action:"ignore",description:"Terminal window size changed",standard:"bsd"},{name:"SIGIO",number:29,action:"terminate",description:"I/O is available",standard:"other"},{name:"SIGPOLL",number:29,action:"terminate",description:"Watched event",standard:"other"},{name:"SIGINFO",number:29,action:"ignore",description:"Request for process information",standard:"other"},{name:"SIGPWR",number:30,action:"terminate",description:"Device running out of power",standard:"systemv"},{name:"SIGSYS",number:31,action:"core",description:"Invalid system call",standard:"other"},{name:"SIGUNUSED",number:31,action:"terminate",description:"Invalid system call",standard:"other"}];F.SIGNALS=Vn});var ae=c(I=>{"use strict";Object.defineProperty(I,"__esModule",{value:!0});I.SIGRTMAX=I.getRealtimeSignals=void 0;var zn=function(){let e=wt-bt+1;return Array.from({length:e},Yn)};I.getRealtimeSignals=zn;var Yn=function(e,t){return{name:`SIGRT${t+1}`,number:bt+t,action:"terminate",description:"Application-specific signal (realtime)",standard:"posix"}},bt=34,wt=64;I.SIGRTMAX=wt});var vt=c(U=>{"use strict";Object.defineProperty(U,"__esModule",{value:!0});U.getSignals=void 0;var Qn=require("os"),Zn=xt(),Jn=ae(),er=function(){let e=(0,Jn.getRealtimeSignals)();return[...Zn.SIGNALS,...e].map(tr)};U.getSignals=er;var tr=function({name:e,number:t,description:r,action:n,forced:s=!1,standard:o}){let{signals:{[e]:i}}=Qn.constants,a=i!==void 0;return{name:e,number:a?i:t,description:r,supported:a,action:n,forced:s,standard:o}}});var It=c(T=>{"use strict";Object.defineProperty(T,"__esModule",{value:!0});T.signalsByNumber=T.signalsByName=void 0;var nr=require("os"),Et=vt(),rr=ae(),sr=function(){return(0,Et.getSignals)().reduce(or,{})},or=function(e,{name:t,number:r,description:n,supported:s,action:o,forced:i,standard:a}){return{...e,[t]:{name:t,number:r,description:n,supported:s,action:o,forced:i,standard:a}}},ir=sr();T.signalsByName=ir;var ar=function(){let e=(0,Et.getSignals)(),t=rr.SIGRTMAX+1,r=Array.from({length:t},(n,s)=>cr(s,e));return Object.assign({},...r)},cr=function(e,t){let r=ur(e,t);if(r===void 0)return{};let{name:n,description:s,supported:o,action:i,forced:a,standard:l}=r;return{[e]:{name:n,number:e,description:s,supported:o,action:i,forced:a,standard:l}}},ur=function(e,t){let r=t.find(({name:n})=>nr.constants.signals[n]===e);return r!==void 0?r:t.find(n=>n.number===e)},lr=ar();T.signalsByNumber=lr});var Pt=c((Ms,Tt)=>{"use strict";var{signalsByName:dr}=It(),fr=({timedOut:e,timeout:t,errorCode:r,signal:n,signalDescription:s,exitCode:o,isCanceled:i})=>e?`timed out after ${t} milliseconds`:i?"was canceled":r!==void 0?`failed with ${r}`:n!==void 0?`was killed with ${n} (${s})`:o!==void 0?`failed with exit code ${o}`:"failed",pr=({stdout:e,stderr:t,all:r,error:n,signal:s,exitCode:o,command:i,escapedCommand:a,timedOut:l,isCanceled:d,killed:f,parsed:{options:{timeout:h}}})=>{o=o===null?void 0:o,s=s===null?void 0:s;let m=s===void 0?void 0:dr[s].description,S=n&&n.code,y=`Command ${fr({timedOut:l,timeout:h,errorCode:S,signal:s,signalDescription:m,exitCode:o,isCanceled:d})}: ${i}`,w=Object.prototype.toString.call(n)==="[object Error]",$=w?`${y}
${n.message}`:y,k=[$,t,e].filter(Boolean).join(`
`);return w?(n.originalMessage=n.message,n.message=k):n=new Error(k),n.shortMessage=$,n.command=i,n.escapedCommand=a,n.exitCode=o,n.signal=s,n.signalDescription=m,n.stdout=e,n.stderr=t,r!==void 0&&(n.all=r),"bufferedData"in n&&delete n.bufferedData,n.failed=!0,n.timedOut=Boolean(l),n.isCanceled=d,n.killed=f&&!l,n};Tt.exports=pr});var Gt=c((js,ce)=>{"use strict";var D=["stdin","stdout","stderr"],mr=e=>D.some(t=>e[t]!==void 0),Ct=e=>{if(!e)return;let{stdio:t}=e;if(t===void 0)return D.map(n=>e[n]);if(mr(e))throw new Error(`It's not possible to provide \`stdio\` in combination with one of ${D.map(n=>`\`${n}\``).join(", ")}`);if(typeof t=="string")return t;if(!Array.isArray(t))throw new TypeError(`Expected \`stdio\` to be of type \`string\` or \`Array\`, got \`${typeof t}\``);let r=Math.max(t.length,D.length);return Array.from({length:r},(n,s)=>t[s])};ce.exports=Ct;ce.exports.node=e=>{let t=Ct(e);return t==="ipc"?"ipc":t===void 0||typeof t=="string"?[t,t,t,"ipc"]:t.includes("ipc")?t:[...t,"ipc"]}});var At=c((Fs,X)=>{X.exports=["SIGABRT","SIGALRM","SIGHUP","SIGINT","SIGTERM"];process.platform!=="win32"&&X.exports.push("SIGVTALRM","SIGXCPU","SIGXFSZ","SIGUSR2","SIGTRAP","SIGSYS","SIGQUIT","SIGIOT");process.platform==="linux"&&X.exports.push("SIGIO","SIGPOLL","SIGPWR","SIGSTKFLT","SIGUNUSED")});var Nt=c((Us,G)=>{var u=global.process;typeof u!="object"||!u?G.exports=function(){}:(Rt=require("assert"),P=At(),Ot=/^win/i.test(u.platform),q=require("events"),typeof q!="function"&&(q=q.EventEmitter),u.__signal_exit_emitter__?p=u.__signal_exit_emitter__:(p=u.__signal_exit_emitter__=new q,p.count=0,p.emitted={}),p.infinite||(p.setMaxListeners(1/0),p.infinite=!0),G.exports=function(e,t){if(global.process===u){Rt.equal(typeof e,"function","a callback must be provided for exit handler"),C===!1&&ue();var r="exit";t&&t.alwaysLast&&(r="afterexit");var n=function(){p.removeListener(r,e),p.listeners("exit").length===0&&p.listeners("afterexit").length===0&&H()};return p.on(r,e),n}},H=function(){!C||global.process!==u||(C=!1,P.forEach(function(t){try{u.removeListener(t,K[t])}catch{}}),u.emit=W,u.reallyExit=le,p.count-=1)},G.exports.unload=H,b=function(t,r,n){p.emitted[t]||(p.emitted[t]=!0,p.emit(t,r,n))},K={},P.forEach(function(e){K[e]=function(){if(u===global.process){var r=u.listeners(e);r.length===p.count&&(H(),b("exit",null,e),b("afterexit",null,e),Ot&&e==="SIGHUP"&&(e="SIGINT"),u.kill(u.pid,e))}}}),G.exports.signals=function(){return P},C=!1,ue=function(){C||u!==global.process||(C=!0,p.count+=1,P=P.filter(function(t){try{return u.on(t,K[t]),!0}catch{return!1}}),u.emit=_t,u.reallyExit=qt)},G.exports.load=ue,le=u.reallyExit,qt=function(t){u===global.process&&(u.exitCode=t||0,b("exit",u.exitCode,null),b("afterexit",u.exitCode,null),le.call(u,u.exitCode))},W=u.emit,_t=function(t,r){if(t==="exit"&&u===global.process){r!==void 0&&(u.exitCode=r);var n=W.apply(this,arguments);return b("exit",u.exitCode,null),b("afterexit",u.exitCode,null),n}else return W.apply(this,arguments)});var Rt,P,Ot,q,p,H,b,K,C,ue,le,qt,W,_t});var kt=c((Ds,$t)=>{"use strict";var hr=require("os"),Sr=Nt(),gr=1e3*5,yr=(e,t="SIGTERM",r={})=>{let n=e(t);return xr(e,t,r,n),n},xr=(e,t,r,n)=>{if(!br(t,r,n))return;let s=vr(r),o=setTimeout(()=>{e("SIGKILL")},s);o.unref&&o.unref()},br=(e,{forceKillAfterTimeout:t},r)=>wr(e)&&t!==!1&&r,wr=e=>e===hr.constants.signals.SIGTERM||typeof e=="string"&&e.toUpperCase()==="SIGTERM",vr=({forceKillAfterTimeout:e=!0})=>{if(e===!0)return gr;if(!Number.isFinite(e)||e<0)throw new TypeError(`Expected the \`forceKillAfterTimeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`);return e},Er=(e,t)=>{e.kill()&&(t.isCanceled=!0)},Ir=(e,t,r)=>{e.kill(t),r(Object.assign(new Error("Timed out"),{timedOut:!0,signal:t}))},Tr=(e,{timeout:t,killSignal:r="SIGTERM"},n)=>{if(t===0||t===void 0)return n;let s,o=new Promise((a,l)=>{s=setTimeout(()=>{Ir(e,r,l)},t)}),i=n.finally(()=>{clearTimeout(s)});return Promise.race([o,i])},Pr=({timeout:e})=>{if(e!==void 0&&(!Number.isFinite(e)||e<0))throw new TypeError(`Expected the \`timeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`)},Cr=async(e,{cleanup:t,detached:r},n)=>{if(!t||r)return n;let s=Sr(()=>{e.kill()});return n.finally(()=>{s()})};$t.exports={spawnedKill:yr,spawnedCancel:Er,setupTimeout:Tr,validateTimeout:Pr,setExitHandler:Cr}});var Lt=c((Xs,Bt)=>{"use strict";var x=e=>e!==null&&typeof e=="object"&&typeof e.pipe=="function";x.writable=e=>x(e)&&e.writable!==!1&&typeof e._write=="function"&&typeof e._writableState=="object";x.readable=e=>x(e)&&e.readable!==!1&&typeof e._read=="function"&&typeof e._readableState=="object";x.duplex=e=>x.writable(e)&&x.readable(e);x.transform=e=>x.duplex(e)&&typeof e._transform=="function";Bt.exports=x});var jt=c((Hs,Mt)=>{"use strict";var{PassThrough:Gr}=require("stream");Mt.exports=e=>{e={...e};let{array:t}=e,{encoding:r}=e,n=r==="buffer",s=!1;t?s=!(r||n):r=r||"utf8",n&&(r=null);let o=new Gr({objectMode:s});r&&o.setEncoding(r);let i=0,a=[];return o.on("data",l=>{a.push(l),s?i=a.length:i+=l.length}),o.getBufferedValue=()=>t?a:n?Buffer.concat(a,i):a.join(""),o.getBufferedLength=()=>i,o}});var Ft=c((Ks,_)=>{"use strict";var{constants:Ar}=require("buffer"),Rr=require("stream"),{promisify:Or}=require("util"),qr=jt(),_r=Or(Rr.pipeline),de=class extends Error{constructor(){super("maxBuffer exceeded");this.name="MaxBufferError"}};async function fe(e,t){if(!e)throw new Error("Expected a stream");t={maxBuffer:1/0,...t};let{maxBuffer:r}=t,n=qr(t);return await new Promise((s,o)=>{let i=a=>{a&&n.getBufferedLength()<=Ar.MAX_LENGTH&&(a.bufferedData=n.getBufferedValue()),o(a)};(async()=>{try{await _r(e,n),s()}catch(a){i(a)}})(),n.on("data",()=>{n.getBufferedLength()>r&&i(new de)})}),n.getBufferedValue()}_.exports=fe;_.exports.buffer=(e,t)=>fe(e,{...t,encoding:"buffer"});_.exports.array=(e,t)=>fe(e,{...t,array:!0});_.exports.MaxBufferError=de});var Dt=c((Ws,Ut)=>{"use strict";var{PassThrough:Nr}=require("stream");Ut.exports=function(){var e=[],t=new Nr({objectMode:!0});return t.setMaxListeners(0),t.add=r,t.isEmpty=n,t.on("unpipe",s),Array.prototype.slice.call(arguments).forEach(r),t;function r(o){return Array.isArray(o)?(o.forEach(r),this):(e.push(o),o.once("end",s.bind(null,o)),o.once("error",t.emit.bind(t,"error")),o.pipe(t,{end:!1}),this)}function n(){return e.length==0}function s(o){e=e.filter(function(i){return i!==o}),!e.length&&t.readable&&t.end()}}});var Wt=c((Vs,Kt)=>{"use strict";var Xt=Lt(),Ht=Ft(),$r=Dt(),kr=(e,t)=>{t===void 0||e.stdin===void 0||(Xt(t)?t.pipe(e.stdin):e.stdin.end(t))},Br=(e,{all:t})=>{if(!t||!e.stdout&&!e.stderr)return;let r=$r();return e.stdout&&r.add(e.stdout),e.stderr&&r.add(e.stderr),r},pe=async(e,t)=>{if(!!e){e.destroy();try{return await t}catch(r){return r.bufferedData}}},me=(e,{encoding:t,buffer:r,maxBuffer:n})=>{if(!(!e||!r))return t?Ht(e,{encoding:t,maxBuffer:n}):Ht.buffer(e,{maxBuffer:n})},Lr=async({stdout:e,stderr:t,all:r},{encoding:n,buffer:s,maxBuffer:o},i)=>{let a=me(e,{encoding:n,buffer:s,maxBuffer:o}),l=me(t,{encoding:n,buffer:s,maxBuffer:o}),d=me(r,{encoding:n,buffer:s,maxBuffer:o*2});try{return await Promise.all([i,a,l,d])}catch(f){return Promise.all([{error:f,signal:f.signal,timedOut:f.timedOut},pe(e,a),pe(t,l),pe(r,d)])}},Mr=({input:e})=>{if(Xt(e))throw new TypeError("The `input` option cannot be a stream in sync mode")};Kt.exports={handleInput:kr,makeAllStream:Br,getSpawnedResult:Lr,validateInputSync:Mr}});var zt=c((zs,Vt)=>{"use strict";var jr=(async()=>{})().constructor.prototype,Fr=["then","catch","finally"].map(e=>[e,Reflect.getOwnPropertyDescriptor(jr,e)]),Ur=(e,t)=>{for(let[r,n]of Fr){let s=typeof t=="function"?(...o)=>Reflect.apply(n.value,t(),o):n.value.bind(t);Reflect.defineProperty(e,r,{...n,value:s})}return e},Dr=e=>new Promise((t,r)=>{e.on("exit",(n,s)=>{t({exitCode:n,signal:s})}),e.on("error",n=>{r(n)}),e.stdin&&e.stdin.on("error",n=>{r(n)})});Vt.exports={mergePromise:Ur,getSpawnedPromise:Dr}});var Zt=c((Ys,Qt)=>{"use strict";var Yt=(e,t=[])=>Array.isArray(t)?[e,...t]:[e],Xr=/^[\w.-]+$/,Hr=/"/g,Kr=e=>typeof e!="string"||Xr.test(e)?e:`"${e.replace(Hr,'\\"')}"`,Wr=(e,t)=>Yt(e,t).join(" "),Vr=(e,t)=>Yt(e,t).map(r=>Kr(r)).join(" "),zr=/ +/g,Yr=e=>{let t=[];for(let r of e.trim().split(zr)){let n=t[t.length-1];n&&n.endsWith("\\")?t[t.length-1]=`${n.slice(0,-1)} ${r}`:t.push(r)}return t};Qt.exports={joinCommand:Wr,getEscapedCommand:Vr,parseCommand:Yr}});var on=c((Qs,A)=>{"use strict";var Qr=require("path"),he=require("child_process"),Zr=ut(),Jr=dt(),es=mt(),ts=yt(),V=Pt(),Jt=Gt(),{spawnedKill:ns,spawnedCancel:rs,setupTimeout:ss,validateTimeout:os,setExitHandler:is}=kt(),{handleInput:as,getSpawnedResult:cs,makeAllStream:us,validateInputSync:ls}=Wt(),{mergePromise:en,getSpawnedPromise:ds}=zt(),{joinCommand:tn,parseCommand:nn,getEscapedCommand:rn}=Zt(),fs=1e3*1e3*100,ps=({env:e,extendEnv:t,preferLocal:r,localDir:n,execPath:s})=>{let o=t?{...process.env,...e}:e;return r?es.env({env:o,cwd:n,execPath:s}):o},sn=(e,t,r={})=>{let n=Zr._parse(e,t,r);return e=n.command,t=n.args,r=n.options,r={maxBuffer:fs,buffer:!0,stripFinalNewline:!0,extendEnv:!0,preferLocal:!1,localDir:r.cwd||process.cwd(),execPath:process.execPath,encoding:"utf8",reject:!0,cleanup:!0,all:!1,windowsHide:!0,...r},r.env=ps(r),r.stdio=Jt(r),process.platform==="win32"&&Qr.basename(e,".exe")==="cmd"&&t.unshift("/q"),{file:e,args:t,options:r,parsed:n}},N=(e,t,r)=>typeof t!="string"&&!Buffer.isBuffer(t)?r===void 0?void 0:"":e.stripFinalNewline?Jr(t):t,z=(e,t,r)=>{let n=sn(e,t,r),s=tn(e,t),o=rn(e,t);os(n.options);let i;try{i=he.spawn(n.file,n.args,n.options)}catch(S){let g=new he.ChildProcess,y=Promise.reject(V({error:S,stdout:"",stderr:"",all:"",command:s,escapedCommand:o,parsed:n,timedOut:!1,isCanceled:!1,killed:!1}));return en(g,y)}let a=ds(i),l=ss(i,n.options,a),d=is(i,n.options,l),f={isCanceled:!1};i.kill=ns.bind(null,i.kill.bind(i)),i.cancel=rs.bind(null,i,f);let m=ts(async()=>{let[{error:S,exitCode:g,signal:y,timedOut:w},$,k,pn]=await cs(i,n.options,d),Se=N(n.options,$),ge=N(n.options,k),ye=N(n.options,pn);if(S||g!==0||y!==null){let xe=V({error:S,exitCode:g,signal:y,stdout:Se,stderr:ge,all:ye,command:s,escapedCommand:o,parsed:n,timedOut:w,isCanceled:f.isCanceled,killed:i.killed});if(!n.options.reject)return xe;throw xe}return{command:s,escapedCommand:o,exitCode:0,stdout:Se,stderr:ge,all:ye,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}});return as(i,n.options.input),i.all=us(i,n.options),en(i,m)};A.exports=z;A.exports.sync=(e,t,r)=>{let n=sn(e,t,r),s=tn(e,t),o=rn(e,t);ls(n.options);let i;try{i=he.spawnSync(n.file,n.args,n.options)}catch(d){throw V({error:d,stdout:"",stderr:"",all:"",command:s,escapedCommand:o,parsed:n,timedOut:!1,isCanceled:!1,killed:!1})}let a=N(n.options,i.stdout,i.error),l=N(n.options,i.stderr,i.error);if(i.error||i.status!==0||i.signal!==null){let d=V({stdout:a,stderr:l,error:i.error,signal:i.signal,exitCode:i.status,command:s,escapedCommand:o,parsed:n,timedOut:i.error&&i.error.code==="ETIMEDOUT",isCanceled:!1,killed:i.signal!==null});if(!n.options.reject)return d;throw d}return{command:s,escapedCommand:o,exitCode:0,stdout:a,stderr:l,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}};A.exports.command=(e,t)=>{let[r,...n]=nn(e);return z(r,n,t)};A.exports.commandSync=(e,t)=>{let[r,...n]=nn(e);return z.sync(r,n,t)};A.exports.node=(e,t,r={})=>{t&&!Array.isArray(t)&&typeof t=="object"&&(r=t,t=[]);let n=Jt.node(r),s=process.execArgv.filter(a=>!a.startsWith("--inspect")),{nodePath:o=process.execPath,nodeOptions:i=s}=r;return z(o,[...i,e,...Array.isArray(t)?t:[]],{...r,stdin:void 0,stdout:void 0,stderr:void 0,stdio:n,shell:!1})}});var hs={};xn(hs,{default:()=>ms});var ln=require("@raycast/api");var an=ve(require("process"),1),cn=ve(on(),1);async function un(e){if(an.default.platform!=="darwin")throw new Error("macOS only");let{stdout:t}=await(0,cn.default)("osascript",["-e",e]);return t}function dn(e){return`
    tell application "Spotify"
      if not application "Spotify" is running then
        activate

        set _maxOpenWaitTimeInSeconds to 5
        set _openCounter to 1
        repeat until application "Spotify" is running
          delay 1
          set _openCounter to _openCounter + 1
          if _openCounter > _maxOpenWaitTimeInSeconds then exit repeat
        end repeat
      end if
      ${e}
    end tell`}async function fn(e){await(0,ln.closeMainWindow)(),await un(e)}var ms=async()=>{let e=dn(`
    set shuffling to true
    set spotify_playing to (player state = playing)
    if not spotify_playing then
      play
    end if
  `);await fn(e)};module.exports=bn(hs);0&&(module.exports={});
