Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D20585A27
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Jul 2022 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiG3Kn4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 30 Jul 2022 06:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiG3Knz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 30 Jul 2022 06:43:55 -0400
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [IPv6:2001:738:5001::45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937752CDDE
        for <netfilter-devel@vger.kernel.org>; Sat, 30 Jul 2022 03:43:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp0.kfki.hu (Postfix) with ESMTP id 9473267400F6;
        Sat, 30 Jul 2022 12:43:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smtp0.kfki.hu
Received: from smtp0.kfki.hu ([127.0.0.1])
        by localhost (smtp0.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Sat, 30 Jul 2022 12:43:44 +0200 (CEST)
Received: from localhost.kfki.hu (host-94-248-211-146.kabelnet.hu [94.248.211.146])
        (Authenticated sender: kadlecsik.jozsef@wigner.hu)
        by smtp0.kfki.hu (Postfix) with ESMTPSA id 2756867400DA;
        Sat, 30 Jul 2022 12:43:44 +0200 (CEST)
Received: by localhost.kfki.hu (Postfix, from userid 1000)
        id 9AFF63C1C23; Sat, 30 Jul 2022 12:43:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by localhost.kfki.hu (Postfix) with ESMTP id 9867E3C0666;
        Sat, 30 Jul 2022 12:43:43 +0200 (CEST)
Date:   Sat, 30 Jul 2022 12:43:43 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@netfilter.org>
To:     "U'ren, Aaron" <Aaron.U'ren@sony.com>
cc:     Jakub Kicinski <kuba@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "McLean, Patrick" <Patrick.Mclean@sony.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "Brown, Russell" <Russell.Brown@sony.com>,
        "Rueger, Manuel" <manuel.rueger@sony.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Florian Westphal <fw@strlen.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: Intermittent performance regression related to ipset between
 5.10 and 5.15
In-Reply-To:  <DM6PR13MB3098595DDA86DE7103ED3FA0C8999@DM6PR13MB3098.namprd13.prod.outlook.com>
Message-ID: <23523a38-f6f2-2531-aa1b-674c11229440@netfilter.org>
References: <BY5PR13MB3604D24C813A042A114B639DEE109@BY5PR13MB3604.namprd13.prod.outlook.com> <5e56c644-2311-c094-e099-cfe0d574703b@leemhuis.info> <c28ed507-168e-e725-dddd-b81fadaf6aa5@leemhuis.info> <b1bfbc2f-2a91-9d20-434d-395491994de@netfilter.org>
 <96e12c14-eb6d-ae07-916b-7785f9558c67@leemhuis.info> <DM6PR13MB3098E6B746264B4F96D9F743C8C39@DM6PR13MB3098.namprd13.prod.outlook.com> <2d9479bd-93bd-0cf1-9bc9-591ab3b2bdec@leemhuis.info> <6f6070ff-b50-1488-7e9-322be08f35b9@netfilter.org>
 <871bc2cb-ae4b-bc2a-1bd8-1315288957c3@leemhuis.info> <DM6PR13MB309846DD4673636DF440000EC8BA9@DM6PR13MB3098.namprd13.prod.outlook.com> <20220630110443.100f8aa9@kernel.org> <d44d3522-ac1f-a1e-ddf6-312c7b25d685@netfilter.org>
 <DM6PR13MB309813DF3769F48E5DE2EB6EC8829@DM6PR13MB3098.namprd13.prod.outlook.com>  <DM6PR13MB3098595DDA86DE7103ED3FA0C8999@DM6PR13MB3098.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1904593926-1659177823=:2522"
X-deepspam: ham 0%
X-Spam-Status: No, score=-0.9 required=5.0 tests=APOSTROPHE_TOCC,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1904593926-1659177823=:2522
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Aaron,

On Fri, 29 Jul 2022, U'ren, Aaron wrote:

> Thanks for all of your help with this issue. I think that we can close=20
> this out now.
>=20
> After continuing to dig into this problem some more, I eventually=20
> figured out that the problem was caused because of how our userspace=20
> tooling was interacting with ipset save / restore and the new (ish)=20
> initval option that is included in saves / restores.
>=20
> Specifically, kube-router runs an ipset save then processes the saved=20
> ipset data, messages it a bit based upon the state from the Kubernetes=20
> cluster, and then runs that data back through ipset restore. During thi=
s=20
> time, we create unique temporary sets based upon unique sets of options=
=20
> and then rotate in the new endpoints into the temporary set and then us=
e=20
> swap instructions in order to minimize impact to the data path.
>=20
> However, because we were only messaging options that were recognized an=
d=20
> important to us, initval was left alone and blindly copied into our=20
> option strings for new and temporary sets. This caused initval to be=20
> used incorrectly (i.e. the same initval ID was used for multiple sets).=
=20
> I'm not 100% sure about all of the consequences of this, but it seems t=
o=20
> have objectively caused some performance issues.

It's hard to say. initval is actually the arbitrary initial value for the=
=20
jhash() macro in the kernel. The same initval is used for every element i=
n=20
a hash, so it's tied to the hash.

Earlier, initval was a totally hidden internal parameter in ipset. That=20
meant that save/restore could possibly not create a restored set which wa=
s=20
identical with the saved one: hash size could be different; list of=20
clashing elements could be different. Therefore I added the ability to=20
save and restore initval as well.

> Additionally, since initval is intentionally unique between sets, this=20
> caused us to create many more temporary sets for swapping than was=20
> actually necessary. This caused obvious performance issues as restores=20
> now contained more instructions than they needed to.
>=20
> Reverting the commit removed the issue we saw because it removed the=20
> portion of the kernel that generated the initvals which caused ipset=20
> save to revert to its previous (5.10 and below) functionality.=20
> Additionally, applying your patches also had the same impact because=20
> while I believed I was updating our userspace ipset tools in tandem, I=20
> found that the headers were actually being copied in from an alternate=20
> location and were still using the vanilla headers. This meant that whil=
e=20
> the kernel was generating initval values, the userspace actually=20
> recognized it as IPSET_ATTR_GC values which were then unused.
>=20
> This was a very long process to come to such a simple recognition about=
=20
> the ipset save / restore format having been changed. I apologize for th=
e=20
> noise.

I simply could not imagine a scenario where exposing the initval value=20
could result in any kind of regression...

Just to make sure I understood completely: what is your solution for the=20
problem, then? Working with a patched kernel, which removes passing=20
initval to userspace? Patched ipset tool, which does not send it? Modifie=
d=20
tooling, which ignores the initval parameter?

I really appreciate your hard work!

Best regards,
Jozsef
=20
> From: U'ren, Aaron <Aaron.U'ren@sony.com>
> Date: Friday, July 8, 2022 at 3:08 PM
> To: Jozsef Kadlecsik <kadlec@netfilter.org>, Jakub Kicinski <kuba@kerne=
l.org>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>, McLean, Patrick <Pat=
rick.Mclean@sony.com>, Pablo Neira Ayuso <pablo@netfilter.org>, netfilter=
-devel@vger.kernel.org <netfilter-devel@vger.kernel.org>, Brown, Russell =
<Russell.Brown@sony.com>, Rueger, Manuel <manuel.rueger@sony.com>, linux-=
kernel@vger.kernel.org <linux-kernel@vger.kernel.org>, regressions@lists.=
linux.dev <regressions@lists.linux.dev>, Florian Westphal <fw@strlen.de>,=
 netdev@vger.kernel.org <netdev@vger.kernel.org>
> Subject: Re: Intermittent performance regression related to ipset betwe=
en 5.10 and 5.15
> Jozsef / Jakub-
>=20
> Given your latest email and the fact that just adding back in IPSET_ATT=
R_GC doesn't shed any light on the issue I wanted to spend a lot more tim=
e testing. Also, I wanted to try to provide as much context for this issu=
e as possible.
>=20
> I think that the iptables slowness is just a symptom not the cause of t=
he issue. After spending a lot more time with it, I can see that iptables=
 only runs slowly when an existing "ipset restore" process is being run b=
y kube-router simultaneously. Given the other information that you've pro=
vided, my hunch is that iptables slows down when ipset restore is running=
 because they are both vying for the same mutex? Anyway, I think troubles=
hooting it from the direction of iptables slowness is likely the wrong pa=
th to go down.
>=20
> The true problem seems to be that when IPSET_ATTR_GC is not included, s=
omehow nodes are able to get into a state where "ipset restore" goes from=
 completing in less than a 10th of a second, to taking 30 seconds to a mi=
nute to complete. The hard part, is that I still don't know what causes a=
 node to enter this state.
>=20
> I have a Kubernetes cluster of about 7 nodes that I can reliably get in=
to this state, but I have yet to be able to reproduce it consistently any=
where else. Other clusters will randomly exhibit the issue if IPSET_ATTR_=
GC is left out of the kernel, but not consistently. Since the email where=
 we found the commit about 2 weeks ago, we have also been running 6 clust=
ers of 9+ nodes with IPSET_ATTR_GC enabled and have not had any issues.
>=20
> Since we have a custom kernel configuration, I have also tried using th=
e vanilla Ubuntu kernel configuration (taken from 5.15.0-40-generic) as w=
ell just to ensure that we didn't have some errant configuration option e=
nabled. However, this also reliably reproduced the issue when IPSET_ATTR_=
GC was removed and just as reliably removed the issue when IPSET_ATTR_GC =
was added back in.
>=20
> I have also verified that neither ipset, iptables, or any of its depend=
ent libraries have references to IPSET_ATTR_GC, going as far as to remove=
 it from the ipset header file (https://git.netfilter.org/iptables/tree/i=
nclude/linux/netfilter/ipset/ip_set.h#n86) and rebuild it (and all of the=
 libraries and other tools) from scratch just as a hail mary. No changes =
to user-space seem to have an effect on this issue.
>=20
> One other thing that I've done to help track down the issue is to add d=
ebug options to kube-router so that it outputs the file that it feeds int=
o "ipset restore -exist". With this file, on nodes affected by this issue=
, I can reliably reproduce the issue by calling "ipset restore -exist <fi=
le" and see that it takes 30+ seconds to execute.
>=20
> In a hope that maybe it sheds some light and gives you some more contex=
t, I'm going to be sending you and Jakub a copy of the strace and the ips=
et file that was used separately from this email.
>=20
> At this point, I'm not sure how to proceed other than with the files th=
at I'll be sending you. I'm highly confident that somehow the removal of =
IPSET_ATTR_GC is causing the issues that we see. At this point I've added=
 and removed the options almost 20 times and done reboots across our clus=
ter. Anytime that variable is missing, we see several nodes exhibit the p=
erformance issues immediately. Any time the variable is present, we see n=
o nodes exhibit the performance issues.
>=20
> Looking forward to hearing back from you and getting to the bottom of t=
his very bizarre issue.
>=20
> -Aaron
>=20
> From: Jozsef Kadlecsik <kadlec@netfilter.org>
> Date: Saturday, July 2, 2022 at 12:41 PM
> To: Jakub Kicinski <kuba@kernel.org>
> Cc: U'ren, Aaron <Aaron.U'ren@sony.com>, Thorsten Leemhuis <regressions=
@leemhuis.info>, McLean, Patrick <Patrick.Mclean@sony.com>, Pablo Neira A=
yuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org <netfilter-de=
vel@vger.kernel.org>, Brown, Russell <Russell.Brown@sony.com>, Rueger, Ma=
nuel <manuel.rueger@sony.com>, linux-kernel@vger.kernel.org <linux-kernel=
@vger.kernel.org>, regressions@lists.linux.dev <regressions@lists.linux.d=
ev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org <netdev@vger=
.kernel.org>
> Subject: Re: Intermittent performance regression related to ipset betwe=
en 5.10 and 5.15
> Hi,
>=20
> On Thu, 30 Jun 2022, Jakub Kicinski wrote:
>=20
> > Sounds like you're pretty close to figuring this out! Can you check=20
> > if the user space is intentionally setting IPSET_ATTR_INITVAL?
> > Either that or IPSET_ATTR_GC was not as "unused" as initially thought=
.
>=20
> IPSET_ATTR_GC was really unused. It was an old remnant from the time wh=
en=20
> ipset userspace-kernel communication was through set/getsockopt. Howeve=
r,=20
> when it was migrated to netlink, just the symbol was kept but it was no=
t=20
> used either with the userspace tool or the kernel.
>=20
> Aaron, could you send me how to reproduce the issue? I have no idea how=
=20
> that patch could be the reason. Setting/getting/using IPSET_ATTR_INITVA=
L=20
> is totally independent from listing iptables rules. But if you have got=
 a=20
> reproducer then I can dig into it.
>=20
> Best regards,
> Jozsef
>=20
> > Testing something like this could be a useful data point:
> >=20
> > diff --git a/include/uapi/linux/netfilter/ipset/ip_set.h b/include/ua=
pi/linux/netfilter/ipset/ip_set.h
> > index 6397d75899bc..7caf9b53d2a7 100644
> > --- a/include/uapi/linux/netfilter/ipset/ip_set.h
> > +++ b/include/uapi/linux/netfilter/ipset/ip_set.h
> > @@ -92,7 +92,7 @@ enum {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Reserve empty slots */
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_CADT_MAX =3D 16,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Create-only specific att=
ributes */
> > -=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_INITVAL,=C2=A0=C2=A0=C2=A0=C2=A0=
 /* was unused IPSET_ATTR_GC */
> > +=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_GC,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_HASHSIZE,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_MAXELEM,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_NETMASK,
> > @@ -104,6 +104,8 @@ enum {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_REFERENCES,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_MEMSIZE,
> >=C2=A0=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0 IPSET_ATTR_INITVAL,
> > +
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __IPSET_ATTR_CREATE_MAX,
> >=C2=A0 };
> >=C2=A0 #define IPSET_ATTR_CREATE_MAX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (__IPSET_ATTR_CREATE_MAX - 1)
> >=20
> >=20
> > On Thu, 30 Jun 2022 14:59:14 +0000 U'ren, Aaron wrote:
> > > Thorsten / Jozsef -
> > >=20
> > > Thanks for continuing to follow up! I'm sorry that this has moved s=
o slow, it has taken us a bit to find the time to fully track this issue =
down, however, I think that we have figured out enough to make some more =
forward progress on this issue.
> > >=20
> > > Jozsef, thanks for your insight into what is happening between thos=
e system calls. In regards to your question about wait/wound mutex debugg=
ing possibly being enabled, I can tell you that we definitely don't have =
that enabled on any of our regular machines. While we were debugging we d=
id turn on quite a few debug options to help us try and track this issue =
down and it is very possible that the strace that was taken that started =
off this email was taken on a machine that did have that debug option ena=
bled. Either way though, the root issue occurs on hosts that definitely d=
o not have wait/wound mutex debugging enabled.
> > >=20
> > > The good news is that we finally got one of our development environ=
ments into a state where we could reliably reproduce the performance issu=
e across reboots. This was a win because it meant that we were able to do=
 a full bisect of the kernel and were able to tell relatively quickly whe=
ther or not the issue was present in the test kernels.
> > >=20
> > > After bisecting for 3 days, I have been able to narrow it down to a=
 single commit: https://urldefense.com/v3/__https:/git.kernel.org/pub/scm=
/linux/kernel/git/torvalds/linux.git/commit/?id=3D3976ca101990ca11ddf51f3=
8bec7b86c19d0ca6f__;!!JmoZiZGBv3RvKRSx!9YR_bFOCOkQzPaUftFL2NvuKLm8zPa4tQr=
_DI8CUZEenjK4Rak_OFmUrCpmiNOaUaiueGbgsEqk0IirIc4I$=C2=A0 (netfilter: ipse=
t: Expose the initval hash parameter to userspace)
> > >=20
> > > I'm at a bit of a loss as to why this would cause such severe perfo=
rmance regressions, but I've proved it out multiple times now. I've even =
checked out a fresh version of the 5.15 kernel that we've been deploying =
with just this single commit reverted and found that the performance prob=
lems are completely resolved.
> > >=20
> > > I'm hoping that maybe Jozsef will have some more insight into why t=
his seemingly innocuous commit causes such larger performance issues for =
us? If you have any additional patches or other things that you would lik=
e us to test I will try to leave our environment in its current state for=
 the next couple of days so that we can do so.
> > >=20
> > > -Aaron
> > >=20
> > > From: Thorsten Leemhuis <regressions@leemhuis.info>
> > > Date: Monday, June 20, 2022 at 2:16 AM
> > > To: U'ren, Aaron <Aaron.U'ren@sony.com>
> > > Cc: McLean, Patrick <Patrick.Mclean@sony.com>, Pablo Neira Ayuso <p=
ablo@netfilter.org>, netfilter-devel@vger.kernel.org <netfilter-devel@vge=
r.kernel.org>, Brown, Russell <Russell.Brown@sony.com>, Rueger, Manuel <m=
anuel.rueger@sony.com>, linux-kernel@vger.kernel.org <linux-kernel@vger.k=
ernel.org>, regressions@lists.linux.dev <regressions@lists.linux.dev>, Fl=
orian Westphal <fw@strlen.de>, netdev@vger.kernel.org <netdev@vger.kernel=
.org>, Jozsef Kadlecsik <kadlec@netfilter.org>
> > > Subject: Re: Intermittent performance regression related to ipset b=
etween 5.10 and 5.15
> > > On 31.05.22 09:41, Jozsef Kadlecsik wrote:
> > > > On Mon, 30 May 2022, Thorsten Leemhuis wrote:=C2=A0=20
> > > >> On 04.05.22 21:37, U'ren, Aaron wrote:=C2=A0=20
> > >=C2=A0 [...]=C2=A0=20
> > > >=20
> > > > Every set lookups behind "iptables" needs two getsockopt() calls:=
 you can=20
> > > > see them in the strace logs. The first one check the internal pro=
tocol=20
> > > > number of ipset and the second one verifies/gets the processed se=
t (it's=20
> > > > an extension to iptables and therefore there's no internal state =
to save=20
> > > > the protocol version number).=C2=A0=20
> > >=20
> > > Hi Aaron! Did any of the suggestions from Jozsef help to track down=
 the
> > > root case? I have this issue on the list of tracked regressions and
> > > wonder what the status is. Or can I mark this as resolved?
> > >=20
> > > Side note: this is not a "something breaks" regressions and it seem=
s to
> > > progress slowly, so I'm putting it on the backburner:
> > >=20
> > > #regzbot backburner: performance regression where the culprit is ha=
rd to
> > > track down
> > >=20
> > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'=
 hat)
> > >=20
> > > P.S.: As the Linux kernel's regression tracker I deal with a lot of
> > > reports and sometimes miss something important when writing mails l=
ike
> > > this. If that's the case here, don't hesitate to tell me in a publi=
c
> > > reply, it's in everyone's interest to set the public record straigh=
t.
> > >=20
> > >=C2=A0 [...]=C2=A0=20
> > > >=20
> > > > In your strace log
> > > >=20
> > > > 0.000024 getsockopt(4, SOL_IP, 0x53 /* IP_??? */, "\0\1\0\0\7\0\0=
\0", [8]) =3D 0 <0.000024>
> > > > 0.000046 getsockopt(4, SOL_IP, 0x53 /* IP_??? */, "\7\0\0\0\7\0\0=
\0KUBE-DST-VBH27M7NWLDOZIE"..., [40]) =3D 0 <0.1$
> > > > 0.109456 close(4)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0 <0.000022>
> > > >=20
> > > > the only things which happen in the second sockopt function are t=
o lock=20
> > > > the NFNL_SUBSYS_IPSET mutex, walk the array of the sets, compare =
the=20
> > > > setname, save the result in the case of a match and unlock the mu=
tex.=20
> > > > Nothing complicated, no deep, multi-level function calls. Just a =
few line=20
> > > > of codes which haven't changed.
> > > >=20
> > > > The only thing which can slow down the processing is the mutex ha=
ndling.=20
> > > > Don't you have accidentally wait/wound mutex debugging enabled in=
 the=20
> > > > kernel? If not, then bisecting the mutex related patches might he=
lp.
> > > >=20
> > > > You wrote that flushing tables or ipsets didn't seem to help. Tha=
t=20
> > > > literally meant flushing i.e. the sets were emptied but not destr=
oyed? Did=20
> > > > you try both destroying or flushing?
> > > >=C2=A0=C2=A0=20
> > > >> Jozsef, I still have this issue on my list of tracked regression=
s and it
> > > >> looks like nothing happens since above mail (or did I miss it?).=
 Could
> > > >> you maybe provide some guidance to Aaron to get us all closer to=
 the
> > > >> root of the problem?=C2=A0=20
> > > >=20
> > > > I really hope it's an accidentally enabled debugging option in th=
e kernel.=20
> > > > Otherwise bisecting could help to uncover the issue.
> > > >=20
> > > > Best regards,
> > > > Jozsef
> > > >=C2=A0=C2=A0=20
> > > >> P.S.: As the Linux kernel's regression tracker I deal with a lot=
 of
> > > >> reports and sometimes miss something important when writing mail=
s like
> > > >> this. If that's the case here, don't hesitate to tell me in a pu=
blic
> > > >> reply, it's in everyone's interest to set the public record stra=
ight.
> >=20
>=20
> -
> E-mail=C2=A0 : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
> PGP key : https://urldefense.com/v3/__https:/wigner.hu/*kadlec/pgp_publ=
ic_key.txt__;fg!!JmoZiZGBv3RvKRSx!9YR_bFOCOkQzPaUftFL2NvuKLm8zPa4tQr_DI8C=
UZEenjK4Rak_OFmUrCpmiNOaUaiueGbgsEqk0Udypzvg$=20
> Address : Wigner Research Centre for Physics
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 H-1525 Budapest =
114, POB. 49, Hungary
>=20

-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.hu
PGP key : https://wigner.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics
          H-1525 Budapest 114, POB. 49, Hungary
--8323328-1904593926-1659177823=:2522--
