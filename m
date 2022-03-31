Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7BD4ED0CB
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Mar 2022 02:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350985AbiCaAVk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Mar 2022 20:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiCaAVk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:21:40 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E061FCD1
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Mar 2022 17:19:53 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id A2EE75896D01B; Thu, 31 Mar 2022 02:19:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id A09AB60D3344D;
        Thu, 31 Mar 2022 02:19:51 +0200 (CEST)
Date:   Thu, 31 Mar 2022 02:19:51 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Phil Sutter <phil@nwl.cc>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 9/9] extensions: DNAT: Support service names in
 all spots
In-Reply-To: <YkTEM8r6tv+fkOOK@orbyte.nwl.cc>
Message-ID: <935op3q3-s38p-674r-1n2n-8spr98o7s37@vanv.qr>
References: <20220330155851.13249-1-phil@nwl.cc> <20220330155851.13249-10-phil@nwl.cc> <89qp85o0-704s-5280-sqp6-s71so14n7487@vanv.qr> <YkTEM8r6tv+fkOOK@orbyte.nwl.cc>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2022-03-30 22:57, Phil Sutter wrote:
>> >+-p tcp -j DNAT --to-destination 1.1.1.1:echo-ftp-data/ssh;-p tcp -j DNAT --to-destination 1.1.1.1:7-20/22;OK
>> 
>> This looks dangerous. It is why I originally never allowed service names in
>> port ranges that use dash as the range character.
>
>Guess if someone is able to manipulate /etc/services, any service names
>are problematic, not just in ranges.

Well, pretty much anyone has a shot at manipulating this file. File a
port registration with IANA, and when your distro updates the file,
eventually there is a chance of messing up firewall configs,
worldwide.

Other than that, thanks to nsswitch, the service list can also be in
LDAP or so, and then all that's needed is a disgruntled LDAP admin
who dislikes the firewall admin.

>Another potential problem I didn't have in mind though is that 'a-b'
>could mean [a; b] or [a-b] assuming that all three exist. But I haven't
>found a valid example in my /etc/services, yet. :)

I found 25 at once!

914c :: 914c-g :: g-talk
ads :: ads-s :: s-openmail
bctp :: bctp-server :: server-find
cis :: cis-secure :: secure-mqtt
connect :: connect-server :: server-find
docker :: docker-s :: s-openmail
documentum :: documentum-s :: s-openmail
domain :: domain-s :: s-openmail
dtp :: dtp-net :: net-device
genie :: genie-lm :: lm-mon
linktest :: linktest-s :: s-openmail
mailbox :: mailbox-lm :: lm-mon
mbap :: mbap-s :: s-openmail
ns :: ns-server :: server-find
plato :: plato-lm :: lm-mon
rmonitor :: rmonitor-secure :: secure-mqtt
sentinel :: sentinel-lm :: lm-mon
sitewatch :: sitewatch-s :: s-openmail
spss :: spss-lm :: lm-mon
sql :: sql-net :: net-device
tacacs :: tacacs-ds :: ds-slp
tl1 :: tl1-lv :: lv-auth
trim :: trim-ice :: ice-router
wnn6 :: wnn6-ds :: ds-slp
wsdapi :: wsdapi-s :: s-openmail

To be read as: "wsdapi-s-openmail" is ambiguous, because
it allows for two interpretations (and all four port names are in
/etc/services):

	[wsdapi]-[s-openmail]
	[wsdapi-s]-[openmail]


>> The "solution" would be to use : as the range character, but that would require
>> a new --dport option for reasons of command-line compatibility.
>
>Well, we could allow both (a-b with numeric a and b only) and use it in
>output only if non-numeric was requested.

Given I'm seeing "914c" in the IANA list (leading digits always stand
out from the crowd, e.g. you don't normally see them in UNIX
usernames either), I won't hold my breath that no one would try to
register "914-915".
